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
    private var _type:uint;

    private var _x:uint;
    private var _y:uint;
    private var _z:uint;


    /*
     * Properties
     */
    public function get type():uint
    {
        return _type;
    }


    public function get x():uint
    {
        return _x;
    }

    public function get y():uint
    {
        return _y;
    }

    public function get z():uint
    {
        return _z;
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
        Debug.assert(data.hasOwnProperty("x"));
        Debug.assert(data.hasOwnProperty("y"));
        Debug.assert(data.hasOwnProperty("z"));

        _x = data["x"];
        _y = data["y"];
        _z = data["z"];
    }
}
}
