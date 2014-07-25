/**
 * Created by evgenyyurko on 6/18/14.
 */
package mahjong.view.base.paralax
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;

import mahjong.GameInfo;

import utils.memory.UtilsMemory;

import views.implementations.ViewBase;

public class ViewParallax extends ViewBase implements IViewParallax
{
    /*
     * Static
     */
    private static function QuintEaseOut(t:Number, b:Number, c:Number, d:Number):Number
    {
        t /= d;
        t--;
        return c * (t * t * t * t * t + 1) + b;
    }


    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _moveLimits:Point;

    private var _appSize:Point;

    private var _startPosition:Point;

    private var _moveTo:Point;

    private var _positionLast:Point;

    private var _duration:Number;

    private var _moveDirection:Point;

    private var _stage:Stage;

    private var _hasRegisteredListener:Boolean;

    private var _currentRelativeOffset:Point;

    private var _deltaX:int;
    private var _deltaY:int;

    private var _currentFrameAnimation:uint;


    /*
     * Properties
     */

    public function set moveLimits(value:Point):void
    {
        _moveLimits = value;
    }

    public function set moveDirection(value:Point):void
    {
        _moveDirection = value;
    }

    public function set duration(value:Number):void
    {
        _duration = value;
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

        if (!_hasRegisteredListener)
        {
            UtilsMemory.registerEventListener(_source, Event.ENTER_FRAME, this, onEnterFrame);
            _hasRegisteredListener = true;
        }

        updateRelativePosition();
        updatePosition();

        _currentFrameAnimation = 0;

        super.onMouseMove(e);
    }

    private function updateRelativePosition():void
    {
        _currentRelativeOffset.x = (_moveLimits.x / _appSize.x) * (_stage.mouseX - (_appSize.x / 2));
        _currentRelativeOffset.y = (_moveLimits.y / _appSize.y) * (_stage.mouseY - (_appSize.y / 2));
    }

    private function moveItemAnimation(e:TimerEvent = null):void
    {
        _source.x = QuintEaseOut(_currentFrameAnimation, _positionLast.x, _deltaX, _duration * GameInfo.instance.managerApp.applicationStage.frameRate);
        _source.y = QuintEaseOut(_currentFrameAnimation, _positionLast.y, _deltaY, _duration * GameInfo.instance.managerApp.applicationStage.frameRate);
    }

    private function onEnterFrame(e:Event):void
    {
        _currentFrameAnimation++;
        if (Math.abs(_moveTo.x - _source.x) > 1 || Math.abs(_moveTo.y - _source.y) > 1)
        {
            moveItemAnimation();
        }
        else
        {
            _source.x = _moveTo.x;
            _source.y = _moveTo.y;

            UtilsMemory.unregisterEventListener(_source, Event.ENTER_FRAME, this, onEnterFrame);
            _hasRegisteredListener = false;
        }
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
        _moveLimits = new Point();
        _startPosition = new Point();
        _positionLast = new Point();
        _moveDirection = new Point();
        _moveTo = new Point();
        _hasRegisteredListener = false;
        _currentFrameAnimation = 0;

        _stage = GameInfo.instance.managerApp.applicationStage;

        _duration = 2;
    }

    private function updatePosition():void
    {
        _moveTo.x = _startPosition.x + (_currentRelativeOffset.x * _moveDirection.x);
        _moveTo.y = _startPosition.y + (_currentRelativeOffset.y * _moveDirection.y);

        _deltaX = _moveTo.x - _source.x;
        _deltaY = _moveTo.y - _source.y;

        _positionLast.x = _source.x;
        _positionLast.y = _source.y;
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);

        _appSize = GameInfo.instance.managerApp.applicationSize;

        _startPosition = new Point(_source.x, _source.y);

        updatePosition();
    }

    /*
     * IDisposable
     */

    public override function cleanup():void
    {
        if (_hasRegisteredListener)
        {
            UtilsMemory.unregisterEventListener(source, Event.ENTER_FRAME, this, onEnterFrame);
        }

        _source = null;

        super.cleanup();
    }


}
}
