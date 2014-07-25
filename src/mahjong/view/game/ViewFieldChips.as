/**
 * Created by evgenyyurko on 12.01.14.
 */
package mahjong.view.game
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import views.implementations.ViewBase;

public class ViewFieldChips extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewsChips:Array;

    private var _isPlaceViewsChips:Boolean;


    /*
     * Properties
     */
    public function set viewsChips(value:Array):void
    {
        if (_viewsChips == value)
        {
            return;
        }

        _viewsChips = value;

        for each(var chipsViewZ:Array in _viewsChips)
        {
            var diagonalsCount:int = chipsViewZ.length + chipsViewZ[0].length - 1;
            var diagonalMaxLength:int = Math.min(chipsViewZ.length, chipsViewZ[0].length);

            for (var diagonalNumber:int = 0; diagonalNumber < diagonalsCount; diagonalNumber++)
            {
                var diagonalStartX:int = diagonalNumber < chipsViewZ.length ? chipsViewZ.length - diagonalNumber - 1 : 0;
                var diagonalStartY:int = diagonalNumber < chipsViewZ.length ? 0 : diagonalNumber - chipsViewZ.length + 1;


                var diagonalLength:int = Math.min((diagonalNumber + 1), diagonalMaxLength, (diagonalsCount - diagonalNumber));

                for (var chipDiagonalNumber:int = 0; chipDiagonalNumber < diagonalLength; chipDiagonalNumber++)
                {
                    var chipView:ViewChip = chipsViewZ[diagonalStartX + chipDiagonalNumber][diagonalStartY + chipDiagonalNumber];

                    if (chipView.source.visible == true)
                    {
                        _source.addChild(chipView.source);
                    }
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
    }

    private function init():void
    {
        _isPlaceViewsChips = false;
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        if (!_isPlaceViewsChips)
        {
            var startPositionX:int = 0;
            var startPositionY:int = 0;

            for each (var chipsViewZ:Array in _viewsChips)
            {
                var positionX:int = startPositionX;
                for each (var chipsViewY:Array in chipsViewZ)
                {
                    var positionY:int = startPositionY;

                    for each(var chipView:ViewChip in chipsViewY)
                    {
                        chipView.source.x = positionX;
                        chipView.source.y = positionY;

                        positionY += (chipView.size.y / 2) - 2;//offsetY + 3;

                        chipView.placeViews(fullscreen);
                    }
                    positionX += (chipView.size.x / 2) - 2; //offsetX;
                }

                startPositionX += 4;
                startPositionY -= 4;
            }

            _isPlaceViewsChips = !_isPlaceViewsChips;
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _source = null;

        _viewsChips = null;

        super.cleanup();
    }


}
}
