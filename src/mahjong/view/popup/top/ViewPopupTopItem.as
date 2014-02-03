/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.top
{
import controllers.IController;

import views.IView;
import views.implementations.ViewBase;

public class ViewPopupTopItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gPopupTopItem;



    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewPopupTopItem(controller:IController)
    {
        _source = new gPopupTopItem();
        super(controller, _source);

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
