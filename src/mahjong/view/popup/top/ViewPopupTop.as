/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.top
{
import controllers.IControllerPopup;

import views.IView;

import views.IViewButton;
import views.IViewButtonLabeled;
import views.implementations.ViewPopup;
import views.implementations.buttons.ViewButton;
import views.implementations.buttons.ViewButtonLabeled;

public class ViewPopupTop extends ViewPopup
{
    /*
     * Fields
     */
    private var _source:gPopupTop;

    //TODO: переименовать кнопку
    private var _button:IViewButtonLabeled;

    private var _itemsViews:Array;

    /*
     * Properties
     */
    public function get button():IViewButtonLabeled
    {
        return _button;
    }

    /*
     * Methods
     */
    public function ViewPopupTop(controller:IControllerPopup)
    {
        _source = new gPopupTop();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        _itemsViews = [];

        var buttonClose:IViewButton = new ViewButton(controller, _source.buttonClose);
        setButtonClose(buttonClose);

        _button = new ViewButtonLabeled(controller, _source.button);
    }

    override public function addSubView(view:IView):void
    {
        _source.addChild(view.source);
        _itemsViews.push(view);
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        var xPositionStart:int = 398;
        var yPositionStart:int = 175;

        var xPosition:int = xPositionStart;

        for (var i:int = 0; i < _itemsViews.length; i++)
        {
            var item:IView = _itemsViews[i];

            item.x = xPosition;
            item.y = yPositionStart;

            xPosition += item.source.width + 10;

            if ((i + 1) % 5 == 0)
            {
                xPosition = xPositionStart;
                yPositionStart += item.source.height - 10;
            }
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _button.cleanup();
        _button = null;

        super.cleanup();
    }


}
}
