/**
 * Created by evgenyyurko on 3/18/14.
 */
package mahjong.controllers.lobby.timeBonus
{
import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mahjong.GameInfo;
import mahjong.view.lobby.timeBonus.ViewTimeBonus;

import models.interfaces.bonus.EBonusTypeBase;
import models.interfaces.bonus.IBonusItem;

import utils.UtilsString;
import utils.memory.UtilsMemory;

import views.interfaces.IView;

public class ControllerTimeBonus extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewTimeBonus;

    private var _timer:Timer;

    private var _currentBonus:IBonusItem;

    /*
     * Properties
     */

    /*
     * Events
     */

    private function onTimerTick(event:TimerEvent):void
    {
        if (_currentBonus != null)
        {
            if (_currentBonus.isAvailable)
            {
                _view.buttonPickUpBonus.show();
            }
            else if (_currentBonus.timeLeft > 0)
            {
                _view.buttonPickUpBonus.hide();
                _view.labelTime = UtilsString.toHrsMinSec(_currentBonus.timeLeft);
            }
            else
            {
                _currentBonus = GameInfo.instance.managerBonus.getBonusNext(EBonusTypeBase.EBT_CURRENCY_SOFT);
                onTimerTick(null);
            }
        }
        else
        {
            _currentBonus = GameInfo.instance.managerBonus.getBonusNext(EBonusTypeBase.EBT_CURRENCY_SOFT);

            _view.show();
            _view.buttonPickUpBonus.enabled = false;
        }
    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view.buttonPickUpBonus:
                {
                    _currentBonus = null;

                    result = true;

                    break;
                }
                default :
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
    public function ControllerTimeBonus()
    {
        _view = new ViewTimeBonus(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _currentBonus = GameInfo.instance.managerBonus.getBonusNext(EBonusTypeBase.EBT_CURRENCY_SOFT);

        onTimerTick(null);

        _timer = new Timer(ConstantsBase.ANIMATION_DURATION * 4 * 1000);
        UtilsMemory.registerEventListener(_timer, TimerEvent.TIMER, this, onTimerTick);
        _timer.start();
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

        super.cleanup();
    }

}
}
