/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.controllers.popups.bonus
{
import mahjong.controllers.popups.*;

import controllers.implementations.ControllerPopup;

import flash.events.MouseEvent;

import mahjong.view.popup.ViewPopupBonus;

import views.IView;

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
        super(_view);

        init();
    }

    private function init():void
    {

    }

    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        switch (view)
        {
            case _view.buttonClose:
            {
                result = true;

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }

        return result;
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
