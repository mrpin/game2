/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import flash.display.DisplayObjectContainer;

import mahjong.view.game.ViewChip;

public class ControllerChip extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewChip;

    private var _type:int;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerChip(valueType:int)
    {
        _view = new ViewChip(this, valueType);
        super(_view);

        _type = valueType

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
