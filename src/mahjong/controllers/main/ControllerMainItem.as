/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.controllers.main
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.models.game.ManagerGame;
import mahjong.states.EStateType;
import mahjong.view.main.ViewMainItem;

import models.interfaces.IManagerGame;
import models.interfaces.levels.ILevelContainer;

import views.IView;

public class ControllerMainItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewMainItem;

    private var _entry:ILevelContainer;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerMainItem(entry:ILevelContainer)
    {
        _entry = entry;

        _view = new ViewMainItem(this, _entry);
        super(_view);

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {
            var managerGame:IManagerGame = new ManagerGame(_entry.firstIncompleteLevel);

            GameInfo.instance.onGameStart(managerGame);

            GameInfo.instance.managerStates.setState(EStateType.EST_GAME);
        }

        return result;
    }

    override public function onViewMouseOver(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {
            _view.startAnimation();
        }

        return result;
    }

    override public function onViewMouseOut(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {
            _view.stopAnimation();
        }

        return result;
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
