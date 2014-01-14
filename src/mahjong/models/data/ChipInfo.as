/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{

import core.DisposableObject;

import mahjong.GameInfo;

import serialization.ISerializable;

public class ChipInfo extends DisposableObject implements ISerializable
{
    /*
     * Static
     */

    public static const CHIP_EMPTY:ChipInfo = new ChipInfo();

    /*
     * Fields
     */
    private var _chipType:uint;

    private var _x:uint;
    private var _y:uint;
    private var _z:uint;


    /*
     * Properties
     */
    public function set grid(value:Array):void
    {
        //TODO: review
    }

    public function get isEnabled():Boolean
    {
        var result:Boolean = false;

        var grid:Array = GameInfo.instance.managerGame.grid;

        var neighborTop:ChipInfo = null;

        var neighborTopYLeft:ChipInfo = null;
        var neighborTopYRight:ChipInfo = null;

        var neighborTopXLeft:ChipInfo = null;
        var neighborTopXRight:ChipInfo = null;

        var neighborYLeft:ChipInfo = null;
        var neighborYRight:ChipInfo = null;

        var neighborXLeft:ChipInfo = null;
        var neighborXRight:ChipInfo = null;

        Debug.assert(grid[1][1].length > 3);
        Debug.assert(grid[1].length > 3);

        if (_z < grid.length - 1)
        {
            neighborTop = grid[_z + 1][_y][_x];

            if (_y > 2)
            {
                neighborYLeft = grid[_z][_y - 2][_x];
                neighborTopYLeft = grid[_z + 1][_y - 1][_x];
            }


            if (_y < grid[1].length - 3)
            {
                neighborYRight = grid[_z][_y + 2][_x];
                neighborTopYRight = grid[_z + 1][_y + 1][_x];
            }

            if (_x > 2)
            {
                neighborXLeft = grid[_z][_y][_x - 2];
                neighborTopXLeft = grid[_z + 1][_y][_x - 1];
            }

            if (_x < grid[1][1].length - 3)
            {
                neighborXRight = grid[_z][_y][_x + 2];
                neighborTopXRight = grid[_z + 1][_y][_x + 1];
            }
        }

        if (neighborTop != null && neighborTop != ChipInfo.CHIP_EMPTY)
        {

        }

        Debug.assert(false, "TODO: implement");
        return result;
    }

    public function get chipType():uint
    {
        return _chipType;
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
        Debug.assert(data.hasOwnProperty("chip_type"));

        Debug.assert(data.hasOwnProperty("x"));
        Debug.assert(data.hasOwnProperty("y"));
        Debug.assert(data.hasOwnProperty("z"));

        _chipType = data["chip_type"];

        _x = data["x"];
        _y = data["y"];
        _z = data["z"];

        var bool:Boolean = isEnabled;
    }
}
}
