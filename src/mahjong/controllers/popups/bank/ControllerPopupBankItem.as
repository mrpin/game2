/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.bank
{
import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.view.popup.bank.ViewPopupBankItem;

import views.interfaces.IView;

public class ControllerPopupBankItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewPopupBankItem;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerPopupBankItem()
    {
        _view = new ViewPopupBankItem(this);
        super(_view);

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case  _view.buttonBuy:
                {
                    result = true;

                    break;
                }
                default :
                {
                    Debug.assert(false);

                    break;
                }
            }
        }


        return result;
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
