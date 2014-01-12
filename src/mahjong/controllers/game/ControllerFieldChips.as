/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import mahjong.view.game.ViewChip;
import mahjong.view.game.ViewFieldChips;

public class ControllerFieldChips extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewFieldChips;

    private var _chips:Array;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerFieldChips()
    {
        _view = new ViewFieldChips(this);
        super (_view);

        init();
    }

    private function init():void
    {
       _chips = [];


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
