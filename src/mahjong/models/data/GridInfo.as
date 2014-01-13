/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import core.DisposableObject;

import serialization.ISerializable;

import utils.UtilsArray;

public class GridInfo extends DisposableObject implements ISerializable
{
    /*
     * Fields
     */
    private var _layersChips:Array;

    /*
     * Properties
     */
    public function get chips():Array
    {
        return _layersChips;
    }

    /*
     * Methods
     */
    public function GridInfo()
    {
        super(false);

        init();
    }

    private function init():void
    {
        _layersChips = [];

    }


    public function serialize():Object
    {
        Debug.assert(false, "no implement");
        return null;
    }


    public function deserialize(data:Object):void
    {

        for each(var columnZ:Array in data["grid"])
        {
            var layerChips:Array = [];

            for each(var columnY:Array in columnZ)
            {
                for each(var columnX:Object in columnY)
                {
                    if (columnX["setChip"] == true)
                    {
                        var chipInfo:ChipInfo = new ChipInfo();
                        chipInfo.deserialize(columnX);
                        layerChips.push(chipInfo);
                    }

                }
            }
            UtilsArray.shuffle(layerChips);
            _layersChips.push(layerChips);
        }
    }
}
}
