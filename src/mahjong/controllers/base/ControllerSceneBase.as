/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.base
{
import controllers.EControllerUpdateBase;
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.plaeyr.PlayerInfo;
import mahjong.view.base.ViewSceneBase;

import models.interfaces.sounds.IManagerSounds;

import views.interfaces.IView;

public class ControllerSceneBase extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewSceneBase;

    private var _managerSounds:IManagerSounds;

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
                case _view.buttonTOP:
                {

                    result = true;

                    break;
                }
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
//                    GameInfo.instance.managerStates.currentState.showPopup(EPopupType.EPT_BANK);

                    result = true;

                    break;
                }
                case _view.buttonEnergy:
                {

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


        _managerSounds = GameInfo.instance.managerSounds;
    }


    override public function update(type:String):void
    {
        var playerInfo:PlayerInfo = GameInfo.instance.managerPlayers.playerCurrent as PlayerInfo;

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
                _view.viewCurrencyInfo = playerInfo.currencySoft.toString();

                break;
            }
            case EControllerUpdateBase.ECU_PLAYER_POINTS:
            {
                _view.viewPointsInfo = playerInfo.points.toString();

                break;
            }
            case EControllerUpdate.ECU_PLAYER_ENERGY:
            {
                _view.viewEnergyInfo = playerInfo.energy.toString();

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
        super.cleanup();
    }


}
}
