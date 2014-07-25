/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.controllers.main
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.models.level.LevelContainer;
import mahjong.states.EStateType;
import mahjong.view.enums.EAnimationType;
import mahjong.view.main.ViewMainItem;

import models.interfaces.levels.ELevelRequirementType;
import models.interfaces.levels.ILevelContainer;

import mx.utils.StringUtil;

import views.interfaces.IView;

public class ControllerMainItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewMainItem;

    private var _entry:LevelContainer;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerMainItem(entry:ILevelContainer)
    {
        _entry = entry as LevelContainer;

        _view = new ViewMainItem(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _view.nameLevelContainer = _entry.name;

        var indexAnimation:int = (_entry.number - 1) % 5;

        _view.isOpen(_entry.requirementIsDone(ELevelRequirementType.ELRT_POINTS),  EAnimationType.animationsForMainItems[indexAnimation], _entry.number);

        var allStars:uint = _entry.items.length * 3;

        _view.textCountStar = StringUtil.substitute("{0}/{1}", _entry.countStarReception, allStars);
    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {
            GameInfo.instance.managerLevels.currentLevelContainer = _entry;
            GameInfo.instance.managerStates.setState(EStateType.EST_SELECT_LEVEL);
        }

        return result;
    }

    override public function onViewMouseOver(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {

        }

        return result;
    }

    override public function onViewMouseOut(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {

        }

        return result;
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
