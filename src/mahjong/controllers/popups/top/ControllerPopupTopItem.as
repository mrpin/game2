/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.top
{
import controllers.implementations.Controller;

import mahjong.view.popup.top.ViewPopupTopItem;

public class ControllerPopupTopItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewPopupTopItem;



    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerPopupTopItem()
    {
        _view = new ViewPopupTopItem(this);
        super(_view);

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
