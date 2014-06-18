/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong
{
import core.implementations.Debug;

import flash.display.Stage;

import mahjong.models.game.ManagerGame;
import mahjong.models.level.LevelContainer;
import mahjong.models.level.LevelInfo;
import mahjong.models.plaeyr.PlayerInfo;
import mahjong.models.proxy.ManagerProxy;
import mahjong.models.remote.ManagerRemoteStub;
import mahjong.models.response.Response;
import mahjong.models.sounds.ManagerSounds;
import mahjong.models.string.ManagerString;
import mahjong.states.EStateType;
import mahjong.states.game.StateGame;
import mahjong.states.main.StateMain;
import mahjong.states.selectionLevel.StateSelectionLevel;

import models.implementations.app.ManagerAppBase;
import models.implementations.bonus.ManagerBonusBase;
import models.implementations.levels.ManagerLevelsBase;
import models.implementations.players.ManagerPlayersBase;
import models.implementations.purchases.ManagerPurchasesBase;
import models.implementations.purchases.PurchaseItemBase;
import models.implementations.resources.ManagerResourceBase;
import models.implementations.states.ManagerStatesBase;
import models.implementations.views.ManagerViewsBase;
import models.interfaces.IManagerGame;
import models.interfaces.levels.ILevelInfo;
import models.interfaces.remote.ERemoteResponseTypeBase;
import models.interfaces.remote.EResponseStatus;
import models.interfaces.remote.IResponse;

public class GameInfo extends GameInfoBase
{
    /*
     * Static fields
     */
    private static var _instanceTyped:GameInfo;

    /*
     * Static methods
     */
    public static function run(stageValue:Stage):void
    {
        Debug.assert(_instance == null, "GameInfo already initialized.");
        Debug.assert(_instanceTyped == null, "GameInfo already initialized.");

        _instanceTyped = new GameInfo(stageValue);
        _instance = _instanceTyped;
    }

    public static function get instance():GameInfo
    {
        return _instanceTyped;
    }

    /*
     * Fields
     */
    private var _managerGame:ManagerGame;

    //TODO:Remove
    private var _response:IResponse;

    /*
     * Properties
     */
    public function get managerGame():ManagerGame
    {
        return _managerGame;
    }

    public function get response():IResponse
    {
        return _response;
    }

    /*
     * Events
     */
    override public function onInitCurrentLanguage(languageType:String):void
    {
        Debug.assert(_managerString == null, 'manager string already established');

        _managerString = new ManagerString(languageType);
    }

    protected override function onInitSocialComplete():void
    {
        _managerRemote = new ManagerRemoteStub(Constants.REMOTE_SERVER, _managerSocial);

        super.onInitSocialComplete();
    }

    protected override function onRemoteGameInitComplete(response:IResponse):void
    {
        //TODO:remove
        var objectResponse:Object =
        {
            response: ManagerProxy.getResponseData(),
            status  : "ok"
        };

        _response = new Response();
        _response.deserialize(objectResponse);

        _managerResources = new ManagerResourceBase();

        _managerApp = new ManagerAppBase(_stage);

        _managerStates = new ManagerStatesBase();

        _managerPlayers = new ManagerPlayersBase(PlayerInfo);
        _managerPlayers.deserialize(_response.entry["players"]);

        _managerLevels = new ManagerLevelsBase(LevelContainer, LevelInfo);
        _managerLevels.deserialize(_response.entry["levels"]);

        _managerPurchases = new ManagerPurchasesBase(PurchaseItemBase);
        _managerPurchases.deserialize(_response.entry["purchases"]);

        _managerBonus = new ManagerBonusBase();
        _managerBonus.deserialize(_response.entry["bonus"]);

        _managerSounds = new ManagerSounds();

        _managerViews = new ManagerViewsBase();


        {   //register states
            _managerStates.registerState(EStateType.EST_MAIN, StateMain);
            _managerStates.registerState(EStateType.EST_SELECT_LEVEL, StateSelectionLevel);
            _managerStates.registerState(EStateType.EST_GAME, StateGame);
        }


        GameInfo.instance.managerStates.setState(EStateType.EST_MAIN);
//        GameInfo.instance.managerStates.setState(EStateType.EST_SELECT_LEVEL);

//        startStubGame();


        super.onRemoteGameInitComplete(_response);
    }


    public override function onGameStart(value:IManagerGame):void
    {
        super.onGameStart(value);

        Debug.assert(value is ManagerGame);

        _managerGame = value as ManagerGame;
    }


    /*
     * Methods
     */
    public function GameInfo(stageValue:Stage)
    {
        super(stageValue);

        initSocialManager();
    }

    private function startStubGame():void
    {
        var nextLevel:ILevelInfo = GameInfo.instance.managerLevels.firstIncompleteLevelOpen;

        if (nextLevel == null)
        {
            _managerStates.setState(EStateType.EST_MAIN);
        }
        else
        {
            GameInfoBase.instance.managerRemote.update(ERemoteResponseTypeBase.ERRTB_LEVEL_START, nextLevel,
                    function (response:IResponse):void
                    {
                        if (response.status == EResponseStatus.ERS_OK)
                        {
                            var managerGame:IManagerGame = new ManagerGame(nextLevel);

                            GameInfo.instance.onGameStart(managerGame);

                            GameInfo.instance.managerStates.setState(EStateType.EST_GAME);
                        }
                        else
                        {
                            Debug.assert(false, "Can't start stub game")
                        }

                    });
        }
    }
}
}
