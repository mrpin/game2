/**
 * Created by evgenyyurko on 7/21/14.
 */
package mahjong.view.popup.popups.view
{
import controllers.interfaces.IControllerPopup;

import core.implementations.Debug;

import flash.display.DisplayObjectContainer;

import mahjong.models.string.EStringType;

import views.implementations.buttons.ViewButtonLabeled;
import views.implementations.popups.outOfTime.ViewOutOfTimeBase0;
import views.interfaces.buttons.IViewButtonPurchase;

public class ViewPopupOutOfTime extends ViewOutOfTimeBase0
{
    /*
     * Static
     */
    private static const INSTANCE_NAME_BUTTON_PASS_LEVEL:String = 'buttonPassLevel';

    /*
     * Fields
     */
    private var _buttonPassLevel:IViewButtonPurchase;

    /*
     * Properties
     */
    public function get buttonPassLevel():IViewButtonPurchase
    {
        return _buttonPassLevel;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewPopupOutOfTime(controller:IControllerPopup)
    {
        super(controller);

        init();
    }

    private function init():void
    {
        var sourceButtonAddTime:DisplayObjectContainer = Debug.assertProperty(source, INSTANCE_NAME_BUTTON_PASS_LEVEL, DisplayObjectContainer);
        _buttonPassLevel = new ViewButtonLabeled(controller, sourceButtonAddTime);
        _buttonPassLevel.label.text = getString(EStringType.EST_POPUP_OUT_OF_TIME_BUTTON_PASS_LEVEL);
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonPassLevel.cleanup();
        _buttonPassLevel = null;

        super.cleanup();
    }


}
}
