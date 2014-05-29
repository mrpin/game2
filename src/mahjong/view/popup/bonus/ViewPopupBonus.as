/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.bonus
{
import controllers.IControllerPopup;

import mahjong.GameInfo;
import mahjong.models.string.EStringType;

import models.interfaces.string.IManagerString;

import views.implementations.ViewPopup;
import views.implementations.buttons.ViewButtonLabeled;
import views.interfaces.buttons.IViewButtonLabeled;

public class ViewPopupBonus extends ViewPopup
{
    /*
     * Fields
     */
    private var _source:gPopupBonus;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewPopupBonus(controller:IControllerPopup)
    {
        _source = new gPopupBonus();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var managerString:IManagerString = GameInfo.instance.managerString;

        var buttonClose:IViewButtonLabeled = new ViewButtonLabeled(controller, _source.buttonClose);
        buttonClose.text = (managerString.localizedString(EStringType.EST_POPUP_BONUS_BUTTON_CLOSE));
        setButtonClose(buttonClose);

        _source.labelTitle.text = (managerString.localizedString(EStringType.EST_POPUP_BONUS_WIDGET_TITLE));
        _source.labelBonus.text = (managerString.localizedString(EStringType.EST_POPUP_BONUS_LABEL_BONUS));
        _source.labelText.text = (managerString.localizedString(EStringType.EST_POPUP_BONUS_TEXT));
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
