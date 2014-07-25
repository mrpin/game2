/**
 * Created by evgenyyurko on 7/21/14.
 */
package mahjong.view.popup.popups.controller
{
import controllers.implementations.popups.outOfTime.ControllerOutOfTimeBase;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.models.prchaces.EPurchaseType;
import mahjong.view.popup.popups.view.ViewPopupOutOfTime;

import models.interfaces.purchases.IManagerPurchases;
import models.interfaces.purchases.IPurchaseItem;

import views.interfaces.IView;

public class ControllerPopupOutOfTime extends ControllerOutOfTimeBase
{
    /*
     * Fields
     */
    private var _managerPurchases:IManagerPurchases;

    /*
     * Properties
     */
    override protected function get classView():Class
    {
        return ViewPopupOutOfTime;
    }

    /*
     * Events
     */
    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        var viewOther:ViewPopupOutOfTime = this.view as ViewPopupOutOfTime;

        if (!result)
        {
            switch (view)
            {
                case viewOther.buttonPassLevel:
                {
                    var boosterDoneLevel:IPurchaseItem = _managerPurchases.getPurchaseFirst(EPurchaseType.EPT_DONE_LEVEL);

                    GameInfo.instance.managerStates.currentState.hidePopup();

                    _managerPurchases.tryPurchase(boosterDoneLevel,
                            function (item:IPurchaseItem):void
                            {
                                GameInfo.instance.managerGame.isMadePurchase = true;
                                GameInfo.instance.managerGame.levelPass();
                            });

                    break;
                }
                default :
                {
                    Debug.assert(false);

                    break;
                }
            }
        }

        return result;
    }

    /*
     * Methods
     */
    public function ControllerPopupOutOfTime()
    {


        init();
    }

    private function init():void
    {
        _managerPurchases = GameInfo.instance.managerPurchases;
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
