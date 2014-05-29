/**
 * Created by evgenyyurko on 03.02.14.
 */
package mahjong.view.popup.top
{
import controllers.IController;

import mahjong.GameInfo;
import mahjong.models.string.EStringType;

import models.interfaces.string.IManagerString;

import views.implementations.ViewBase;

public class ViewPopupTopItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gPopupTopItem;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewPopupTopItem(controller:IController)
    {
        _source = new gPopupTopItem();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var managerString:IManagerString = GameInfo.instance.managerString;

        _source.labelUp.text = (managerString.localizedString(EStringType.EST_POPUP_TOP_UP_LABEL_FRIEND));
        _source.labelName.text = (managerString.localizedString(EStringType.EST_POPUP_TOP_BOTTOM_LABEL_FRIEND));
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
