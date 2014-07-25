/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.implementations.Controller;
import controllers.implementations.popups.EPopupTypeBase;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.models.game.ManagerGame;
import mahjong.models.level.ELevelMode;
import mahjong.models.level.EStarType;
import mahjong.models.level.LevelInfo;
import mahjong.states.EStateType;
import mahjong.view.selectionLevel.ViewSceneSelectionLevelItem;

import models.interfaces.IManagerGame;
import models.interfaces.levels.ILevelContainer;
import models.interfaces.levels.ILevelInfo;

import views.interfaces.IView;

public class ControllerSceneSelectionLevelItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewSceneSelectionLevelItem;

    private var _entry:LevelInfo;

    /*
     * Properties
     */


    /*
     * Events
     */
    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view:
                {
                    var managerGame:IManagerGame = new ManagerGame(_entry);

                    GameInfo.instance.onGameStart(managerGame);

                    GameInfo.instance.managerStates.setState(EStateType.EST_GAME);

                    result = true;

                    break;
                }
                default:
                {
                    result = true;

                    break;
                }
            }
        }

        return result;
    }

    /*
     * Methods
     */
    public function ControllerSceneSelectionLevelItem(entry:ILevelInfo)
    {
        _entry = entry as LevelInfo;

        _view = new ViewSceneSelectionLevelItem(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _view.labelLevel = _entry.number;
        _view.typeLevelMode = _entry.typeAdvanced;

        var managerLevels:ILevelContainer = GameInfo.instance.managerLevels.currentLevelContainer;

        var isPreviousLevelComplete:Boolean = false;

        for each(var previousLevel:LevelInfo in managerLevels.items)
        {
            if (previousLevel.number == _entry.number - 1 && previousLevel.progressBase.complete)
            {
                isPreviousLevelComplete = true;
                break;
            }
        }

        _view.isOpen = _entry.number == 1 || isPreviousLevelComplete;

        switch (_entry.typeAdvanced)
        {
            case ELevelMode.ELM_ADVANCED:
            {
                if (_entry.progress.complete)
                {
                    _view.setTypeStar(EStarType.EST_VICTORY_MODE_ADVANCED, 0);
                }

                if (_entry.isCompleteNoErrors)
                {
                    _view.setTypeStar(EStarType.EST_FOR_PASSING_ERROR_FREE, 2);
                }

                break;
            }
            case ELevelMode.ELM_CLASSIC:
            {
                if (_entry.progress.complete)
                {
                    _view.setTypeStar(EStarType.EST_VICTORY_MODE_CLASSIC, 0)
                }

                if (_entry.countPlaythroughsLevel > 1)
                {
                    _view.setTypeStar(EStarType.EST_FOR_PASSING_TWICE_MODE_CLASSIC, 2);
                }

                break;
            }
            case ELevelMode.ELM_TIME:
            {
                if (_entry.progress.complete)
                {
                    _view.setTypeStar(EStarType.EST_VICTORY_MODE_TIME, 0);
                }

                if (_entry.isStarForSpeedPassing)
                {
                    _view.setTypeStar(EStarType.EST_FOR_SHORT_TIME_PASSING, 2);
                }

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }

        if (_entry.progress.isStar2Received)
        {
            _view.setTypeStar(EStarType.EST_FOR_PURCHASE, 1);
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view = null;

        super.cleanup();
    }


}
}
