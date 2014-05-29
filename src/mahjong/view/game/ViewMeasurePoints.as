/**
 * Created by evgenyyurko on 5/26/14.
 */
package mahjong.view.game
{
import controllers.IController;

import views.implementations.ViewBase;

public class ViewMeasurePoints extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gMeasurePoints;

    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewMeasurePoints(controller:IController)
    {
        _source = new gMeasurePoints();
        super(controller, _source);

        init();
    }

    private function init():void
    {

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
