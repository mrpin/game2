/**
 * Created by evgenyyurko on 5/26/14.
 */
package mahjong.view.game
{
import com.greensock.TweenMax;
import com.greensock.easing.Linear;

import controllers.interfaces.IController;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mahjong.GameInfo;

import utils.memory.UtilsMemory;

import views.implementations.ViewBase;

public class ViewMeasurePoints extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gMeasurePoints;

    private var _sprite:Sprite;
    private var _value:Number;

    private var _sizeYViewProgressLevel:Number;

    private var _timer:Timer;
    private var _timeStep:Number;

    /*
     * Properties
     */

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewMeasurePoints(controller:IController)
    {
        _source = new gMeasurePoints();
        super(controller, _source);


        init();
    }

    private function init():void
    {
        _sprite = new Sprite();

        _value = 0;

        _source.viewCounterCircle.mask = _sprite;

        _source.addChild(_sprite);

        _sizeYViewProgressLevel = _source.viewCounterColumn.height;
        _source.viewCounterColumn.height = 0;

        _source.viewStar.visible = false;
        _source.viewStar.gotoAndStop(1);

        var timeLeft:Number = GameInfo.instance.managerGame.currentLevel.timeLeft;
        _timeStep = (360 / timeLeft) / 10;
        _value -= _timeStep

    }

    public function moveTimer():void
    {
        _timer = new Timer(ConstantsBase.ANIMATION_DURATION * 4 * 1000 / 10, 11);
        UtilsMemory.registerEventListener(_timer, TimerEvent.TIMER, this, onTimerComplete);
        _timer.start();

    }

    public function visibleProgress(percent:Number):void
    {
        var time:Number = ConstantsBase.ANIMATION_DURATION * 4;
        var size:Number = _sizeYViewProgressLevel * percent / 100;

        var tweenParam:Object =
        {
            height    : size,
            ease      : Linear.easeNone,
            onComplete: goAnimationStar
        };
        TweenMax.to(_source.viewCounterColumn, time, tweenParam);
    }

    private function goAnimationStar():void
    {
        if (GameInfo.instance.managerGame.completedPercentageLevel == 100)
        {
            _source.viewStar.visible = true;

            var time:Number = ConstantsBase.ANIMATION_DURATION * 2;

            var tweenParam:Object =
            {
                frame: _source.viewStar.totalFrames,
                ease : Linear.easeNone
//                ease : Bounce.easeOut
            };
            TweenMax.to(_source.viewStar, time, tweenParam);
        }
    }

    private function onTimerComplete(event:TimerEvent):void
    {
//        if (-((360 * _value) % 360) < -359)
//        {
//            tryCleanupTimer();
//            return;
//        }

        _value -= _timeStep;

        var graphics:Graphics = _sprite.graphics;
        graphics.clear();

//        _value -= 360 / GameInfo.instance.managerGame.currentLevel.timeLeft / 30;
        graphics.beginFill(0);
        drawWedge(graphics, 38, 234, 37, _value /*-((360 * _value) % 360)*/, 90);
        graphics.endFill();
    }


    public static function drawWedge(target:Graphics, x:Number, y:Number, radius:Number, arc:Number, startAngle:Number = 0, yRadius:Number = 0):void
    {
        if (yRadius == 0)
            yRadius = radius;

        target.moveTo(x, y);

        var segAngle:Number, theta:Number, angle:Number, angleMid:Number, segs:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number;

        if (Math.abs(arc) > 360)
            arc = 360;

        segs = Math.ceil(Math.abs(arc) / 45);
        segAngle = arc / segs;
        theta = -(segAngle / 180) * Math.PI;
        angle = -(startAngle / 180) * Math.PI;
        if (segs > 0)
        {
            ax = x + Math.cos(startAngle / 180 * Math.PI) * radius;
            ay = y + Math.sin(-startAngle / 180 * Math.PI) * yRadius;
            target.lineTo(ax, ay);
            for (var i:int = 0; i < segs; ++i)
            {
                angle += theta;
                angleMid = angle - (theta / 2);
                bx = x + Math.cos(angle) * radius;
                by = y + Math.sin(angle) * yRadius;
                cx = x + Math.cos(angleMid) * (radius / Math.cos(theta / 2));
                cy = y + Math.sin(angleMid) * (yRadius / Math.cos(theta / 2));
                target.curveTo(cx, cy, bx, by);
            }
            target.lineTo(x, y);
        }
    }

    private function tryCleanupTimer():void
    {
        if (_timer != null)
        {
            _timer.stop();
            UtilsMemory.unregisterEventListener(_timer, TimerEvent.TIMER, this, onTimerComplete, false);
            _timer = null;
        }

    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        TweenMax.killTweensOf(_source.viewCounterColumn);
        TweenMax.killTweensOf(_source.viewStar);

        tryCleanupTimer();

        _source = null;

        super.cleanup();
    }


}
}
