/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.base
{
import controllers.implementations.Controller;
import controllers.implementations.popups.EPopupTypeBase;
import controllers.interfaces.EControllerUpdateBase;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.view.base.ViewSceneBase;

import models.interfaces.players.IPlayerInfo;
import models.interfaces.sounds.IManagerSounds;

import views.interfaces.IView;

public class ControllerSceneBase extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewSceneBase;

    private var _managerSounds:IManagerSounds;

    private var _controllerEnergy:ControllerIconEnergy;

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
                case _view.buttonSound.On:
                {
                    _managerSounds.soundsOn = false;
                    _view.buttonSound.isOn = false;
                    result = true;

                    break;
                }
                case _view.buttonSound.Off:
                {
                    _managerSounds.soundsOn = true;
                    _view.buttonSound.isOn = true;
                    result = true;

                    break;
                }
                case _view.buttonMusic.On:
                {
                    _managerSounds.musicOn = false;
                    _view.buttonMusic.isOn = false;
                    result = true;

                    break;
                }
                case _view.buttonMusic.Off:
                {
                    _managerSounds.musicOn = true;
                    _view.buttonMusic.isOn = true;
                    result = true;

                    break;
                }
                case _view.buttonFullScreen:
                {
                    GameInfo.instance.managerApp.fullScreenEnable = !GameInfo.instance.managerApp.fullScreenEnable;

                    result = true;

                    break;
                }
                case _view.buttonHelp:
                {
                    result = true;

                    break;
                }
                case _view.buttonCurrency:
                {
                    GameInfo.instance.managerStates.currentState.showPopup(EPopupTypeBase.EPT_BANK);

                    result = true;

                    break;
                }
                default:
                {


                    break;
                }
            }
        }

        return result;
    }


    /*
     * Methods
     */
    public function ControllerSceneBase(view:ViewSceneBase)
    {
        _view = view;

        super(_view);

        init();
    }

    private function init():void
    {
        _view.handleEvents(false, true);
        _controllerEnergy = new ControllerIconEnergy();
        _view.viewEnergy = _controllerEnergy.view;

        _managerSounds = GameInfo.instance.managerSounds;
    }


    override public function update(type:String):void
    {
        var playerInfo:IPlayerInfo = GameInfo.instance.managerPlayers.playerCurrent;

        switch (type)
        {
            case EControllerUpdateBase.ECU_STATE_ENTER:
            {
                update(EControllerUpdateBase.ECU_PLAYER_CURRENCY);
                update(EControllerUpdateBase.ECU_PLAYER_POINTS);
                update(EControllerUpdate.ECU_PLAYER_ENERGY);

                break;
            }
            case EControllerUpdateBase.ECU_PLAYER_CURRENCY:
            {
                _view.viewCurrencyInfo = playerInfo.currencySoft;

                break;
            }
            case EControllerUpdateBase.ECU_PLAYER_POINTS:
            {
                _view.viewPointsInfo = playerInfo.points;

                break;
            }
            case EControllerUpdate.ECU_PLAYER_ENERGY:
            {
                _controllerEnergy.update(type);

                break;
            }
            default :
            {

                break;
            }
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _controllerEnergy.cleanup();
        _controllerEnergy = null;

        _view = null;

        super.cleanup();
    }


}
}
