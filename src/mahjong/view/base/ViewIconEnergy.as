/**
 * Created by evgenyyurko on 6/3/14.
 */
package mahjong.view.base
{
import controllers.IController;

import utils.UtilsString;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.buttons.IViewButton;

public class ViewIconEnergy extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gViewEnergy;

    private var _buttonEnergy:IViewButton;

    /*
     * Properties
     */
    public function set viewEnergyInfo(value:uint):void
    {
        _source.lebelCount.text = value.toString();
    }

    public function get buttonEnergy():IViewButton
    {
        return _buttonEnergy;
    }

    public function set time(value:Number):void
    {
        _source.viewTimer.labelTimer.text = UtilsString.toHrsMinSec(value);
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewIconEnergy(controller:IController)
    {
        _source = new gViewEnergy();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        _buttonEnergy = new ViewButton(controller, _source.buttonEnergy);
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonEnergy.cleanup();
        _buttonEnergy = null;

        super.cleanup();
    }


}
}
