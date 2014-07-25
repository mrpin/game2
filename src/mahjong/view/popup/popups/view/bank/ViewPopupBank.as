/**
 * Created by evgenyyurko on 7/25/14.
 */
package mahjong.view.popup.popups.view.bank
{
import controllers.interfaces.IControllerPopup;

import flash.geom.Point;

import views.implementations.popups.bank.ViewBankBase1;

public class ViewPopupBank extends ViewBankBase1
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    override protected function get itemsOffset():Point
    {
        return new Point(24, 95);
    }

    override protected function get containerSize():Point
    {
        return new Point(520, 205);
    }

    override protected function get scrollGap():Point
    {
        return new Point(300, -30);
    }

    override protected function get positionItemSpecial():Point
    {
        var result:Point = this.itemsOffset.clone();

        result.y += this.containerSize.y;
        result.y += 10;

        return result;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewPopupBank(controller:IControllerPopup)
    {
        super(controller);

        init();
    }

    private function init():void
    {

    }
}
}
