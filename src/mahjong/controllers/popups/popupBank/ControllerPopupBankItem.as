/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.popupBank
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.view.popup.popupBank.ViewPopupBankItem;

import views.IView;

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
