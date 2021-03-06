/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.bank
{
import controllers.implementations.ControllerPopup;

import mahjong.controllers.popups.*;
import mahjong.view.popup.popups.view.bank.ViewPopupBank;

import views.interfaces.IViewPopup;

public class ControllerPopupBank extends ControllerPopup
{
    /*
     * Fields
     */
    private var _view:IViewPopup;

    private var _controllersPopupsBankItems:Array;


    /*
     * Properties
     */
    override public function get type():String
    {
        return EPopupType.EPT_BANK;
    }

    /*
     * Methods
     */
    public function ControllerPopupBank()
    {
        _view = new ViewPopupBank(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _controllersPopupsBankItems = [];

        for (var i:int = 0; i < 4; i++)
        {
            var controllerPopupBank:ControllerPopupBankItem = new ControllerPopupBankItem();
            _view.addSubView(controllerPopupBank.view);
            _controllersPopupsBankItems.push(controllerPopupBank);
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var item:ControllerPopupBankItem in _controllersPopupsBankItems)
        {
            item.cleanup();
            item = null;
        }

        _controllersPopupsBankItems = null;

        super.cleanup();
    }


}
}
