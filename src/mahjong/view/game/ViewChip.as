/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;

import mahjong.models.data.ETypeBamboo;

import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;


    /*
     * Properties
     */
    public function set enabled(value:Boolean):void
    {
        //TODO:Implement!
        Debug.assert(false, "Implement");
    }

    /*
     * Methods
     */
    public function ViewChip(controller:IController, chipType:int)
    {
        var sourceClass:Class = getChipViewClass(chipType);
        _source = new sourceClass();
        super(controller, _source);

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
            case ETypeBamboo.ETB_0:
            {
                result = gChip0;

                break;
            }
            case ETypeBamboo.ETB_1:
            {
                result = gChip1;

                break;
            }
            case ETypeBamboo.ETB_2:
            {
                result = gChip2;

                break;
            }
            case ETypeBamboo.ETB_3:
            {
                result = gChip3;

                break;
            }
            case ETypeBamboo.ETB_4:
            {
                result = gChip4;

                break;
            }
            case ETypeBamboo.ETB_5:
            {
                result = gChip5;

                break;
            }
            case ETypeBamboo.ETB_6:
            {
                result = gChip6;

                break;
            }
            case ETypeBamboo.ETB_7:
            {
                result = gChip7;

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
