/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.selectionLevel
{
import com.greensock.TweenMax;

import controllers.IController;

import core.implementations.Debug;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import utils.Utils;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewContainerLevelsItems extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewsItems:Array;

    private var _viewNavigationBar:gViewNavigationBar;

    private var _buttonNext:IViewButton;
    private var _buttonBack:IViewButton;

    private var _gepItemsX:uint = 20;
    private var _gepItemsY:uint = 10;

    private var _sizeVisibleItems:Point;

    private var _countVisibleItemsX:uint = 5;
    private var _countVisibleItemsY:uint = 3;

    private var _isTweenEnd:Boolean;

    private var _isPlaceItems:Boolean;

    /*
     * Properties
     */
    public function set viewsItems(value:Array):void
    {
        if (value == _viewsItems)
        {
            return;
        }

        _viewsItems = value;

        for each(var viewItems:Array in _viewsItems)
        {
            for each(var viewItem:IView in viewItems)
            {
                _source.addChild(viewItem.source);
            }
        }

        Debug.assert(_viewsItems.length != 0);
        var item:IView = _viewsItems[0][0];

        _sizeVisibleItems = new Point();
        _sizeVisibleItems.x = (item.source.width * _countVisibleItemsX) + (_gepItemsX * (_countVisibleItemsX - 1));
        _sizeVisibleItems.y = (item.source.height * _countVisibleItemsY) + (_gepItemsY * (_countVisibleItemsY - 1));
    }

    public function get buttonNext():IViewButton
    {
        return _buttonNext;
    }

    public function set textButtonNext(value:String):void
    {
        _viewNavigationBar.labelPages.text = value;
    }

    public function get buttonBack():IViewButton
    {
        return _buttonBack;
    }

    public function get size():Point
    {
        return _sizeVisibleItems;
    }

    public function get isTweenEnd():Boolean
    {
        return _isTweenEnd;
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
    }

    private function init():void
    {
        _viewNavigationBar = new gViewNavigationBar();
        _source.addChild(_viewNavigationBar);

        _buttonNext = new ViewButton(controller, _viewNavigationBar.buttonForward);

        _buttonBack = new ViewButton(controller, _viewNavigationBar.buttonBack);

        _gepItemsX = 20;
        _gepItemsY = 10;

        _countVisibleItemsX = 5;
        _countVisibleItemsY = 3;

        _isTweenEnd = true;
        _isPlaceItems = false;
    }

//    public function moveItems(valueCurrentContainer:uint):void
//    {
//        var containerItems:Array = _viewsItems[valueCurrentContainer];
//
//        for (var i:int = 0; i < (containerItems.length / 3); i++)
//        {
//            var item0:IView = containerItems[0 + i];
////            tweenItems(item0);
//            var item1:IView = containerItems[5 + i];
////            tweenItems(item1);
//            var item2:IView = containerItems[10 + i];
////            tweenItems(item2);
//        }
//    }

    public function moveAllItems(right:Boolean):void
    {
        if (!_isTweenEnd)
        {
            return;
        }

        _isTweenEnd = false;

        var valueTween:int = _sizeVisibleItems.x + _gepItemsX;

        if (right)
        {
            valueTween *= (-1);
        }

        var delay:Number = (ConstantsBase.ANIMATION_DURATION * 4 * 1000) / 20;

        var time:Number = delay;

        for (var k:int = 0; k < _viewsItems.length; k++)
        {
            var containers:Array = _viewsItems[k];

            for (var i:int = 0; i < containers.length; i++)
            {
                var isComplete:Boolean = (k + 1 == _viewsItems.length && i + 1 == containers.length);

                var item0:IView = containers[i];
                tweenTo(item0, item0.source.x + valueTween, time, isComplete);

                time += delay;
            }
        }

    }


    private function tweenTo(view:IView, x:Number, delay:Number, isOnComplete:Boolean = false):void
    {
        var duration:Number = ConstantsBase.ANIMATION_DURATION * 2;

        var tweenParam:Object =
        {
            x         : x,
//            ease      : Linear.easeNone,
            onComplete: isOnComplete ? tweenEnd : null
        };

        Utils.performAfterDelay(delay, function ():void
        {
            TweenMax.to(view.source, duration, tweenParam);
        });

    }

    private function tweenEnd():void
    {
        _isTweenEnd = true;
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        if (!_isPlaceItems)
        {
            _isPlaceItems = true;

            var startX:int = 0;
            var startY:int = 0;

            var positionX:int = startX;
            for each (var items:Array in _viewsItems)
            {
                for (var i:int = 0; i < items.length; i++)
                {
                    var viewItem:IView = items[i];

                    viewItem.placeViews(fullscreen);

                    viewItem.source.x = positionX;
                    viewItem.source.y = startY;

                    if ((i + 1) % 5 == 0)
                    {
                        positionX = startX;
                        startY += viewItem.source.height + _gepItemsY;
                    }
                    else
                    {
                        positionX += viewItem.source.width + _gepItemsX;
                    }
                }
                startX += (viewItem.source.width + _gepItemsX) * 5;
                positionX = startX;
                startY = 0;
            }
        }

        _viewNavigationBar.x = 279;
        _viewNavigationBar.y = 410;

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonBack.cleanup();
        _buttonBack = null;

        _buttonNext.cleanup();
        _buttonNext = null;

        super.cleanup();
    }


}
}
