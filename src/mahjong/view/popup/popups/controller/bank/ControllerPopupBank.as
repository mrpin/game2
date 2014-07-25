/**
 * Created by evgenyyurko on 7/25/14.
 */
package mahjong.view.popup.popups.controller.bank
{
import controllers.implementations.popups.bank.ControllerBankBase1;

import mahjong.view.popup.popups.view.bank.ViewPopupBank;

public class ControllerPopupBank extends ControllerBankBase1
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    override protected function get classView():Class
    {
        return ViewPopupBank;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerPopupBank()
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
