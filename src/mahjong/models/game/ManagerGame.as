/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.game
{
import mahjong.controllers.EControllerUpdateType;
import mahjong.controllers.game.ControllerChip;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.models.data.LevelInfo;

import models.implementations.game.ManagerGameBase;
import models.interfaces.levels.ILevelInfo;

import utils.UtilsArray;

public class ManagerGame extends ManagerGameBase
{
    /*
     * Fields
     */
    private var _currentLevel:LevelInfo;

    //TODO: change controller to ChipInfo
    private var _chipFirstSelected:ControllerChip;
    private var _chipSecondSelected:ControllerChip;

    private var _grid:Array;

    /*
     * Properties
     */
    public function get chipFirstSelected():ControllerChip
    {
        return _chipFirstSelected;
    }

    public function get chipSecondSelected():ControllerChip
    {
        return _chipSecondSelected;
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
        _grid = getMainGrid(grid);
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
            var noEnable:Boolean = false;

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
                            noEnable = true;
                        }
                    }
                }
            }
            if (noEnable)
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

        } while (noEnable);


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

    //проверка совпадения фишек
    public function verificationCoincidenceChips(controller:ControllerChip):void
    {
        if (_chipFirstSelected != controller)
        {
            if (_chipFirstSelected == null)
            {
                _chipFirstSelected = controller;

                GameInfoBase.instance.managerStates.currentState.update(EControllerUpdateType.ECUT_USER_SELECT_CHIP);
            }
            else
            {
                if (_chipFirstSelected.typeChip == controller.typeChip)
                {
                    _chipSecondSelected = controller;

                    GameInfoBase.instance.managerStates.currentState.update(EControllerUpdateType.ECUT_CHIPS_REMOVE);

                    _grid[_chipFirstSelected.entry.z][_chipFirstSelected.entry.y][_chipFirstSelected.entry.x] = ChipInfo.getChipEmpty(_grid);
                    _grid[_chipSecondSelected.entry.z][_chipSecondSelected.entry.y][_chipSecondSelected.entry.x] = ChipInfo.getChipEmpty(_grid);

                    _chipFirstSelected = null;
                    _chipSecondSelected = null;

                }
                else
                {
                    GameInfoBase.instance.managerStates.currentState.update(EControllerUpdateType.ECUT_USER_DESELECT_CHIP);

                    _chipFirstSelected = controller;

                    GameInfoBase.instance.managerStates.currentState.update(EControllerUpdateType.ECUT_USER_SELECT_CHIP);

                }
            }
        }
        else
        {
            GameInfoBase.instance.managerStates.currentState.update(EControllerUpdateType.ECUT_USER_DESELECT_CHIP);
            _chipFirstSelected = null;
        }

    }

    public function shuffleChips():void
    {

    }

}
}