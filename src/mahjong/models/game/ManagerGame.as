/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.game
{
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.models.data.LevelInfo;

import models.implementations.game.ManagerGameBase;
import models.interfaces.levels.ILevelInfo;

public class ManagerGame extends ManagerGameBase
{
    /*
     * Fields
     */
    private var _currentLevel:LevelInfo;

    private var _chipSelected:ChipInfo;

    private var _grid:Array;

    /*
     * Properties
     */
    public function get currentLevel():LevelInfo
    {
        return _currentLevel;
    }


    public function get grid():Array
    {
        return _grid;
    }
    /*
     * Methods
     */
    public function ManagerGame(levelInfo:ILevelInfo)
    {
        super(levelInfo);

        init();
    }

    private function init():void
    {
        //init grid
        initGrid();
    }

    private function initGrid():void
    {
        //этот grid с фишками и
        var grid:Array = [];

        for each(var layerZ:Array in _currentLevel.grid)
        {
            for each(var layerY:Array in layerZ)
            {
                var layerY:Array = [];
                for each(var chip:ChipInfo in layerY)
                {
                    if (chip.chipType == EChipType.ETB_EMPTY)
                    {
                        //TODO: push to layer empty
                    }
                    else
                    {
                        var newChip:ChipInfo = new ChipInfo();
                        newChip.deserialize(chip.serialize());
                        //TODO: push new chip
                    }
                }
            }
        }

        //fill grid with specify chip types
        _grid = [];

        var enabledChips:Array = [];

        do
        {
            for each(var layerZ:Array in grid)
            {
                for each(var chip:ChipInfo in layerY)
                {
                    if (chip != ChipInfo.CHIP_EMPTY && chip.isEnabled)
                    {
                        enabledChips.push(chip);
                    }

                }
            }

            for each(var enabledChip:ChipInfo in enabledChips)
            {
                //set type
                //remove from grid and push to _grid
            }

        } while (enabledChips.length > 0);
    }

}
}