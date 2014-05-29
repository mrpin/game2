/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.controllers.lobby
{
import flash.events.MouseEvent;

import mahjong.GameInfo;

import mahjong.controllers.base.ControllerSceneBase;
import mahjong.controllers.lobby.progress.ControllerProgress;
import mahjong.controllers.lobby.timeBonus.ControllerTimeBonus;
import mahjong.states.EStateType;
import mahjong.view.lobby.ViewSceneLobby;
import mahjong.view.selectionLevel.ViewSceneSelectionLevel;

import views.interfaces.IView;

public class ControllerSceneLobby extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneLobby;

    private var _controllerProgress:ControllerProgress;

    private var _controllerTimeBonus:ControllerTimeBonus;

    /*
     * Properties
     */


    /*
     * Events
     */


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

//        if (!result)
//        {
//            switch (view)
//            {
//                case _view.buttonBack:
//                {
//                    GameInfo.instance.managerStates.setState(EStateType.EST_MAIN);
//
//                    result = true;
//
//                    break;
//                }
//                default:
//                {
//                    result = true;
//
//                    break;
//                }
//            }
//        }

        return result;
    }

    /*
     * Methods
     */
    public function ControllerSceneLobby(view:ViewSceneLobby)
    {
        _view = view;
        super(_view);

        init();
    }

    private function init():void
    {
        _controllerProgress = new ControllerProgress();
        _view.progress = _controllerProgress.view;

        _controllerTimeBonus = new ControllerTimeBonus();
        _view.timeBonusView = _controllerTimeBonus.view;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _controllerProgress.cleanup();
        _controllerProgress = null;

        _controllerTimeBonus.cleanup();
        _controllerTimeBonus = null;

        super.cleanup();
    }


}
}
