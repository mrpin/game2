/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.game
{
import flash.events.TimerEvent;
import flash.utils.Timer;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.models.level.ELevelMode;
import mahjong.models.level.LevelInfo;
import mahjong.states.EStateType;

import models.implementations.game.ManagerGameBase;
import models.interfaces.levels.ILevelInfo;

import utils.Utils;
import utils.UtilsArray;
import utils.memory.UtilsMemory;

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

    // contains only enabled chips
    private var _chipsEnabled:Array;

    // contains all chips except empty
    private var _chipsAll:Array;

    private var _onShowChipsDisable:Boolean;

    private var _chipsCancellationTravel:Array;

    private var _isErrorInMove:Boolean;

    private var _countChips:uint;
    private var _completedPercentageLevel:Number;

    private var _isAutoHint:Boolean;
    private var _isMadePurchase:Boolean;


    private var _timer:Timer;
    private var _timeLeft:Number;

    private var _timerForAutoHint:Timer;

    /*
     * Properties
     */
    public function get timeLeft():Number
    {
        return _timeLeft;
    }

    public function get completedPercentageLevel():Number
    {
        return _completedPercentageLevel;
    }

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

    public function get currentLevel():LevelInfo
    {
        return _currentLevel;
    }

    public function set isMadePurchase(value:Boolean):void
    {
        _isMadePurchase = value;
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
        _onShowChipsDisable = false;

        //init grid
        var grid:Array = getGrid();
        _grid = getMainGrid(grid);

        _chipsAll = getChips([EChipType.ETB_EMPTY]);
        updateEnabledChips();

        _chipsCancellationTravel = [];
        _isErrorInMove = false;
        _countChips = _chipsAll.length;
        _completedPercentageLevel = 0;
        _isAutoHint = false;
        _isMadePurchase = false;
    }


    override public function onGameStart():void
    {
        super.onGameStart();

        _timeLeft = 0;

        if (_currentLevel.typeAdvanced == ELevelMode.ELM_TIME)
        {
            _timer = new Timer(ConstantsBase.ANIMATION_DURATION * 4 * 1000);
            UtilsMemory.registerEventListener(_timer, TimerEvent.TIMER, this, onTimerComplete);
            _timer.start();
        }
    }

    private function onTimerComplete(e:TimerEvent):void
    {
        _timeLeft++;
        trace(_timeLeft);

        _stateGame.update(EControllerUpdate.ECU_UPDATE_TIME);

        if (_timeLeft == _currentLevel.timeLeft)
        {
            tryCleanupTimer();

            GameInfo.instance.onGameEnd();
            //TODO: вызов попапа время закончилось
            GameInfo.instance.managerStates.setState(EStateType.EST_SELECT_LEVEL)
        }
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
    public function checkCoincidenceChips(chip:ChipInfo):void
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
                    _chipsCancellationTravel = [];

                    _chipsCancellationTravel.push(_chipSelected);
                    _chipsCancellationTravel.push(chip);

                    removeCoupleIdenticalChips(chip);

                    _onShowChipsDisable ? showChipsDisable() : null;

                    var countCompleteChips:uint = _countChips - _chipsAll.length;

                    _completedPercentageLevel = countCompleteChips / _countChips * 100;

                    _stateGame.update(EControllerUpdate.ECUT_DESTROYED_COUPLE_CHIPS);

                    if (_isAutoHint)
                    {
                        autoHint();
                    }

                    if (_currentLevel.typeAdvanced == ELevelMode.ELM_CLASSIC)
                    {
                        showChipsDisable();
                    }

                    if (_chipsAll.length == 0)
                    {
                        isCurrentGameComplete();
                    }
                }
                else
                {
                    this.chipSelected = chip;

                    if (!_currentLevel.isCompleteNoErrors)
                    {
                        _isErrorInMove = true;
                    }
                }
            }
        }

    }

    public function cancelLastMove():void
    {
        if (_chipsCancellationTravel.length == 0)
        {
            return;
        }

        for each(var chip:ChipInfo in _chipsCancellationTravel)
        {
            _grid[chip.z][chip.y][chip.x] = chip;
            _chipsAll.push(chip);
            chip.controller.update(EControllerUpdate.ECUT_CHIPS_CANCEL_MOVE);
        }

        showChipsDisable();

        var countCompleteChips:uint = _countChips - _chipsAll.length;
        _completedPercentageLevel = countCompleteChips / _countChips * 100;

        _stateGame.update(EControllerUpdate.ECUT_DESTROYED_COUPLE_CHIPS);

        _chipsCancellationTravel = [];
    }

    private function removeCoupleIdenticalChips(chip:ChipInfo):void
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


    public function shuffle():void
    {
        _chipsCancellationTravel = [];

        var arrayTypes:Array = [];

        for each(var chip:ChipInfo in _chipsAll)
        {
            arrayTypes.push(chip.chipType);
        }

        UtilsArray.shuffle(arrayTypes);

        for (var i:int = 0; i < _chipsAll.length; i++)
        {
            var chipInfo:ChipInfo = _chipsAll[i];
            chipInfo.chipType = arrayTypes[i];
        }
        _stateGame.update(EControllerUpdate.ECUT_CHIPS_SHUFFLE);
    }


    public function showCombination():void
    {
        for each (var chip:ChipInfo in getTwoSameChips())
        {
            chip.controller.update(EControllerUpdate.ECUT_CHIP_SHOW_COMBINATION);
        }
    }

    private function getTwoSameChips():Array
    {
        var result:Array = [];

        var chipsEnable:Array = [];

        for each (var chip:ChipInfo in _chipsAll)
        {
            if (chip.isEnabled)
            {
                chipsEnable.push(chip);
            }
        }


        for each(var chipOne:ChipInfo in chipsEnable)
        {
            for each(var chipTwo:ChipInfo in chipsEnable)
            {
                if (chipOne.chipType == chipTwo.chipType && chipOne != chipTwo)
                {
                    result.push(chipOne);
                    result.push(chipTwo);

                    break;
                }
            }
            if (chipOne.chipType == chipTwo.chipType && chipOne != chipTwo)
            {
                break;
            }
        }

        return result;
    }

    public function showChipsDisable():void
    {
        for each (var chip:ChipInfo in _chipsAll)
        {
            if (!chip.isEnabled)
            {
                chip.controller.update(EControllerUpdate.ECUT_SHOW_CHIPS_DISABLE);
            }
            else
            {
                chip.controller.update(EControllerUpdate.ECUT_HIDE_CHIPS_DISABLE);
            }
        }
    }

    public function autoHint():void
    {
        _isAutoHint = true;

        tryCleanupTimerForAutoHint();

        _timerForAutoHint = new Timer(ConstantsBase.ANIMATION_DURATION * 4 * 1000 * 5, 1);
        UtilsMemory.registerEventListener(_timerForAutoHint, TimerEvent.TIMER, this, onTimerComplete);
        _timerForAutoHint.start();

        function onTimerComplete(e:TimerEvent):void
        {
            for each (var chip:ChipInfo in getTwoSameChips())
            {
                chip.controller.update(EControllerUpdate.ECUT_CHIP_AUTO_HINT);
            }
        }


    }


    private function isCurrentGameComplete():void
    {
        tryCleanupTimer();

        _currentLevel.progressBase.complete = true;
        _currentLevel.countPlaythroughsLevel++;
        _currentLevel.isCompleteNoErrors = !_isErrorInMove;
        _currentLevel.timePassing = _timeLeft;
        if (_isMadePurchase)
        {
            _currentLevel.isMadePurchase(true);
        }

        Utils.performAfterDelay(ConstantsBase.ANIMATION_DURATION * 4 * 1000 * 3, function setState():void
        {
            onGameEnd();
            GameInfo.instance.onGameEnd();

            //TODO: вызов попапа победа
            GameInfo.instance.managerStates.setState(EStateType.EST_SELECT_LEVEL)
        });
    }


    private function tryCleanupTimer():void
    {
        if (_timer != null)
        {
            _timer.stop();
            UtilsMemory.unregisterEventListener(_timer, TimerEvent.TIMER, this, onTimerComplete, false);
            _timer = null;
        }

    }

    private function tryCleanupTimerForAutoHint():void
    {
        if (_timerForAutoHint != null)
        {
            _timerForAutoHint.stop();
            UtilsMemory.unregisterEventListener(_timer, TimerEvent.TIMER, this, onTimerComplete, false);
            _timerForAutoHint = null;
        }

    }

    override public function cleanup():void
    {
        tryCleanupTimer();

        tryCleanupTimerForAutoHint();

        super.cleanup();
    }
}
}