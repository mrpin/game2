/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

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

    private var _size:Point;

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

    }

    public function get buttonNext():IViewButton
    {
        return _buttonNext;
    }

    public function get buttonBack():IViewButton
    {
        return _buttonBack;
    }

    public function get size():Point
    {
        return _size;
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

        _size = new Point(742, 471);
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        var startX:int = 0;
        var startY:int = 0;

        var positionX:int = startX;
        for each (var items:Array in _viewsItems)
        {
            for (var i:int = 0; i < items.length; i++)
            {
                var viewItem:IView = items[i];

                viewItem.source.x = positionX;
                viewItem.source.y = startY;

                if ((i + 1) % 5 == 0)
                {
                    positionX = startX;
                    startY += viewItem.source.height + 10;
                }
                else
                {
                    positionX += viewItem.source.width + 20;
                }
            }
            startX = (viewItem.source.width + 20) * 5;
            positionX = startX;
            startY = 0;
        }

        _viewNavigationBar.x = 279;
        _viewNavigationBar.y = 435;

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
