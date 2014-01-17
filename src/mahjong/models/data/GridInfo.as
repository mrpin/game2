/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import core.DisposableObject;

import serialization.ISerializable;

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
        Debug.assert(data is Array);

        var layerZ:Array = data as Array;

        for each(var columnZ:Array in layerZ)
        {
            var layerY:Array = [];

            for each(var columnY:Array in columnZ)
            {
                var layerX:Array = [];

                for each(var chipData:Object in columnY)
                {
                    var chipInfo:ChipInfo = new ChipInfo();
                    chipInfo.deserialize(chipData);
                    layerX.push(chipInfo);
                }
                layerY.push(layerX);
            }
            _layersChips.push(layerY);
        }
    }
}
}
