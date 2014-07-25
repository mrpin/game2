/**
 * Created by evgenyyurko on 5/26/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;
import controllers.interfaces.EControllerUpdateBase;

import core.implementations.Debug;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.view.game.ViewMeasurePoints;

public class ControllerMeasurePoints extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewMeasurePoints;

    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerMeasurePoints()
    {
        _view = new ViewMeasurePoints(this);
        super(_view);

        init();
    }

    private function init():void
    {

    }


    override public function update(type:String):void
    {
        switch (type)
        {
            case EControllerUpdateBase.ECU_PLAYER_POINTS:
            {

                break;
            }
            case EControllerUpdate.ECUT_DESTROYED_COUPLE_CHIPS:
            {
                _view.visibleProgress(GameInfo.instance.managerGame.completedPercentageLevel);

                break;
            }
            case EControllerUpdate.ECU_UPDATE_TIME:
            {
                _view.moveTimer();

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
        _view = null;

        super.cleanup();
    }


}
}
