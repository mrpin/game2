/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.states.main
{
import mahjong.controllers.main.ControllerSceneMain;
import mahjong.controllers.popups.bonus.ControllerPopupBonus;
import mahjong.states.EStateType;
import mahjong.states.base.StateMahjongBase;

public class StateMain extends StateMahjongBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    public override function get type():String
    {
        return EStateType.EST_MAIN;
    }

    /*
     * Methods
     */
    public function StateMain()
    {


        init();
    }

    private function init():void
    {

    }

    public override function prepareLayerScene():void
    {
        super.prepareLayerScene();

        this.controllerScene = new ControllerSceneMain();
    }

    override public function prepareLayerPopups():void
    {
        super.prepareLayerPopups();

        {//register popups
//            registerPopup(new ControllerPopupBonus());
        }
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
