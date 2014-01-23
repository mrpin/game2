/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.game
{
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.models.data.LevelInfo;

import models.implementations.game.ManagerGameBase;
import models.interfaces.levels.ILevelInfo;

import utils.UtilsArray;

public class ManagerGame extends ManagerGameBase
{
    /*
     * Static
     */


    private static function getMainGrid(grid:Array):Array
    {
        var result:Array = getChipsEmpty(grid);

        var enabledChips:Array = [];

        do
        {
            var hasEnabledChips:Boolean = false;

            for (var z:int = 0; z < grid.length; z++)
            {
                for (var y:int = 0; y < grid[z].length; y++)
                {
                    for (var x:int = 0; x < grid[z][y].length; x++)
                    {
                        var enabledChip:ChipInfo = grid[z][y][x];

                        if (enabledChip.chipType != EChipType.ETB_EMPTY && enabledChip.isEnabled)
                        {
                            enabledChips.push(enabledChip);
                            hasEnabledChips = true;
                        }
                    }
                }
            }

            if (hasEnabledChips)
            {
                for each(var chipEmpty:ChipInfo in enabledChips)
                {
                    grid[chipEmpty.z][chipEmpty.y][chipEmpty.x] = ChipInfo.getCloneWithType(chipEmpty, EChipType.ETB_EMPTY);
                }

                UtilsArray.shuffle(enabledChips);
                UtilsArray.shuffle(enabledChips);


                var enabledChipsCount:uint = enabledChips.length;

                for (var k:uint = 0; k < enabledChipsCount; k += 2)
                {
                    if (enabledChips.length > 1)
                    {
                        var randomCurrentType:uint = EChipType.getRandomType();

                        var chipSecondaryEnabled:ChipInfo = enabledChips[1];
                        UtilsArray.removeValue(enabledChips, chipSecondaryEnabled);

                        var chipFirstEnabled:ChipInfo = enabledChips[0];
                        UtilsArray.removeValue(enabledChips, chipFirstEnabled);


                        var newChipFirst:ChipInfo = ChipInfo.getCloneWithType(chipFirstEnabled, randomCurrentType);
                        newChipFirst.gridOwner = result;
                        result[chipFirstEnabled.z][chipFirstEnabled.y][chipFirstEnabled.x] = newChipFirst;

                        var newChipSecondary:ChipInfo = ChipInfo.getCloneWithType(chipSecondaryEnabled, randomCurrentType);
                        newChipSecondary.gridOwner = result;
                        result[chipSecondaryEnabled.z][chipSecondaryEnabled.y][chipSecondaryEnabled.x] = newChipSecondary;
                    }
                }
            }

        } while (hasEnabledChips);


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




    /*
     * Fields
     */
    private var _currentLevel:LevelInfo;

    private var _chipSelected:ChipInfo;

    private var _grid:Array;

    //TODO: implement
    // contains only enabled chips
    private var _chipsEnabled:Array;

    //TODO: implement
    // contains all chips except empty
    private var _chipsAll:Array;
    /*
     * Properties
     */

    public function get grid():Array
    {
        return _grid;
    }

    public function get chipsEnabled():Array
    {
        return _chipsEnabled;
    }

    public function get isHasCombination():Boolean
    {
        var result:Boolean = false;

        for each(var currentChip:ChipInfo in _chipsEnabled)
        {
            for each(var pairChip:ChipInfo in _chipsEnabled)
            {
                if (currentChip == pairChip)
                {
                    continue;
                }

                if (currentChip.chipType == pairChip.chipType)
                {
                    result = true;
                    break;
                }
            }

            if (result)
            {
                break;
            }
        }

        return result;
    }


    public function set chipSelected(value:ChipInfo):void
    {
        if (value == _chipSelected)
            return;

        if (_chipSelected != null)
        {
            _chipSelected.controller.update(EControllerUpdate.ECUT_USER_DESELECT_CHIP);
        }

        _chipSelected = value;

        if (_chipSelected != null)
        {
            _chipSelected.controller.update(EControllerUpdate.ECUT_USER_SELECT_CHIP);
        }
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
        var grid:Array = getGrid();
        _grid = getMainGrid(grid);

        _chipsAll = getChips([EChipType.ETB_EMPTY]);
        updateEnabledChips();
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


    //проверка совпадения фишек
    public function verificationCoincidenceChips(chip:ChipInfo):void
    {
        if (_chipSelected == chip)
        {
            this.chipSelected = null;
        }
        else
        {
            if (_chipSelected == null)
            {
                this.chipSelected = chip;
            }
            else
            {
                if (_chipSelected.chipType == chip.chipType)
                {
                    onUserSelectSameChip(chip);
                }
                else
                {
                    this.chipSelected = chip;
                }
            }
        }
    }

    private function onUserSelectSameChip(chip:ChipInfo):void
    {
        _chipSelected.controller.update(EControllerUpdate.ECUT_CHIPS_REMOVE);
        _grid[_chipSelected.z][_chipSelected.y][_chipSelected.x] = ChipInfo.getChipEmpty(_grid);

        UtilsArray.removeValue(_chipsAll, _chipSelected);

        chip.controller.update(EControllerUpdate.ECUT_CHIPS_REMOVE);
        _grid[chip.z][chip.y][chip.x] = ChipInfo.getChipEmpty(_grid);

        UtilsArray.removeValue(_chipsAll, chip);

        this.chipSelected = null;

        updateEnabledChips();
    }

    private function getChips(typesIgnore:Array):Array
    {
        var result:Array = [];

        for (var z:int = _grid.length - 1; z >= 0; z--)
        {
            for (var y:int = 0; y < _grid[z].length; y++)
            {
                for (var x:int = 0; x < _grid[z][y].length; x++)
                {
                    var chip:ChipInfo = _grid[z][y][x];

                    if (typesIgnore.indexOf(chip.chipType) == ConstantsBase.INDEX_NONE)
                    {
                        result.push(chip);
                    }
                }
            }
        }

        return result;
    }

    private function updateEnabledChips():void
    {
        _chipsEnabled = [];

        for each(var chip:ChipInfo in _chipsAll)
        {
            if (chip.isEnabled)
            {
                _chipsEnabled.push(chip)
            }
        }
    }


    public function shuffleChips():void
    {
        var chipsForShuffle:Array = [];
        var chipsTypeForShuffle:Array = [];

        for each(var gridZ:Array in _grid)
        {
            for each(var gridY:Array in gridZ)
            {
                for each(var chip:ChipInfo in gridY)
                {
                    if (chip.chipType != EChipType.ETB_EMPTY)
                    {
                        chipsForShuffle.push(chip);
                        chipsTypeForShuffle.push(chip.chipType);
                    }

                }
            }
        }

        UtilsArray.shuffle(chipsTypeForShuffle);

        for (var i:int = 0; i < chipsForShuffle.length; i++)
        {
            var chipShuffle:ChipInfo = chipsForShuffle[i];

            var chipCurrent:ChipInfo = ChipInfo.getCloneWithType(chipShuffle, chipsTypeForShuffle[i]);
            chipCurrent.gridOwner = _grid;

            _grid[chipShuffle.z][chipShuffle.y][chipShuffle.x] = chipCurrent;
        }

        _stateGame.update(EControllerUpdate.ECUT_CHIPS_SHUFFLE);
    }

}
}