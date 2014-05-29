/**
 * Created by evgenyyurko on 5/26/14.
 */
package mahjong.controllers.game
{
import controllers.EControllerUpdateBase;
import controllers.implementations.Controller;

import core.implementations.Debug;

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
        super.cleanup();
    }


}
}
