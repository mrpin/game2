/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups
{
import controllers.implementations.ControllerPopup;

import mahjong.view.popup.ViewPopupBonus;

public class ControllerPopupBonus extends ControllerPopup
{
    /*
     * Fields
     */
       private var _view:ViewPopupBonus;

    /*
     * Properties
     */
    override public function get type():String
    {
        return EPopupType.EPT_BONUS;
    }

    /*
     * Methods
     */
    public function ControllerPopupBonus()
    {
        _view = new ViewPopupBonus(this);
        super (_view);

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
