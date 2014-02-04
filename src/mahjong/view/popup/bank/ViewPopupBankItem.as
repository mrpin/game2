/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.bank
{
import controllers.IController;

import mahjong.GameInfo;

import mahjong.models.string.EStringType;

import models.interfaces.string.IManagerString;

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
        var managerString:IManagerString = GameInfo.instance.managerString;

        _buttonBuy = new ViewButtonLabeled(controller, _source.buttonBuy);
        _buttonBuy.text = (managerString.localizedString(EStringType.EST_POPUP_BANK_ITEM_BUTTON_BUY));

        _source.labelContentCount0.text = (managerString.localizedString(EStringType.EST_POPUP_BANK_ITEM_CONTENT_COUNT0));
        _source.labelContentCount1.text = (managerString.localizedString(EStringType.EST_POPUP_BANK_ITEM_CONTENT_COUNT1));
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
