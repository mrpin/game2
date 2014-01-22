/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.filters.GlowFilter;

import mahjong.models.data.ChipInfo;

import mahjong.models.data.EChipType;

import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _entry:ChipInfo;


    /*
     * Properties
     */
    public function set enabled(value:Boolean):void
    {
        //TODO:Implement!
        Debug.assert(false, "Implement");
    }

    public function get entry():ChipInfo
    {
        return _entry;
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
        var sourceClass:Class = getChipViewClass(entry["chipType"]);
        _source = new sourceClass();

        super(controller, _source);

        _entry = entry;



        init();
    }

    private function init():void
    {

    }

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
     * IDisposable
     */
    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
