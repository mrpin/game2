/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.models.game.ManagerGame;
import mahjong.models.level.LevelInfo;
import mahjong.states.EStateType;
import mahjong.view.selectionLevel.ViewSceneSelectionLevelItem;

import models.interfaces.IManagerGame;
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
        _view.isVisibleLock = false;
        _view.visibleTypeStar = "";
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        super.cleanup();
    }


}
}
