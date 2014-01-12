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


    /*
     * Methods
     */
    public function ViewChip(controller:IController, valueType:int)
    {
        _source = chipType(valueType);
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }

    private static function chipType(index:int):DisplayObjectContainer
    {
        //TODO: разобратся что вписать место 8!
        Debug.assert(ETypeBamboo.ETB_COUNT == 8);

        var result:DisplayObjectContainer = null;

        switch (index)
        {
            case ETypeBamboo.ETB_0:
            {
                result = new gChip0();

                break;
            }
            case ETypeBamboo.ETB_1:
            {
                result = new gChip1();

                break;
            }
            case ETypeBamboo.ETB_2:
            {
                result = new gChip2();

                break;
            }
            case ETypeBamboo.ETB_3:
            {
                result = new gChip3();

                break;
            }
            case ETypeBamboo.ETB_4:
            {
                result = new gChip4();

                break;
            }
            case ETypeBamboo.ETB_5:
            {
                result = new gChip5();

                break;
            }
            case ETypeBamboo.ETB_6:
            {
                result = new gChip6();

                break;
            }
            case ETypeBamboo.ETB_7:
            {
                result = new gChip7();

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
