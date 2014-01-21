/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.game
{
import mahjong.controllers.EControllerUpdateType;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.game.ViewSceneGame;

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


    override public function update(type:String):void
    {
        switch (type)
        {
            case EControllerUpdateType.ECUT_USER_SELECT_CHIP:
            case EControllerUpdateType.ECUT_CHIPS_REMOVE:
            case EControllerUpdateType.ECUT_USER_DESELECT_CHIP:
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
