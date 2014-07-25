/**
 * Created by evgenyyurko on 6/3/14.
 */
package mahjong.controllers.base
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.bonus.EBonusType;
import mahjong.view.base.ViewIconEnergy;

import models.interfaces.bonus.IBonusItem;
import models.interfaces.players.IPlayerInfo;

import utils.memory.UtilsMemory;

import views.interfaces.IView;

//TODO:сделать бонус энергии
public class ControllerIconEnergy extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewIconEnergy;

    private var _timer:Timer;

    //TODO:implement
//    private var _currentBonus:IBonusItem;


    /*
     * Properties
     */


    /*
     * Events
     */
    private function onTimerTick(event:TimerEvent):void
    {
        //TODO:implement
//        if (_currentBonus != null)
//        {
//            if (_currentBonus.timeLeft > 0)
//            {
//                _view.time = _currentBonus.timeLeft;
//            }
//            else
//            {
//                var playerCurrent:IPlayerInfo = GameInfo.instance.managerPlayers.playerCurrent;
//

////                playerCurrent.energy += _currentBonus.rewardCount;
//                _currentBonus = null;
//            }
//        }
//        else
//        {
//            _currentBonus = GameInfo.instance.managerBonus.getBonusNext(EBonusType.EBT_ENERGY);
//        }
    }

    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
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
    public function ControllerIconEnergy()
    {
        _view = new ViewIconEnergy(this);
        super(_view);

        init();
    }

    private function init():void
    {
        //TODO:implement
//        _currentBonus = GameInfo.instance.managerBonus.getBonusNext(EBonusType.EBT_ENERGY);


        //TODO:review
//        _timer = new Timer(ConstantsBase.ANIMATION_DURATION * 4 * 1000);
//        UtilsMemory.registerEventListener(_timer, TimerEvent.TIMER, this, onTimerTick);
//        _timer.start();
    }

    override public function update(type:String):void
    {
        var playerInfo:IPlayerInfo = GameInfo.instance.managerPlayers.playerCurrent;

        switch (type)
        {
            case EControllerUpdate.ECU_PLAYER_ENERGY:
            {
                _view.viewEnergyInfo = playerInfo.energy;

                break;
            }
            default :
            {

                break;
            }
        }
    }


    private function tryCleanupTimer():void
    {
        if (_timer != null)
        {
            _timer.stop();
            UtilsMemory.unregisterEventListener(_timer, TimerEvent.TIMER_COMPLETE, this, onTimerTick, false);
            _timer = null;
        }

    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        tryCleanupTimer();

        _view = null;

        super.cleanup();
    }


}
}
