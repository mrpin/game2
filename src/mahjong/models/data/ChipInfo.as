/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{

import controllers.interfaces.IController;

import core.implementations.Debug;
import core.implementations.DisposableObject;

import serialization.ISerializable;

public class ChipInfo extends DisposableObject implements ISerializable
{
    /*
     * Static
     */

    public static const CHIP_EMPTY:ChipInfo = new ChipInfo();

    public static function getChipEmpty(gridOwner:Array):ChipInfo
    {
        var result:ChipInfo = new ChipInfo();

        result._chipType = EChipType.ETB_EMPTY;
        result._gridOwner = gridOwner;

        return result;
    }

    public static function getCloneWithType(target:ChipInfo, typeValue:int):ChipInfo
    {
        var result:ChipInfo = new ChipInfo();

        result._x = target.x;
        result._y = target.y;
        result._z = target.z;

        result._chipType = typeValue;

        return result;
    }


    /*
     * Fields
     */
    private var _chipType:int;

    private var _x:int;
    private var _y:int;
    private var _z:int;

    private var _gridOwner:Array;

    private var _controller:IController;


    /*
     * Properties
     */
    public function get controller():IController
    {
        return _controller;
    }

    public function set controller(value:IController):void
    {
        if (_controller == value)
            return;

        _controller = value;
    }


    public function set grid(value:Array):void
    {
        //TODO: review
    }

    public function get isEnabled():Boolean
    {
        var result:Boolean = false;

        var neighborTop:ChipInfo = null;

        var neighborTopYLeft:ChipInfo = null;
        var neighborTopYRight:ChipInfo = null;

        var neighborTopXLeft:ChipInfo = null;
        var neighborTopXRight:ChipInfo = null;

        var neighborTopYRightXRight:ChipInfo = null;
        var neighborTopYLeftXRight:ChipInfo = null;
        var neighborTopXLeftYLeft:ChipInfo = null;
        var neighborTopXLeftYRight:ChipInfo = null;

        var neighborYLeft:ChipInfo = null;
        var neighborYRight:ChipInfo = null;

        var neighborXLeft:ChipInfo = null;
        var neighborXRight:ChipInfo = null;

        var neighborYRightXRight:ChipInfo = null;
        var neighborXRightYRight:ChipInfo = null;
        var neighborXRightYLeft:ChipInfo = null;
        var neighborYLeftXRight:ChipInfo = null;
        var neighborYLeftXLeft:ChipInfo = null;
        var neighborXLeftYLeft:ChipInfo = null;
        var neighborXLeftYRight:ChipInfo = null;
        var neighborYRightXLeft:ChipInfo = null;

        Debug.assert(_gridOwner[0][0].length > 3);
        Debug.assert(_gridOwner[0].length > 3);

        if (_z < _gridOwner.length - 1)
        {
            neighborTop = _gridOwner[_z + 1][_y][_x];

            neighborTopYLeft = _y > 0 ? _gridOwner[_z + 1][_y - 1][_x] : null;

            neighborTopYRight = _y < _gridOwner[0].length - 1 ? _gridOwner[_z + 1][_y + 1][_x] : null;

            neighborTopXLeft = _x > 0 ? _gridOwner[_z + 1][_y][_x - 1] : null;

            neighborTopXRight = _x < _gridOwner[0][0].length - 1 ? _gridOwner[_z + 1][_y][_x + 1] : null;


            neighborTopYRightXRight = ((_y < _gridOwner[0].length - 1) && (_x < _gridOwner[0][0].length - 1)) ? _gridOwner[_z + 1][_y + 1][_x + 1] : null;

            neighborTopYLeftXRight = (_y > 0 && (_x < _gridOwner[0][0].length - 1)) ? _gridOwner[_z + 1][_y - 1][_x + 1] : null;

            neighborTopXLeftYLeft = (_x > 0 && _y > 0) ? _gridOwner[_z + 1][_y - 1][_x - 1] : null;

            neighborTopXLeftYRight = (_x > 0 && (_y < _gridOwner[0].length - 1)) ? _gridOwner[_z + 1][_y + 1][_x - 1] : null;
        }

        neighborYLeft = _y > 1 ? _gridOwner[_z][_y - 2][_x] : null;

        neighborYRight = _y < _gridOwner[0].length - 2 ? _gridOwner[_z][_y + 2][_x] : null;

        neighborXLeft = _x > 1 ? _gridOwner[_z][_y][_x - 2] : null;

        neighborXRight = _x < _gridOwner[0][0].length - 2 ? _gridOwner[_z][_y][_x + 2] : null;


        neighborYRightXRight = ((_y < _gridOwner[0].length - 2) && (_x < _gridOwner[0][0].length - 1)) ? _gridOwner[_z][_y + 2][_x + 1] : null;
        neighborXRightYRight = ((_y < _gridOwner[0].length - 1) && (_x < _gridOwner[0][0].length - 2)) ? _gridOwner[_z][_y + 1][_x + 2] : null;

        neighborXRightYLeft = (_y > 0 && (_x < _gridOwner[0][0].length - 2)) ? _gridOwner[_z][_y - 1][_x + 2] : null;

        neighborYLeftXRight = (_y > 1 && (_x < _gridOwner[0][0].length - 1)) ? _gridOwner[_z][_y - 2][_x + 1] : null;
        neighborYLeftXLeft = (_x > 1 && _y > 1) ? _gridOwner[_z][_y - 2][_x - 1] : null;

        neighborXLeftYLeft = (_x > 0 && _y > 0) ? _gridOwner[_z][_y - 1][_x - 2] : null;

        neighborXLeftYRight = (_x > 0 && (_y < _gridOwner[0].length - 1)) ? _gridOwner[_z][_y + 1][_x - 2] : null;
        neighborYRightXLeft = (_x > 0 && (_y < _gridOwner[0].length - 2)) ? _gridOwner[_z][_y + 2][_x - 1] : null;


        var isNeighborTopEmpty:Boolean = (neighborTop == null || neighborTop.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopYLeftEmpty:Boolean = (neighborTopYLeft == null || neighborTopYLeft.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopYRight:Boolean = (neighborTopYRight == null || neighborTopYRight.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopXLeft:Boolean = (neighborTopXLeft == null || neighborTopXLeft.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopXRight:Boolean = (neighborTopXRight == null || neighborTopXRight.chipType == EChipType.ETB_EMPTY);

        var isNeighborTopYRightXRightEmpty:Boolean = (neighborTopYRightXRight == null || neighborTopYRightXRight.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopYLeftXRightEmpty:Boolean = (neighborTopYLeftXRight == null || neighborTopYLeftXRight.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopXLeftYLeftEmpty:Boolean = (neighborTopXLeftYLeft == null || neighborTopXLeftYLeft.chipType == EChipType.ETB_EMPTY);
        var isNeighborTopXLeftYRightEmpty:Boolean = (neighborTopXLeftYRight == null || neighborTopXLeftYRight.chipType == EChipType.ETB_EMPTY);


        if ((isNeighborTopEmpty && isNeighborTopYLeftEmpty && isNeighborTopYRight && isNeighborTopXLeft && isNeighborTopXRight) &&
                (isNeighborTopYRightXRightEmpty && isNeighborTopYLeftXRightEmpty && isNeighborTopXLeftYLeftEmpty && isNeighborTopXLeftYRightEmpty))
        {
            var isNeighborXLeft:Boolean = neighborXLeft == null || neighborXLeft.chipType == EChipType.ETB_EMPTY;
            var isNeighborXRight:Boolean = neighborXRight == null || neighborXRight.chipType == EChipType.ETB_EMPTY;
            var isNeighborYLeft:Boolean = neighborYLeft == null || neighborYLeft.chipType == EChipType.ETB_EMPTY;
            var isNeighborYRight:Boolean = neighborYRight == null || neighborYRight.chipType == EChipType.ETB_EMPTY;

            var isNeighborYRightXRight:Boolean = neighborYRightXRight == null || neighborYRightXRight.chipType == EChipType.ETB_EMPTY;
            var isNeighborXRightYRight:Boolean = neighborXRightYRight == null || neighborXRightYRight.chipType == EChipType.ETB_EMPTY;
            var isNeighborXRightYLeft:Boolean = neighborXRightYLeft == null || neighborXRightYLeft.chipType == EChipType.ETB_EMPTY;
            var isNeighborYLeftXRight:Boolean = neighborYLeftXRight == null || neighborYLeftXRight.chipType == EChipType.ETB_EMPTY;
            var isNeighborYLeftXLeft:Boolean = neighborYLeftXLeft == null || neighborYLeftXLeft.chipType == EChipType.ETB_EMPTY;
            var isNeighborXLeftYLeft:Boolean = neighborXLeftYLeft == null || neighborXLeftYLeft.chipType == EChipType.ETB_EMPTY;
            var isNeighborXLeftYRight:Boolean = neighborXLeftYRight == null || neighborXLeftYRight.chipType == EChipType.ETB_EMPTY;
            var isNeighborYRightXLeft:Boolean = neighborYRightXLeft == null || neighborYRightXLeft.chipType == EChipType.ETB_EMPTY;

//            result = ((isNeighborXLeft || isNeighborXRight) && (isNeighborYRight || isNeighborYLeft));

            result = (((isNeighborXLeftYLeft && isNeighborXLeft && isNeighborXLeftYRight) || (isNeighborXRightYRight && isNeighborXRight && isNeighborXRightYLeft)) &&
                    ((isNeighborYRightXRight && isNeighborYRight && isNeighborYRightXLeft) || (isNeighborYLeftXRight && isNeighborYLeft && isNeighborYLeftXLeft)));
        }


        return result;
    }

    public function get chipType():int
    {
        return _chipType;
    }

    public function set chipType(value:int):void
    {
        _chipType = value;
    }

    public function get x():int
    {
        return _x;
    }

    public function set x(value:int):void
    {
        _x = value;
    }

    public function get y():int
    {
        return _y;
    }

    public function set y(value:int):void
    {
        _y = value;
    }

    public function get z():int
    {
        return _z;
    }

    public function set z(value:int):void
    {
        _z = value;
    }

    public function set gridOwner(value:Array):void
    {
        _gridOwner = value;
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
    }
}
}
