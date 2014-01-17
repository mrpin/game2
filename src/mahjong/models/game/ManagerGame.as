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

import utils.Utils;
import utils.UtilsArray;

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

        _currentLevel = levelInfo as LevelInfo;

        init();
    }

    private function init():void
    {



        //init grid
        initGrid();
    }

    private function initGrid():void
    {
        var grid:Array = getGrid();
        var gridMain:Array = getMainGrid(grid);
    }

    private function getGrid():Array
    {
        //этот grid с фишками и
        var result:Array = [];

        for each(var gridCarcassZ:Array in _currentLevel.gridCarcass)
        {
            var layerY:Array = [];

            for each(var gridCarcassY:Array in gridCarcassZ)
            {
                var layerX:Array = [];

                for each(var chip:ChipInfo in gridCarcassY)
                {
                    var newChip:ChipInfo = ChipInfo.getCloneWithType(chip, chip.chipType);

                    layerX.push(newChip);
                }
                layerY.push(layerX);
            }
            result.push(layerY);
        }

        for each(var axisZ:Array in result)
        {
            for each(var axisY:Array in axisZ)
            {
                for each(var currentChip:ChipInfo in axisY)
                {
                    currentChip.gridOwner = result;
                }
            }
        }
        return result;
    }

    private static function getMainGrid(grid:Array):Array
    {
        var result:Array = getChipsEmpty(grid);

        var enabledChips:Array = [];

        do
        {
            for (var z:int = 0; z < grid.length; z++)
            {
                for (var y:int = 0; y < grid[z].length; y++)
                {
                    for (var x:int = 0; x < grid[z][y].length; x++)
                    {
                        var enabledChip:ChipInfo = grid[z][y][x];

                        if (enabledChip.chipType != EChipType.ETB_EMPTY && enabledChip.isEnabled)
                        {
//                            ChipInfo.getCloneWithType(enabledChip, EChipType.ETB_EMPTY);
                            enabledChips.push(enabledChip);

                        }
                    }
                }
            }

            for each(var chipEmpty:ChipInfo in enabledChips)
            {
                chipEmpty = ChipInfo.getCloneWithType(enabledChip, EChipType.ETB_EMPTY);
            }

            UtilsArray.shuffle(enabledChips);


            var currentChipType:uint = EChipType.getRandomType();

            for (var index:uint = 0; index < enabledChips.length; index++)
            {
                var chipEnabled:ChipInfo = enabledChips[index];

                UtilsArray.removeValue(enabledChips, chipEnabled);

                if ((index % 2) == 0)
                {
                    currentChipType = EChipType.getRandomType();
                }

                var newChip:ChipInfo = ChipInfo.getCloneWithType(chipEnabled, currentChipType);

                newChip.gridOwner = result;

                result[chipEnabled.z][chipEnabled.y][chipEnabled.x] = newChip;
            }



        } while (enabledChips.length > 0);


        return result;
    }

    private static function getChipsEmpty(grid:Array):Array
    {
        var result:Array = [];

        for each(var gridZ:Array in grid)
        {
            var chipsEmptyZ:Array = [];

            for each(var gridY:Array in gridZ)
            {
                var chipsEmptyY:Array = [];

                for each(var chip:ChipInfo in gridY)
                {
                    var chipEmpty:ChipInfo = ChipInfo.getCloneWithType(chip, EChipType.ETB_EMPTY);

                    chipsEmptyY.push(chipEmpty);
                }
                chipsEmptyZ.push(chipsEmptyY);
            }
            result.push(chipsEmptyZ);
        }

        return result;
    }

}
}