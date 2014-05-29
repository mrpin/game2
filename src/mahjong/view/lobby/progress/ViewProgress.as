/**
 * Created by evgenyyurko on 3/11/14.
 */
package mahjong.view.lobby.progress
{
import controllers.IController;

import core.implementations.Debug;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import views.implementations.ViewBase;
import views.interfaces.IView;

public class ViewProgress extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewItems:Array;

    private var _viewPlayerTop:ViewAvatarItem;

    private var _offsetX:int;

    private var _itemsCountMax:uint;

    /*
     * Properties
     */

    public function get itemsCountMax():uint
    {
        return _itemsCountMax;
    }

    public function set addViewItem(view:IView):void
    {
        Debug.assert(view != null, "Added view to progress panel is null!");

        _viewItems.push(view);
        _source.addChild(view.source);
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewProgress(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    public function init():void
    {
        _offsetX = -2;
        _itemsCountMax = 5;
        _viewItems = [];
    }

//todo:
//    public function addPlayerView(value:IView):void
//    {
//        _items.push(value);
//    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var currentX:Number = 0;


        var firstView:IView = _viewItems[0];

        currentX += firstView.source.width + _offsetX;


        for (var i:int = 1; i < _viewItems.length; i++)
        {
            var viewItem:IView = _viewItems[i];

            viewItem.source.x = currentX;
            viewItem.source.y = 0;//firstView.source.height - viewItem.source.height;

            currentX += viewItem.source.width + _offsetX;
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _viewItems = null;

        //TODO:review
//        _viewPlayerTop.cleanup();
//        _viewPlayerTop = null;

        _source = null;

        super.cleanup();
    }


}
}