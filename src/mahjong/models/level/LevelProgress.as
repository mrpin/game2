/**
 * Created by evgenyyurko on 6/15/14.
 */
package mahjong.models.level
{
import core.implementations.Debug;

import models.implementations.levels.LevelProgressBase;
import models.interfaces.levels.ILevelInfo;

public class LevelProgress extends LevelProgressBase
{
    /*
     * Fields
     */
    private var _isStar1Received:Boolean;
    private var _isStar2Received:Boolean;
    private var _isStar3Received:Boolean;

    private var _owner:LevelInfo;


    /*
     * Properties
     */
    public function get isStar1Received():Boolean
    {
        return _isStar1Received;
    }

    public function set isStar1Received(value:Boolean):void
    {
        _isStar1Received = value;
    }

    public function get isStar2Received():Boolean
    {
        return _isStar2Received;
    }

    public function set isStar2Received(value:Boolean):void
    {
        _isStar2Received = value;
    }

    public function get isStar3Received():Boolean
    {
        return _isStar3Received;
    }

    public function set isStar3Received(value:Boolean):void
    {
        _isStar3Received = value;
    }

    public override function set complete(value:Boolean):void
    {
        if(complete)
        {
            _owner.rewardCurrencySoftLevel = 0;
        }

        if (!_isStar1Received)
        {
            _isStar1Received = !_isStar1Received;
        }

        super.complete = value;


    }


    /*
     * Events
     */


    /*
     * Methods
     */
    public function LevelProgress(owner:ILevelInfo)
    {
        super(owner);

        init();
    }

    private function init():void
    {
        _owner = _ownerBase as LevelInfo;
    }


    override public function deserialize(data:Object):void
    {
        _isStar1Received = Debug.assertProperty(data, "is_star_1_received");
        _isStar2Received = Debug.assertProperty(data, "is_star_2_received");
        _isStar3Received = Debug.assertProperty(data, "is_star_3_received");

        super.deserialize(data);
    }
}
}
