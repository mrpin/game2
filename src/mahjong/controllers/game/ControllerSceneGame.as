/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.game
{
import controllers.EControllerUpdateBase;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;

import mahjong.controllers.EControllerUpdate;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.models.prchaces.EPurchaseType;
import mahjong.states.EStateType;
import mahjong.view.game.ViewSceneGame;

import models.interfaces.purchases.IManagerPurchases;
import models.interfaces.purchases.IPurchaseItem;

import states.EStateTypeBase;

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

        if (!result)
        {
            switch (view)
            {
                case _view.buttonBoosterDoneLevel:
                {
//                    GameInfo.instance.managerGame.onShowChipsDisable = true;
                    result = true;

                    break;
                }
                case _view.buttonBoosterHint:
                {
//                    GameInfo.instance.managerGame.onShowChipsDisable = false;

                    GameInfo.instance.managerGame.showCombination();

                    result = true;

                    break;
                }
                case _view.buttonBoosterUndo:
                {
                    GameInfo.instance.managerGame.cancelMove();

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

        super.cleanup();
    }


}
}
