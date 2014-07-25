/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.popups.EPopupTypeBase;
import controllers.interfaces.EControllerUpdateBase;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.models.game.ManagerGame;
import mahjong.models.level.LevelInfo;
import mahjong.models.prchaces.EPurchaseType;
import mahjong.states.EStateType;
import mahjong.view.game.ViewSceneGame;

import models.interfaces.IManagerGame;
import models.interfaces.levels.ILevelInfo;
import models.interfaces.purchases.IManagerPurchases;
import models.interfaces.purchases.IPurchaseItem;

import views.interfaces.IView;

public class ControllerSceneGame extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneGame;

    private var _controllerFieldChips:ControllerFieldChips;

    private var _controllerMeasurePoints:ControllerMeasurePoints;

    private var _managerPurchases:IManagerPurchases;

    /*
     * Properties
     */

    /*
     * Events
     */
    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        var currentLevel:LevelInfo = GameInfo.instance.managerGame.currentLevel;

        if (!result)
        {
            switch (view)
            {
                case _view.buttonBoosterDoneLevel:
                {
                    var boosterDoneLevel:IPurchaseItem = _managerPurchases.getPurchaseFirst(EPurchaseType.EPT_DONE_LEVEL);

                    _managerPurchases.tryPurchase(boosterDoneLevel,
                            function (item:IPurchaseItem):void
                            {
                                GameInfo.instance.managerGame.isMadePurchase = true;
                                GameInfo.instance.managerGame.levelPass();
                            });

                    result = true;

                    break;
                }
                case _view.buttonBoosterHint:
                {
                    var boosterHint:IPurchaseItem = _managerPurchases.getPurchaseFirst(EPurchaseType.EPT_SHOW_COMBINATION);

                    _managerPurchases.tryPurchase(boosterHint,
                            function (item:IPurchaseItem):void
                            {
                                GameInfo.instance.managerGame.showCombination();
                                GameInfo.instance.managerGame.isMadePurchase = true;
                            });

                    result = true;

                    break;
                }
                case _view.buttonBoosterUndo:
                {
                    var boosterUndo:IPurchaseItem = _managerPurchases.getPurchaseFirst(EPurchaseType.EPT_CANCEL_LAST_MOVE);


                    _managerPurchases.tryPurchase(boosterUndo,
                            function (item:IPurchaseItem):void
                            {
                                GameInfo.instance.managerGame.cancelLastMove();
                                GameInfo.instance.managerGame.isMadePurchase = true;
                            });

                    result = true;

                    break;
                }
                case _view.buttonBoosterMix:
                {
                    var boosterMix:IPurchaseItem = _managerPurchases.getPurchaseFirst(EPurchaseType.EPT_MIXING);

                    _managerPurchases.tryPurchase(boosterMix,
                            function (item:IPurchaseItem):void
                            {
//                                GameInfo.instance.managerGame.shuffleChips();
                                GameInfo.instance.managerGame.shuffle();
                                GameInfo.instance.managerGame.isMadePurchase = true;
                            });

                    break;
                }
                case _view.buttonBack:
                {
                    GameInfoBase.instance.onGameEnd();

                    GameInfo.instance.managerStates.setState(EStateType.EST_SELECT_LEVEL);

                    result = true;

                    break;
                }
                case _view.buttonRetry:
                {
                    var levelInfo:ILevelInfo = GameInfo.instance.managerGame.currentLevel;

                    GameInfoBase.instance.onGameEnd();

                    var managerGame:IManagerGame = new ManagerGame(levelInfo);

                    GameInfo.instance.onGameStart(managerGame);
                    GameInfo.instance.managerStates.setState(EStateType.EST_GAME);

                    result = true;

                    break;
                }
                default:
                {
                    Debug.assert(false);

                    break;
                }
            }
        }

        return result;
    }

    /*
     * Methods
     */
    public function ControllerSceneGame()
    {
        _view = new ViewSceneGame(this);

        super(_view);

        init();
    }

    private function init():void
    {
        _controllerFieldChips = new ControllerFieldChips();
        _view.viewFieldChips = _controllerFieldChips.view;

        _controllerMeasurePoints = new ControllerMeasurePoints();
        _view.viewMeasurePoints = _controllerMeasurePoints.view;

        _managerPurchases = GameInfo.instance.managerPurchases;

        update(EControllerUpdate.ECU_UPDATE_BUTTONS);
    }


    override public function update(type:String):void
    {
        super.update(type);

        switch (type)
        {
            //TODO: saves for purchase "show disabled"
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            case EControllerUpdate.ECUT_CHIPS_SHUFFLE:
            {
                _controllerFieldChips.update(type);

                break;
            }
            case EControllerUpdateBase.ECU_STATE_ENTER:
            {
                GameInfo.instance.managerGame.onGameStart();

                break;
            }
            case EControllerUpdateBase.ECU_PLAYER_CURRENCY:
            {

                break;
            }
            case EControllerUpdateBase.ECU_PLAYER_POINTS:
            {
                _controllerMeasurePoints.update(type);

                break;
            }
            case EControllerUpdate.ECU_PLAYER_ENERGY:
            {

                break;
            }
            case EControllerUpdate.ECUT_DESTROYED_COUPLE_CHIPS:
            case EControllerUpdate.ECU_UPDATE_TIME:
            {
                _controllerMeasurePoints.update(type);

                break;
            }
            case EControllerUpdateBase.ECU_GAME_FINISHED:
            {

                break;
            }
            case EControllerUpdate.ECU_UPDATE_BUTTONS:
            {
                _view.buttonBoosterUndo.enabled = GameInfo.instance.managerGame.isCanceledLastMove;
                _view.buttonBoosterHint.enabled = !GameInfo.instance.managerGame.isOnButtonHint;


                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _controllerFieldChips.cleanup();
        _controllerFieldChips = null;

        _controllerMeasurePoints.cleanup();
        _controllerMeasurePoints = null;

        _view = null;

        super.cleanup();
    }


}
}
