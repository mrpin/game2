/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.popupBank
{
import controllers.IController;

import views.IViewButtonLabeled;
import views.implementations.ViewBase;
import views.implementations.buttons.ViewButtonLabeled;

public class ViewPopupBankItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gPopupBankItem;

    private var _buttonBuy:IViewButtonLabeled;

    /*
     * Properties
     */
     public function get buttonBuy():IViewButtonLabeled
     {
         return _buttonBuy;
     }

    /*
     * Methods
     */
    public function ViewPopupBankItem(controller:IController)
    {
        _source = new gPopupBankItem();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        _buttonBuy = new ViewButtonLabeled(controller, _source.buttonBuy);
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonBuy.cleanup();
        _buttonBuy = null;

        super.cleanup();
    }


}
}
