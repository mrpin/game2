/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup
{
import controllers.IControllerPopup;

import views.implementations.ViewPopup;

public class ViewPopupBonus extends ViewPopup
{
    /*
     * Fields
     */
      private var _source:gPopupBonus;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewPopupBonus(controller:IControllerPopup)
    {
       _source = new gPopupBonus();
        super (controller, _source);

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
