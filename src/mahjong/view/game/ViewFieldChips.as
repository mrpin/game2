/**
 * Created by evgenyyurko on 12.01.14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

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

    /*
     * Methods
     */
    public function ViewFieldChips(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }

//TODO:доделать placeViews
    override public function placeViews(fullscreen:Boolean):void
    {
        var startPositionX:int = 0;
        var startPositionY:int = 0;

        var intervalOnX:int = 2;
        var intervalOnY:int = 2;

        for each (var chipsViewZ:Array in _viewsChips)
        {
            var xPosition:int = startPositionX;
            var yPosition:int = startPositionY;

            for each (var chipsViewY:Array in chipsViewZ)
            {
                var positionX:int = xPosition;

                for each(var chipView:ViewChip in chipsViewY)
                {
                    chipView.x = positionX;
                    chipView.y = yPosition;

                    positionX += chipView.entry.x % 2 ? 42 + intervalOnX : 21 + intervalOnX;
                }
                yPosition += chipView.entry.y % 2 ? 60 + intervalOnY : 30 +intervalOnY;
            }
            startPositionX -= 5;
            startPositionY -= 5;
        }
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
