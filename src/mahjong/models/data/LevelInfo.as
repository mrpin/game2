/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.data
{
import flash.text.GridFitType;

import models.implementations.levels.LevelInfoBase;

public class LevelInfo extends LevelInfoBase
{
    /*
     * Fields
     */
    private var _grid:Array;

    /*
     * Properties
     */


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
        var grid:GridInfo = new GridInfo;
        grid.deserialize(data);

        super.deserialize(data);
    }
}
}
