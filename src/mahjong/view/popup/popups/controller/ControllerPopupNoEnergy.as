/**
 * Created by evgenyyurko on 7/18/14.
 */
package mahjong.view.popup.popups.controller
{
import mahjong.view.popup.popups.*;

import controllers.implementations.popups.EPopupTypeBase;
import controllers.implementations.popups.noEnergy.ControllerNoEnergyBase;

import mahjong.view.popup.popups.view.ViewPopupNoEnergy;

public class ControllerPopupNoEnergy extends ControllerNoEnergyBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    override protected function get classView():Class
    {
        return ViewPopupNoEnergy;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerPopupNoEnergy()
    {


        init();
    }

    private function init():void
    {

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
