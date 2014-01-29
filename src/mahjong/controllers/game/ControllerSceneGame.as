/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.game
{
import flash.events.MouseEvent;

import mahjong.controllers.EControllerUpdate;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.game.ViewSceneGame;

import views.IView;

public class ControllerSceneGame extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneGame;

    private var _controllerFieldChips:ControllerFieldChips;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerSceneGame()
    {
        _view = new ViewSceneGame(this);

        super(_view);

        init();
    }

    private function init():void
    {
        _controllerFieldChips = new ControllerFieldChips();
        _view.viewFieldChips = _controllerFieldChips.view;
    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view.button0:
                {
                    result = true;

                    break;
                }
                case _view.button1:
                {
                    result = true;

                    break;
                }
                case _view.button2:
                {
                    result = true;

                    break;
                }
                case _view.button3:
                {

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

    override public function update(type:String):void
    {
        switch (type)
        {
            //TODO: saves for purchase "show disabled"
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            case EControllerUpdate.ECUT_CHIPS_SHUFFLE:
            {
                _controllerFieldChips.update(type);

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view.cleanup();
        _view = null;

        _controllerFieldChips.cleanup();
        _controllerFieldChips = null;

        super.cleanup();
    }


}
}
