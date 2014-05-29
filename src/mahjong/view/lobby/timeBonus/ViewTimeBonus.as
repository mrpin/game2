/**
 * Created by evgenyyurko on 3/18/14.
 */
package mahjong.view.lobby.timeBonus
{
import controllers.IController;

import mahjong.GameInfo;
import mahjong.models.string.EStringType;

import models.interfaces.string.IManagerString;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButtonLabeled;
import views.interfaces.buttons.IViewButtonLabeled;

public class ViewTimeBonus extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gTimerBonus;

    private var _buttonPickUpBonus:IViewButtonLabeled;

    /*
     * Properties
     */
    public function get buttonPickUpBonus():IViewButtonLabeled
    {
        return _buttonPickUpBonus;
    }

    public function set labelTime(value:String):void
    {
        _source.timer.text = value;
    }


    /*
     * Methods
     */
    public function ViewTimeBonus(controller:IController)
    {
        _source = new gTimerBonus();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var managerString:IManagerString = GameInfo.instance.managerString;

        _buttonPickUpBonus = new ViewButtonLabeled(controller, _source.buttonGetTimeBonus);
        _buttonPickUpBonus.text = getString(EStringType.EST_LOBBY_BUTTON_GET_TIME_BONUS);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonPickUpBonus.cleanup();
        _buttonPickUpBonus = null;

        _source = null;

        super.cleanup();
    }

}
}
