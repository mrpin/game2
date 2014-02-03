/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.bank
{
import controllers.IControllerPopup;

import views.IView;

import views.IViewButton;
import views.implementations.ViewPopup;
import views.implementations.buttons.ViewButton;

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
            item.x = 340;
            item.y = yPosition;

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
