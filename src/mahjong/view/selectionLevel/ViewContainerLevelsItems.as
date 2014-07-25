/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.selectionLevel
{
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import controllers.interfaces.IController;

import core.implementations.Debug;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;

import mx.utils.StringUtil;

import utils.Utils;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewContainerLevelsItems extends ViewBase
{
    /*
     * Static methods
     */
    private static function moveItemsTo(items:Array, targetX:Number, callback:Function):void
    {
        var delay:Number = (ConstantsBase.ANIMATION_DURATION * 4) / 20;

        var delayRow:Number = delay;
        var delayItem:Number = delay;

        var indexRow:uint = 0;
        var indexItem:uint = 0;

        for (indexRow = 0; indexRow < items.length; indexRow++)
        {
            var row:Array = items[indexRow];

            for (indexItem = 0; indexItem < row.length; indexItem++)
            {
                var item:IView = row[indexItem];

                var isItemLast:Boolean = indexRow == indexRow < (items.length - 1) && indexItem == (row.length - 1);

                tweenTo(item.source, targetX, delayItem, isItemLast ? callback : null);

                delayItem += delay;
            }

            delayRow += delay;
            delayItem = delayRow;
        }
    }

    private static function tweenTo(target:DisplayObject, x:Number, delay:Number, callback:Function):void
    {
        TweenLite.killTweensOf(target);

        var duration:Number = ConstantsBase.ANIMATION_DURATION * 2;

        var tweenParam:Object =
        {
            delay     : delay,
            x         : target.x + x,
            onComplete: callback
        };

        TweenLite.to(target, duration, tweenParam);
    }

    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _items:Array;

    private var _viewNavigationBar:gViewNavigationBar;

    private var _buttonNext:IViewButton;
    private var _buttonPrev:IViewButton;

    private var _gapItems:Point;

    private var _gridSize:Point;
    private var _gridSizeInPixels:Point;

    private var _isItemsPlaced:Boolean;

    private var _itemsObject:DisplayObjectContainer;
    private var _mask:Sprite;


    /*
     * Properties
     */
    public function set items(value:Array):void
    {
        if (value == _items)
        {
            return;
        }

        _items = value;

        for each(var viewItems:Array in _items)
        {
            for each (var row:Array in viewItems)
            {
                for each(var viewItem:IView in row)
                {
                    _source.addChild(viewItem.source);
                }
            }

        }

        Debug.assert(_items.length != 0);
        var itemFirst:IView = _items[0][0][0];

        _gridSizeInPixels = new Point();
        _gridSizeInPixels.x = (itemFirst.source.width * _gridSize.x) + (_gapItems.x * (_gridSize.x - 1));
        _gridSizeInPixels.y = (itemFirst.source.height * _gridSize.y) + (_gapItems.y * (_gridSize.y - 1));
    }

    public function get buttonNext():IViewButton
    {
        return _buttonNext;
    }

    public function get buttonPrev():IViewButton
    {
        return _buttonPrev;
    }

    public function get gridSize():Point
    {
        return _gridSize;
    }

    public function get gridSizeInPixels():Point
    {
        return _gridSizeInPixels;
    }

    public function updateButtonNext(completeLevelsCount:uint, itemsCount:uint):void
    {
        _viewNavigationBar.labelPages.text = StringUtil.substitute("{0}/{1}", completeLevelsCount, itemsCount);
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewContainerLevelsItems(controller:IController)
    {
        _source = new Sprite();

        super(controller, _source);

        init();
//        initMask();
    }

    private function init():void
    {
        _viewNavigationBar = new gViewNavigationBar();
        _source.addChild(_viewNavigationBar);

        _buttonNext = new ViewButton(controller, _viewNavigationBar.buttonForward);
        _buttonNext.colorFeedback = false;

        _buttonPrev = new ViewButton(controller, _viewNavigationBar.buttonBack);
        _buttonPrev.colorFeedback = false;

        _gapItems = new Point(20, 10);
        _gridSize = new Point(5, 3);

        _isItemsPlaced = false;
    }

    private function initMask(displayObject:DisplayObjectContainer, parent:DisplayObjectContainer,  widthMask:uint, heightMask:uint):void
    {
        /*
         создаём спрайт в форме элипса с радиальным градиентом в качестве заливки
         этот спрайт мы потом и сделаем маской
         */
        var mask:Sprite = new Sprite();
        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(widthMask, heightMask);
        mask.graphics.lineStyle();
        mask.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF], [0, 1, 1, 0], [0, 10, 245, 255], matrix);
        mask.graphics.drawRect(0, 0, widthMask, heightMask);
        mask.graphics.endFill();
        parent.addChild(mask);
        /*
         объявляем маской для мувика mc ранее созданный спрайт с градиентной заливкой
         */
        displayObject.mask = _mask;
        /*
         а теперь самое главное - кэшируем объект и маску
         без этого создать эффект градиентной маски не получится
         */
        displayObject.cacheAsBitmap = true;
        displayObject.mask.cacheAsBitmap = true;
    }

    private function moveItemsToLeft(items:Array, callback:Function = null):void
    {
        moveItemsTo(items, -(_gridSizeInPixels.x + _gapItems.x), callback)
    }

    private function moveItemsToRight(items:Array, callback:Function = null):void
    {
        moveItemsTo(items, _gridSizeInPixels.x + _gapItems.x, callback)
    }

    public function moveCurrentPageToRight(pageNumber:uint, callback:Function):void
    {
        var itemsCurrent:Array = _items[pageNumber];
        moveItemsToRight(itemsCurrent);

        Utils.performAfterDelay(ConstantsBase.ANIMATION_DURATION * 2 * 500,
                function ():void
                {
                    var itemsNext:Array = _items[pageNumber - 1];
                    moveItemsToRight(itemsNext, callback);
                });
    }

    public function moveCurrentPageToLeft(pageNumber:uint, callback:Function):void
    {
        var itemsCurrent:Array = _items[pageNumber];
        moveItemsToLeft(itemsCurrent);

        Utils.performAfterDelay(ConstantsBase.ANIMATION_DURATION * 2 * 500,
                function ():void
                {
                    var itemsNext:Array = _items[pageNumber + 1];
                    moveItemsToLeft(itemsNext, callback);
                });
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        if (_isItemsPlaced)
        {
            return;
        }

        _isItemsPlaced = true;

        super.placeViews(fullscreen);

        var startX:int = 0;
        var startY:int = 0;

        var positionX:int = startX;

        for each (var container:Array in _items)
        {
            for each (var row:Array in container)
            {
                for each (var item:Object in row)
                {
                    item.placeViews(fullscreen);

                    item.source.x = positionX;
                    item.source.y = startY;

                    positionX += item.source.width + _gapItems.x;
                }

                positionX = startX;
                startY += item.source.height + _gapItems.y;
            }

            startX = (item.source.width + _gapItems.x) * 5;
            positionX = startX;

            startY = 0;
        }

        _viewNavigationBar.x = 279;
        _viewNavigationBar.y = 410;

//        _mask.x = -24;
//        _mask.y = -10;
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each (var items:Array in _items)
        {
            for each (var row:Array in items)
            {
                for each (var item:IView in row)
                {
                    TweenMax.killTweensOf(item);
                }
            }
        }

        _items = null;

        _buttonPrev.cleanup();
        _buttonPrev = null;

        _buttonNext.cleanup();
        _buttonNext = null;

        _source = null;

        super.cleanup();
    }


}
}
