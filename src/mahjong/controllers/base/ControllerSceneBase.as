/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.base
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;

import mahjong.view.base.ViewSceneBase;

import views.IView;

public class ControllerSceneBase extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewSceneBase;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerSceneBase(view:ViewSceneBase)
    {
        _view = view;

        super(_view);

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view.buttonTOP:
                {
                    result = true;

                    break;
                }
                case _view.buttonSettings:
                {
//                    GameInfo.instance.managerApp.fullScreenEnable = !GameInfo.instance.managerApp.fullScreenEnable;
                    GameInfo.instance.managerGame.shuffleChips();

                    result = true;

                    break;
                }
                case _view.buttonSound:
                {
                    GameInfo.instance.managerGame.onShowChipsDisable = true;

                    result = true;

                    break;
                }
                case _view.buttonFullScreen:
                {

                    break;
                }
                case _view.buttonHelp:
                {
                    result = true;

                    break;
                }
                default:
                {
                    Debug.assert(false);

                    break;
                }
            }
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
