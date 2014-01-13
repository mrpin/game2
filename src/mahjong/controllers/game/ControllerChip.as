/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import mahjong.models.data.ChipInfo;
import mahjong.view.game.ViewChip;

public class ControllerChip extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewChip;

    private var _entry:ChipInfo;


    /*
     * Properties
     */


    public function get entry():ChipInfo
    {
        return _entry;
    }

    /*
     * Methods
     */
    public function ControllerChip(entry:ChipInfo)
    {
        _view = new ViewChip(this, entry["type"]);
        super(_view);

        _entry = entry;

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
