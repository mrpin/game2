/**
 * Created by kapitonik on 5/11/14.
 */
package mahjong.controllers.lobby.progress
{
import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.view.lobby.progress.ViewAvatarItem;

import models.interfaces.players.IPlayerInfo;

import views.interfaces.IView;

public class ControllerAvatarItem extends Controller
{
    /*
     * Fields
     */

    private var _view:ViewAvatarItem;


    /*
     * Properties
     */


    /*
     * Events
     */

    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        if (!result)
        {
            switch (view)
            {
                case _view.buttonAddFriend:
                {
                    Debug.log("Button add friend clicked");
                    GameInfo.instance.managerSocial.inviteFriends();

                    break;
                }
                default :
                {
                    break;
                }
            }
        }

        return result;
    }

    /*
     * Methods
     */

    public function ControllerAvatarItem(entry:IPlayerInfo):void
    {
        _view = new ViewAvatarItem(this, entry);

        super(_view);
    }
}
}
