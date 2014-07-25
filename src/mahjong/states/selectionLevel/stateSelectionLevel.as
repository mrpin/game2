/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.states.selectionLevel
{
import core.implementations.Debug;

import mahjong.GameInfo;
import mahjong.controllers.selectionLevel.ControllerSceneSelectionLevel;
import mahjong.states.EStateType;
import mahjong.states.base.StateMahjongBase;

public class StateSelectionLevel extends StateMahjongBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    public override function get type():String
    {
        return EStateType.EST_SELECT_LEVEL;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function StateSelectionLevel()
    {
        Debug.assertNotEqual(GameInfo.instance.managerLevels.currentLevelContainer, null);

        init();
    }

    private function init():void
    {

    }

    public override function prepareLayerScene():void
    {
        super.prepareLayerScene();

        this.controllerScene = new ControllerSceneSelectionLevel();
    }

    override public function prepareLayerPopups():void
    {
        super.prepareLayerPopups();

        {//register popups

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
