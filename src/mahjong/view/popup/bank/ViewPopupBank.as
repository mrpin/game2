/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.bank
{
import controllers.IControllerPopup;

import mahjong.GameInfo;
import mahjong.models.string.EStringType;

import models.interfaces.string.IManagerString;

import views.implementations.ViewPopup;
import views.implementations.buttons.ViewButton;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewPopupBank extends ViewPopup
{
    /*
     * Fields
     */
    private var _source:gPopupBank;

    private var _viewsPopupsBankItems:Array;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewPopupBank(controller:IControllerPopup)
    {
        _source = new gPopupBank();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var buttonClose:IViewButton = new ViewButton(controller, _source.buttonClose);
        setButtonClose(buttonClose);

        _viewsPopupsBankItems = [];

        var managerString:IManagerString = GameInfo.instance.managerString;

        _source.labelTitle.text = (managerString.localizedString(EStringType.EST_POPUP_BANK_WIDGET_TITLE));
    }


    override public function addSubView(view:IView):void
    {
        _source.addChild(view.source);
        _viewsPopupsBankItems.push(view);
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var yPosition:int = 173;
        for each(var item:IView in _viewsPopupsBankItems)
        {
            item.source.x = 340;
            item.source.y = yPosition;

            yPosition += 84;
        }
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
