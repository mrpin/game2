/**
 * Created by evgenyyurko on 6/18/14.
 */
package mahjong.view.base
{
import controllers.IController;

import flash.display.DisplayObjectContainer;

import views.implementations.ViewBase;

public class ViewParallax extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewParallax(controller:IController)
    {
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
        _source = null;

        super.cleanup();
    }


}
}
