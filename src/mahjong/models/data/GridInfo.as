/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import core.DisposableObject;

import flash.geom.Point;

import serialization.ISerializable;

import utils.Utils;
import utils.UtilsArray;

public class GridInfo extends DisposableObject implements ISerializable
{
    /*
     * Fields
     */
    private var _sizeGrid:Point;

    private var _countChips:int;

    private var _chips:Array;

    /*
     * Properties
     */
    public function get chips():Array
    {
        return _chips;
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
        _chips = [];

        for (var i:int = ETypeBamboo.ETB_0; i < ETypeBamboo.ETB_COUNT; i++)
        {
            var chip0:ChipInfo = new ChipInfo();
            chip0.value = i;
            _chips.push(chip0);

            var chip1:ChipInfo = new ChipInfo();
            chip1.value = i;
            _chips.push(chip1);
        }

        UtilsArray.shuffle(_chips);
        UtilsArray.shuffle(_chips);

        generatorMahjong();
    }

    private function generatorMahjong():void
    {
        var chips:Array = [];

        for (var z:int = 0; z < 3; z++)
        {
            var chipByY:Array = [];

            for (var y:int = 0; y < 10; y++)
            {
                var chipByX:Array = [];

                for (var x:int = 0; x < 10; x++)
                {
                    var randomFactor:int = Math.round(Utils.randomFromTo(0, 1));

                    var chipSet:Boolean = randomFactor != 0;

                    chipByX.push(chipSet);
                }
                chipByY.push(chipByX);
            }
            chips.push(chipByY);
        }

        Debug.assert(false, "no implement");
    }


    public function serialize():Object
    {
        Debug.assert(false, "no implement");
        return null;
    }


    public function deserialize(data:Object):void
    {
        _countChips = 10;
    }
}
}
