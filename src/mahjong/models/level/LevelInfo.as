/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.level
{
import core.implementations.Debug;

import mahjong.models.data.*;

import models.implementations.levels.LevelInfoBase;
import models.interfaces.levels.ILevelContainer;

public class LevelInfo extends LevelInfoBase
{
    /*
     * Fields
     */
    private var _progress:LevelProgress;

    private var _gridCarcass:Array;

    private var _typeAdvanced:String;

    private var _timeLeft:Number;

    //безошибочное прохождение
    private var _isCompleteNoErrors:Boolean;
    //количество раз пройден уровень
    private var _countPlaythroughsLevel:uint;
    //минимальное время за которое пройден уровень
    private var _minTimePassing:Number;


    /*
     * Properties
     */
    public function get gridCarcass():Array
    {
        return _gridCarcass;
    }

    public function get timeLeft():Number
    {
        return _timeLeft;
    }

    public function get typeAdvanced():String
    {
        return _typeAdvanced;
    }

    public function get isCompleteNoErrors():Boolean
    {
        return _isCompleteNoErrors;
    }

    public function set isCompleteNoErrors(value:Boolean):void
    {
        _isCompleteNoErrors = value;

        setStar3ByType();
    }


    public function get countPlaythroughsLevel():uint
    {
        return _countPlaythroughsLevel;
    }

    public function set countPlaythroughsLevel(value:uint):void
    {
        _countPlaythroughsLevel = value;

        setStar3ByType();
    }

    public function get isStarForSpeedPassing():Boolean
    {
        return (_minTimePassing / _timeLeft * 100) <= 60;
    }

    public function set timePassing(value:Number):void
    {
        if (value < _minTimePassing)
        {
            _minTimePassing = value;

            setStar3ByType();
        }
    }

    public function set rewardCurrencySoftLevel(value:Number):void
    {
        _rewardCurrencySoft = value;
    }

    public function get progress():LevelProgress
    {
        return _progress;
    }

    public function get countStarReception():uint
    {
        var result:uint = 0;

        result += _progress.isStar1Received ? 1 : 0;
        result += _progress.isStar2Received ? 1 : 0;
        result += _progress.isStar3Received ? 1 : 0;

        return result;
    }



    /*
     * Methods
     */
    public function LevelInfo(levelContainer:ILevelContainer)
    {
        super(levelContainer);

        init();
    }

    private function init():void
    {
        _isCompleteNoErrors = false;
        _countPlaythroughsLevel = 0;
    }

    protected override function initLevelProgress(data:Object):void
    {
        _progress = new LevelProgress(this);
        _progress.deserialize(data);

        _progressBase = _progress;

        if(progress.complete)
        {
            _rewardCurrencySoft = 0;
        }
    }

    override public function serialize():Object
    {
        return super.serialize();


    }

    public function isMadePurchase(value:Boolean):void
    {
        _progress.isStar2Received = value;
    }

    public function setStar3ByType():void
    {
        switch (_typeAdvanced)
        {
            case ELevelMode.ELM_ADVANCED:
            {
                if(isCompleteNoErrors)
                {
                    _progress.isStar3Received = true;
                }

                break;
            }
            case ELevelMode.ELM_CLASSIC:
            {
                if (countPlaythroughsLevel > 1)
                {
                    _progress.isStar3Received = true;
                }

                break;
            }
            case ELevelMode.ELM_TIME:
            {
                if(isStarForSpeedPassing)
                {
                    _progress.isStar3Received = true;
                }

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }
    }


    override public function deserialize(data:Object):void
    {
        Debug.assert(data.hasOwnProperty("grid_data"));
        _typeAdvanced = Debug.assertProperty(data, "type_complication");
        _timeLeft = Debug.assertProperty(data, "time_left");
        _minTimePassing = _timeLeft;

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
