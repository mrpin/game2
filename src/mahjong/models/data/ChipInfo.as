/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import core.DisposableObject;

import serialization.ISerializable;

public class ChipInfo extends DisposableObject implements ISerializable
{
    /*
     * Fields
     */
    private var _value:uint;

    /*
     * Properties
     */
    public function get value():uint
    {
        return _value;
    }

    public function set value(value:uint):void
    {
        _value = value;
    }

    /*
     * Methods
     */
    public function ChipInfo()
    {
        super(false);

        init();
    }

    private function init():void
    {

    }


    public function serialize():Object
    {
        Debug.assert(false, "no implement");
        return null;
    }


    public function deserialize(data:Object):void
    {

    }
}
}
