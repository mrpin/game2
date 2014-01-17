/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.data
{
import models.implementations.levels.LevelInfoBase;

public class LevelInfo extends LevelInfoBase
{
    /*
     * Fields
     */
    private var _gridCarcass:Array;


    /*
     * Properties
     */
    public function get gridCarcass():Array
    {
        return _gridCarcass;
    }


    /*
     * Methods
     */
    public function LevelInfo()
    {


        init();
    }

    private function init():void
    {

    }


    override public function serialize():Object
    {
        return super.serialize();
    }


    override public function deserialize(data:Object):void
    {
        Debug.assert(data.hasOwnProperty("grid_data"));

        _gridCarcass = [];


        for each(var layerZ:Array in data["grid_data"])
        {
            var layerY:Array = [];

            for each(var layY:Array in layerZ)
            {
                var layerX:Array = [];

                for each(var chip:Object in layY)
                {
                    var newChip:ChipInfo = new ChipInfo();

                    newChip.deserialize(chip);
                    layerX.push(newChip);
                }
                layerY.push(layerX);
            }
            _gridCarcass.push(layerY);
        }

        super.deserialize(data);
    }
}
}
