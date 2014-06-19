/**
 * Created by evgenyyurko on 6/18/14.
 */
package mahjong.view.base
{
import com.greensock.TweenMax;

import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Point;

import mahjong.GameInfo;

import views.implementations.ViewBase;

public class ViewParallax extends ViewBase implements IViewParallax
{
    /*
     * Static
     */

    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _moveLimits:Point;

    private var _appSize:Point;

    private var _startPosition:Point;

    private var _duration:Number;

    private var _moveDirection:Point;

    private var _stage:Stage;

    private var _currentRelativeOffset:Point;

    private var _typeTween:Function;


    /*
     * Properties
     */
    public function get moveLimits():Point
    {
        return _moveLimits;
    }

    public function set moveLimits(value:Point):void
    {
        _moveLimits = value;
    }

    public function get moveDirection():Point
    {
        return _moveDirection;
    }

    public function set moveDirection(value:Point):void
    {
        _moveDirection = value;
    }

    public function set duration(value:Number):void
    {
        _duration = value;
    }

    public function set typeTween(value:Function):void
    {
        _typeTween = value;
    }

    /*
     * Events
     */
    override protected function onMouseMove(e:MouseEvent):void
    {
        if (e.stageX < 0)
        {
            return;
        }

        updatePosition(true);

        super.onMouseMove(e);
    }

    /*
     * Methods
     */
    public function ViewParallax(controller:IController, source:DisplayObjectContainer)
    {
        _source = source;
        super(controller, _source);

        init();
    }

    private function init():void
    {
        handleEvents(false, true);

        _currentRelativeOffset = new Point();
        _moveLimits = new Point(0, 0);
        _startPosition = new Point(0, 0);
        _moveDirection = new Point(0, 0);

        _stage = GameInfo.instance.managerApp.applicationStage;

        _duration = 0;
    }

    private function tween(position:Point, duration:Number):void
    {
        var tweenParam:Object =
        {
            x   : position.x,
            y   : position.y,
            ease: _typeTween
        };

        TweenMax.to(_source, duration, tweenParam);
    }

    private function updatePosition(isAnimated:Boolean = true):void
    {
        var moveTo:Point = new Point();

        _currentRelativeOffset.x = (_moveLimits.x / _appSize.x) * (_stage.mouseX - (_appSize.x / 2));
        _currentRelativeOffset.y = (_moveLimits.y / _appSize.y) * (_stage.mouseY - (_appSize.y / 2));


        moveTo.x = _startPosition.x + (_currentRelativeOffset.x * _moveDirection.x);
        moveTo.y = _startPosition.y + (_currentRelativeOffset.y * _moveDirection.y);

        if (isAnimated)
        {
            tween(moveTo, _duration);
        }
        else
        {
            tween(moveTo, 0);
        }
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);

        _appSize = GameInfo.instance.managerApp.applicationSize;

        _startPosition = new Point(_source.x, _source.y);

        updatePosition(false);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        TweenMax.killChildTweensOf(_source);

        _source = null;

        super.cleanup();
    }


}
}
