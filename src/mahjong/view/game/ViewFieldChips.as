/**
 * Created by evgenyyurko on 12.01.14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import views.implementations.ViewBase;

public class ViewFieldChips extends ViewBase
{
    /*
     * Fields
     */
     private var _source:DisplayObjectContainer;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewFieldChips(controller:IController)
    {
        _source = new Sprite();
        super (controller, _source);

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
