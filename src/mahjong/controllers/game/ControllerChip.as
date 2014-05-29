/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import com.greensock.TweenMax;

import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Sprite;

import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.GlowFilter;
import flash.utils.Timer;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.view.game.ViewChip;

import views.interfaces.IView;

public class ControllerChip extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewChip;

    private var _entry:ChipInfo;

    /*
     * Properties
     */


    public function get entry():ChipInfo
    {
        return _entry;
    }

    public function get typeChip():int
    {
        return _entry["chipType"];
    }


    /*
     * Methods
     */
    public function ControllerChip(entry:ChipInfo)
    {
        _view = new ViewChip(this);

        _view.handleEvents(true, true);

        super(_view);

        _entry = entry;
        _entry.controller = this;

        init();
    }

    private function init():void
    {
        if (_entry.chipType != EChipType.ETB_EMPTY)
        {
            _view.type = _entry.chipType;
        }
        else
        {
            _view.source.visible = false;
        }
    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        if (entry.isEnabled)
        {
            GameInfo.instance.managerGame.checkCoincidenceChips(_entry);
        }

        return super.onViewClicked(view, e);
    }


    override public function update(type:String):void
    {


        switch (type)
        {
            case EControllerUpdate.ECUT_USER_SELECT_CHIP:
            {
                /*
                 color:uint=0xFF0000 – цвет свечения, по умолчанию красный
                 alpha:Number=1 – прозрачность, по умолчанию не прозрачное свечение
                 blurX:Number=6 – размытие по X, значение по умолчанию 6
                 blurY:Number=6 – размытие по Y, значение по умолчанию 6
                 strength:Number=2 – степень вдавливания. Может принимать значения от 0 до 255. Чем выше значение, тем сильнее контраст тени фильтра.
                 quality:int=1 – сколько раз применить фильтр. Может принимать значения от 1 до 3.
                 inner:Boolean=false – если задать значение true, то свечение направляется внутрь объекта
                 knockout:Boolean=false – если задать значение true, то визуальный объект становится не видимым, видно только само свечение.
                 */

//                       _view.viewFace.filter = [];

                var glow:GlowFilter = new GlowFilter(0x000000, 0.3, 70, 70, 50, 1, true);
//                var glow:GlowFilter = new GlowFilter(0xff0000, 1, 6, 6, 100, 1, true);

                _view.filter = [glow];
//                _view.chipFace.filters = [glow];

                break;
            }
            case EControllerUpdate.ECUT_USER_DESELECT_CHIP:
            {
                _view.filter = [];
//                _view.chipFace.filters = [];

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_CANCEL_MOVE:
            {
                _view.chipVisible = true;

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            {
                _view.goAnimation();
//                rate:uint, sprite:DisplayObjectContainer, V:Number = 8, K:Number = 0.1, xA:Number = 0, yA:Number = 4, minPixelLife:Number = 1.5, maxPixelLife:Number = 3, outAlpha:Number = 0.8, pixelsCount:uint = 1)
//                var pixelExplosion:PixelExplosion = new PixelExplosion(20, _view.source as DisplayObjectContainer, 2, 0.1, 0, 4, 0.5, 1.5, 1, 1);
//                _view.addChild(pixelExplosion);

                _view.chipVisible = false;
                break;
            }
            case EControllerUpdate.ECUT_SHOW_CHIPS_DISABLE:
            {
                _view.filter = [new GlowFilter(0x000000, 0.5, 70, 70, 50, 1, true)];

                break;
            }
            case EControllerUpdate.ECUT_CHIP_SHOW_COMBINATION:
            {
                _view.filter = [new GlowFilter(0x000000, 0.5, 70, 70, 50, 1, true)];

                break;
            }
            case EControllerUpdate.ECUT_HIDE_CHIPS_DISABLE:
            {
                _view.filter = [];

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_SHUFFLE:
            {
                _view.type = _entry.chipType;
                _view.filter = [];

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }

    }

    function drawPieMask(graphics:Graphics, percentage:Number, radius:Number = 50, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void
    {
        // graphics should have its beginFill function already called by now
        graphics.moveTo(x, y);
        if (sides < 3) sides = 3; // 3 sides minimum
        // Increase the length of the radius to cover the whole target
        radius /= Math.cos(1 / sides * Math.PI);
        // Shortcut function
        var lineToRadians:Function = function (rads:Number):void
        {
            graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
        };
        // Find how many sides we have to draw
        var sidesToDraw:int = Math.floor(percentage * sides);
        for (var i:int = 0; i <= sidesToDraw; i++)
            lineToRadians((i / sides) * (Math.PI * 2) + rotation);
        // Draw the last fractioned side
        if (percentage * sides != sidesToDraw)
            lineToRadians(percentage * (Math.PI * 2) + rotation);
    }

//    function drawCircle(centerX:Number, centerY:Number, radius:Number, increment:Number, timeIncrement:Number, container:MovieClip){
//
////Define Variables
//        var radius:Number = radius;
//        var iniX:Number = centerX;
//        var iniY:Number = centerY;
//        var increment:Number = increment;
//        var totalDegrees:Number = 0;
//        var degInRad:Number;
//        var degInRad1:Number;
//        outline.visible = true;
//
////Create Timer
//        var maskTimer:Timer = new Timer(timeIncrement);
//        maskTimer.addEventListener(TimerEvent.TIMER, drawSegment);
//        maskTimer.start();
//
////Start Drawing
//        container.graphics.moveTo(iniX, iniY);
//        function drawSegment(e:TimerEvent){
//            if(totalDegrees < 362 && keepLoading){
//                //Convert to Radians
//                degInRad = totalDegrees * (Math.PI / 180);
//                degInRad1 = Number(totalDegrees+increment) * (Math.PI / 180);
//                //Find X,Y
//                var x1:Number = radius * Math.cos( degInRad ) + iniX;
//                var y1:Number = radius * Math.sin( degInRad ) + iniY;
//                var x2:Number = radius * Math.cos( degInRad1 ) + iniX;
//                var y2:Number = radius * Math.sin( degInRad1 ) + iniY;
//
//                var wedge:Sprite = new Sprite();
//                wedge.alpha = 0;
//
//                //Define Color
//                wedge.graphics.beginFill(0x000000);
//                wedge.graphics.moveTo(iniX, iniY);
//                wedge.graphics.lineTo(x1, y1);
//                wedge.graphics.lineTo(x2, y2);
//                wedge.graphics.lineTo(iniX, iniY);
//
//                //Fade In (Time == 1 in this example
//                TweenMax.to (wedge, 1, {alpha:1});
//                container.addChild(wedge);
//
//                totalDegrees+= increment
//                ;
//            }else{
//                maskTimer.stop();
//            }
//        }
//    }
    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view = null;

        super.cleanup();
    }


}
}
