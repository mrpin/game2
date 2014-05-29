/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;

import mahjong.controllers.base.ControllerSceneBase;
import mahjong.controllers.lobby.ControllerSceneLobby;
import mahjong.states.EStateType;
import mahjong.view.selectionLevel.ViewContainerLevelsItems;

import mahjong.view.selectionLevel.ViewSceneSelectionLevel;

import views.interfaces.IView;

public class ControllerSceneSelectionLevel extends ControllerSceneLobby
{
    /*
     * Fields
     */
    private var _view:ViewSceneSelectionLevel;

    private var _containerItems:ControllerContainerLevelsItems;


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
                case _view.buttonBack:
                {
                    GameInfo.instance.managerLevels.currentLevelContainer = null;
                    GameInfo.instance.managerStates.setState(EStateType.EST_MAIN);

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
    public function ControllerSceneSelectionLevel()
    {
        _view = new ViewSceneSelectionLevel(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _containerItems = new ControllerContainerLevelsItems();
        _view.viewContainerItems = _containerItems.view;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _containerItems.cleanup();
        _containerItems = null;

        super.cleanup();
    }


}
}
