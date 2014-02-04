/**
 * Created by evgenyyurko on 12.01.14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;

import views.IView;
import views.implementations.ViewBase;

public class ViewFieldChips extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewsChips:Array;


    /*
     * Properties
     */
    public function set viewsChips(value:Array):void
    {
        _viewsChips = value;

        for each(var chipsViewZ:Array in _viewsChips)
        {
            for each(var chipsViewY:Array in chipsViewZ)
            {
                for each(var chipView:IView in chipsViewY)
                {
                    _source.addChild(chipView.source);
                }
            }
        }
    }

    public function get width():uint
    {
        var result:uint = _viewsChips[0][0].length / 2;
        return result * 65;
    }

    public function get height():uint
    {
        var result:uint = _viewsChips[0].length / 2;
        return result * 100;
    }

    /*
     * Methods
     */
    public function ViewFieldChips(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

    }

    override public function placeViews(fullscreen:Boolean):void
    {
        var startPositionX:int = 0;
        var startPositionY:int = 0;

        for each (var chipsViewZ:Array in _viewsChips)
        {
            var xPosition:int = startPositionX;
            var yPosition:int = startPositionY;

            for each (var chipsViewY:Array in chipsViewZ)
            {
                var positionX:int = xPosition;

                for each(var chipView:ViewChip in chipsViewY)
                {
                    chipView.placeViews(fullscreen);

                    chipView.x = positionX;
                    chipView.y = yPosition;

                    positionX -= chipView.offsetX;
                }
                yPosition += chipView.offsetY + 3;
            }

            startPositionX += 4;
            startPositionY -= 4;
        }

    }

    public function subViewRemove():void
    {
        for each(var chipsViewZ:Array in _viewsChips)
        {
            for each(var chipsViewY:Array in chipsViewZ)
            {
                for each(var chipView:IView in chipsViewY)
                {
                    _source.removeChild(chipView.source);
                    chipView = null;
                }
            }
        }

        _viewsChips = null;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
