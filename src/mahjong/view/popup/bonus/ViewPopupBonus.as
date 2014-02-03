/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.bonus
{
import controllers.IControllerPopup;

import views.IViewButtonLabeled;
import views.implementations.ViewPopup;
import views.implementations.buttons.ViewButtonLabeled;

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
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var buttonClose:IViewButtonLabeled = new ViewButtonLabeled(controller, _source.buttonClose);
        setButtonClose(buttonClose);
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
