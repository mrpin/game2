/**
 * Created by evgenyyurko on 7/18/14.
 */
package mahjong.view.popup.popups.view
{
import controllers.interfaces.IControllerPopup;

import views.implementations.popups.noEnergy.ViewNoEnergyBase0;
import views.implementations.popups.noEnergy.ViewNoEnergyBase1;

public class ViewPopupNoEnergy extends ViewNoEnergyBase1
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewPopupNoEnergy(controller:IControllerPopup)
    {
        super(controller);

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
