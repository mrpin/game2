/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;

import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Static
     */

    private static function getChipViewClass(index:int):Class
    {
        var result:Class = null;

        switch (index)
        {
            case EChipType.ETB_0:
            {
                result = gChip0;

                break;
            }
            case EChipType.ETB_1:
            {
                result = gChip1;

                break;
            }
            case EChipType.ETB_2:
            {
                result = gChip2;

                break;
            }
            case EChipType.ETB_3:
            {
                result = gChip3;

                break;
            }
            case EChipType.ETB_4:
            {
                result = gChip4;

                break;
            }
            case EChipType.ETB_5:
            {
                result = gChip5;

                break;
            }
            case EChipType.ETB_6:
            {
                result = gChip6;

                break;
            }
            case EChipType.ETB_7:
            {
                result = gChip7;

                break;
            }
            case EChipType.ETB_EMPTY:
            {
                result = Sprite;

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }

        return result;
    }

    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _offsetX:Number;
    private var _offsetY:Number;

    /*
     * Properties
     */
    public function get offsetX():Number
    {
        return _offsetX;
    }

    public function get offsetY():Number
    {
        return _offsetY;
    }

    public function set enabled(value:Boolean):void
    {
        //TODO:Implement!
        Debug.assert(false, "Implement");
    }

    public function set filter(value:Array):void
    {
        _source.filters = value;
    }

    /*
     * Methods
     */
    public function ViewChip(controller:IController, entry:ChipInfo)
    {
        var sourceClass:Class = getChipViewClass(entry.chipType);
        _source = new sourceClass();

        super(controller, _source);

        _offsetX = (entry.x % 2 == 0) ? 42 : 21;
        _offsetY = (entry.y % 2 == 0) ? 60 : 30;

        init();
    }

    private function init():void
    {

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
