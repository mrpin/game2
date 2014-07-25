/**
 * Created by evgenyyurko on 6/26/14.
 */
package mahjong.models.views
{
import models.implementations.views.ManagerViewsBase;
import models.interfaces.views.EViewTypeBase;

public class ManagerViews extends ManagerViewsBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ManagerViews()
    {
        init();
    }

    private function init():void
    {
        //popups
        setClassView(EViewTypeBase.EVT_NO_ENERGY_1, gPopupNoEnergy);
        setClassView(EViewTypeBase.EVT_LOSE_0, gPopupLose);
        setClassView(EViewTypeBase.EVT_OUT_OF_TIME_0, gPopupOutOfTime);
        setClassView(EViewTypeBase.EVT_WIN_0, gPopupWin);
        setClassView(EViewTypeBase.EVT_BANK_1, gPopupBank);
        setClassView(EViewTypeBase.EVT_BANK_ITEM_0, gPopupBankItem);

        //view friends
        setClassView(EViewTypeBase.EVT_FRIENDS_0, gViewFriends);
        setClassView(EViewTypeBase.EVT_FRIENDS_ITEM_0, gViewFriendItem);
        setClassView(EViewTypeBase.EVT_FRIENDS_ITEM_INVITE_0, gViewFriendItemInvite);
    }

}
}
