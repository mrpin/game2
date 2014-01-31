/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.main
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;

import mahjong.view.base.ViewSceneBase;

import views.IView;
import views.IViewButton;

public class ViewSceneMain extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _items:Array;

    private var _columnCount:uint;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewSceneMain(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        super.buttonBack.source.visible = false;

        _columnCount = 3;

        _items = [];
    }

    override public function addSubView(view:IView):void
    {
        _source.addChild(view.source);
        _items.push(view);
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);

        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        var rowsCount:int = _items.length / _columnCount;

        var offsetX:int = 40;
        var offsetY:int = 20;

        var firstItem:IView = _items[0];

        var startX:int = (appSize.x - (firstItem.source.width + offsetX) * _columnCount) / 2;
        var startY:int = (appSize.y - (firstItem.source.width + offsetY) * rowsCount) / 2;

        if (!fullscreen)
        {
            startY += 100;
        }

        var currentX:int = startX;
        var currentY:int = startY - 100;

        var columnIndex:int = 0;

        for each(var item:IView in _items)
        {
            item.source.x = currentX;
            item.source.y = currentY;

            currentX += item.source.width + offsetX;

            columnIndex++;

            if (columnIndex == _columnCount)
            {
                currentX = startX;
                currentY += item.source.height + offsetY;

                columnIndex = 0;
            }
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
