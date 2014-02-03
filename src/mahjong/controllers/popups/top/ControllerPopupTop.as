/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.top
{

import controllers.implementations.ControllerPopup;

import flash.events.MouseEvent;

import mahjong.controllers.popups.EPopupType;
import mahjong.view.popup.top.ViewPopupTop;

import views.IView;

public class ControllerPopupTop extends ControllerPopup
{
    /*
     * Fields
     */
    private var _view:ViewPopupTop;

    private var _items:Array;

    /*
     * Properties
     */
    override public function get type():String
    {
        return EPopupType.EPT_TOP;
    }

    /*
     * Methods
     */
    public function ControllerPopupTop()
    {
        _view = new ViewPopupTop(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _items = [];

        for (var i:int = 0; i < 15; i++)
        {
            var item:ControllerPopupTopItem = new ControllerPopupTopItem();
            _view.addSubView(item.view);
            _items.push(item);
        }
    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view.button:
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
        for each(var item:ControllerPopupTopItem in _items)
        {
            item.cleanup();
            item = null;
        }

        super.cleanup();
    }


}
}
