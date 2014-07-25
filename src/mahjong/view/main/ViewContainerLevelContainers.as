/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.main
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import views.implementations.ViewBase;
import views.interfaces.IView;

public class ViewContainerLevelContainers extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewItems:Array;

    /*
     * Properties
     */
    public function set viewItems(value:Array):void
    {
        if (value == _viewItems)
        {
            return;
        }

        _viewItems = value;

        for each(var item:IView in _viewItems)
        {
            _source.addChild(item.source);
        }
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewContainerLevelContainers(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var startX:int = 0;
        var startY:int = 0;

        var positionX:int = startX;

        for (var i:int = 0; i < _viewItems.length; i++)
        {
            var viewItem:ViewMainItem = _viewItems[i];

            viewItem.placeViews(fullscreen);

            viewItem.source.x = positionX;
            viewItem.source.y = startY;

            if ((i + 1) % 3 == 0)
            {
                positionX = startX;
                startY += viewItem.size.y + 10;
            }
            else
            {
                positionX += viewItem.size.x + 40;
            }

        }

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _viewItems = null;

        _source = null;

        super.cleanup();
    }


}
}
