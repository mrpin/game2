/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong
{
import flash.display.Stage;

import mahjong.models.data.LevelInfo;

import mahjong.models.game.ManagerGame;
import mahjong.models.level.ManagerLevels;
import mahjong.models.proxy.ManagerProxy;
import mahjong.models.remote.ManagerRemoteStub;
import mahjong.models.string.ManagerString;
import mahjong.states.EStateType;
import mahjong.states.game.StateGame;
import mahjong.states.main.StateMain;

import models.implementations.app.ManagerAppBase;
import models.implementations.players.ManagerPlayersBase;
import models.implementations.resources.ManagerResourceBase;
import models.implementations.states.ManagerStatesBase;
import models.interfaces.IManagerGame;
import models.interfaces.levels.ILevelInfo;
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

    /*
     * Properties
     */
    public function get managerGame():ManagerGame
    {
        return _managerGame;
    }

    /*
     * Methods
     */
    public function GameInfo(stageValue:Stage)
    {
        super(stageValue);

        initSocialManager();
    }

    protected override function onInitSocialComplete():void
    {
        _managerProxy = new ManagerProxy(_managerSocial);
        _managerRemote = new ManagerRemoteStub("", _managerProxy);
        _managerApp = new ManagerAppBase(_stage);
        _managerStates = new ManagerStatesBase();
        _managerString = new ManagerString(_managerSocial);

        _managerPlayers = new ManagerPlayersBase();
        _managerPlayers.deserialize(_managerProxy.getPlayersData(null));


        _managerLevels = new ManagerLevels(LevelInfo);
        _managerLevels.deserialize(_managerProxy.getLevelsData(null));

        _managerResources = new ManagerResourceBase();

        {   //register states
            _managerStates.registerState(EStateType.EST_MAIN, StateMain);
            _managerStates.registerState(EStateType.EST_GAME, StateGame);
        }

        super.onInitSocialComplete();
    }

    protected override function onRemoteGameInitComplete(response:IResponse):void
    {
        GameInfo.instance.managerStates.setState(EStateType.EST_MAIN);

//        var nextLevel:ILevelInfo = GameInfo.instance.managerLevels.getSavedOrIncompleteLevel();
//
//        var managerGame:IManagerGame = new ManagerGame(nextLevel);
//
//        GameInfo.instance.onGameStart(managerGame);
//
//        GameInfo.instance.managerStates.setState(EStateType.EST_GAME);
    }


    public override function onGameStart(value:IManagerGame):void
    {
        super.onGameStart(value);

        Debug.assert(value is ManagerGame);

        _managerGame = value as ManagerGame;
    }
}
}
