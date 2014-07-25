/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import com.greensock.TweenMax;
import com.greensock.easing.Linear;

import controllers.interfaces.IController;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.registerClassAlias;
import flash.utils.setTimeout;

import mahjong.GameInfo;

import utils.Utils;

import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Static
     */


    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _chip:gChip;

    private var _viewAnimationKillChip:gChipAnimations;

    private var _size:Point;

    private var _positionStart:Point;


    /*
     * Properties
     */
    public function set type(value:int):void
    {
        _chip.viewArt.gotoAndStop(value + 1);
    }

    public function get size():Point
    {
        return _size;
    }

    /*
     * Methods
     */
    public function ViewChip(controller:IController)
    {
        _source = new Sprite();

        super(controller, _source);

        init();
    }

    private function init():void
    {
        _positionStart = new Point();

        _chip = new gChip();
        _chip.cacheAsBitmap = true;


        _source.addChild(_chip);
        _chip.showPair.visible = false;

        _chip.showPair.stop();

        _size = new Point(_chip.viewChip.width, _chip.viewChip.height);

        _viewAnimationKillChip = new gChipAnimations();
        _viewAnimationKillChip.cacheAsBitmap = true;

        _source.addChild(_viewAnimationKillChip);
        _viewAnimationKillChip.gotoAndStop(1);
        _viewAnimationKillChip.visible = false;

        hideAllEffects();
    }

    //TODO:review
    public static function rasterizeMovieClip(clip : Sprite):void
    {
        var clipContentsBound:Rectangle = clip.getBounds(clip);
        var bitmapData : BitmapData = new BitmapData(clipContentsBound.width, clipContentsBound.height, true, 0x00000000);
        var matrix:Matrix = new Matrix();
        matrix.translate( - clipContentsBound.x, - clipContentsBound.y);
        bitmapData.draw(clip, matrix);
        while (clip.numChildren > 0) clip.removeChildAt(0);
        clip.graphics.clear();
        var bitmap:Bitmap = new Bitmap(bitmapData);
        bitmap.x = clipContentsBound.x;
        bitmap.y = clipContentsBound.y;
        clip.addChild(bitmap);
    }

    public function moveChipTo(point:Point, time:Number):void
    {
        var tweenParam:Object =
        {
            x: point.x,
            y: point.y
        };

        TweenMax.to(_source, time, tweenParam);
    }

    public function showEffectSelectChip():void
    {
        hideAllEffects();
        _chip.selectChip.visible = true;
    }

    public function showEffectNotActiveChip():void
    {
        hideAllEffects();
        _chip.notActive.visible = true;
    }

    public function showEffectHint(time:Number, isAutoHint:Boolean, isCyclic:Boolean = false):void
    {
        if (!GameInfo.instance.managerGame.isOnButtonHint && !isAutoHint)
        {
            return;
        }

        TweenMax.killTweensOf(_chip.showPair);
        _chip.showPair.visible = true;
        _chip.showPair.gotoAndStop(1);

        var tweenParam:Object =
        {
            frame: _chip.showPair.totalFrames,
            ease : Linear.easeNone
        };

        TweenMax.to(_chip.showPair, time, tweenParam);

        var timeDelay:Number = ConstantsBase.ANIMATION_DURATION * 4 * 1000 * 2;

        if (_chip.visible == true && isCyclic && !isAutoHint)
        {
            Utils.performAfterDelay(timeDelay, function ():void
            {
                showEffectHint(time, isAutoHint, isCyclic);
            });
        }

    }

    public function playAnimationRemoveChip(time:Number):void
    {
        playAnimation(time, true);
    }

    public function playAnimationCancelMove(time:Number):void
    {
        playAnimation(time, false);
    }

    public function playAnimation(time:Number, directionAnimation:Boolean):void
    {
        hideAllEffects();

        _chip.visible = false;
        _viewAnimationKillChip.visible = true;

        _viewAnimationKillChip.gotoAndStop(directionAnimation ? 1 : _viewAnimationKillChip.totalFrames);

        var tweenParam:Object =
        {
            frame     : !directionAnimation ? 1 : _viewAnimationKillChip.totalFrames,
            ease      : Linear.easeNone,
            onComplete: function ():void
            {
                _viewAnimationKillChip.visible = directionAnimation;
                _chip.visible = !directionAnimation;
            }
        };

        TweenMax.to(_viewAnimationKillChip, time, tweenParam);

        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        //TODO:review
        var positionX:Number = !directionAnimation ? _positionStart.x : -_source.parent.x + 50;
        var positionY:Number = !directionAnimation ? _positionStart.y : (-_source.parent.y + appSize.y - _source.height) - 215;

        Utils.performAfterDelay(time * 1000, function ():void
        {
            //TODO:review
//            moveChipTo(new Point(positionX, positionY), time / 2);
            _viewAnimationKillChip.stop();
        });
    }

    public function hideAllEffects():void
    {
        _chip.selectChip.visible = false;
        _chip.notActive.visible = false;

        _chip.showPair.visible = false;
        _chip.showPair.gotoAndStop(1);
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        killTween(true);

        _positionStart.x = _source.x;
        _positionStart.y = _source.y;
    }

    /*
     * IDisposable
     */
    private function killTween(onComplete:Boolean = false):void
    {
        TweenMax.killTweensOf(_chip.showPair, onComplete);
        TweenMax.killTweensOf(_source, onComplete);
        TweenMax.killTweensOf(_viewAnimationKillChip, onComplete);

    }

    public override function cleanup():void
    {
        killTween();

        _chip.showPair.stop();

        _viewAnimationKillChip.stop();
        _viewAnimationKillChip = null;

        _chip = null;
        _source = null;

        super.cleanup();
    }


}
}
