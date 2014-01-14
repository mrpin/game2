/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.data
{
import models.implementations.levels.LevelInfoBase;

public class LevelInfo extends LevelInfoBase
{
    /*
     * Fields
     */
    private var _grid:GridInfo;

    /*
     * Properties
     */
    public function get grid():GridInfo
    {
        return _grid;
    }

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
        Debug.assert(data.hasOwnProperty("grid_data"));

        _grid = new GridInfo;
        grid.deserialize(data["grid_data"]);

        super.deserialize(data);
    }
}
}
