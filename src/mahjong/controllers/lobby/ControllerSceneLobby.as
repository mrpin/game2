/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.controllers.lobby
{
import controllers.implementations.friends.ControllerFriendsBase0;

import flash.events.MouseEvent;

import mahjong.controllers.base.ControllerSceneBase;
import mahjong.controllers.lobby.friends.ControllerFriends;
import mahjong.view.lobby.ViewSceneLobby;

import views.interfaces.IView;

public class ControllerSceneLobby extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneLobby;

    private var _controllerFriends:ControllerFriendsBase0;


    /*
     * Properties
     */


    /*
     * Events
     */

    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        return result;
    }

    /*
     * Methods
     */
    public function ControllerSceneLobby(view:ViewSceneLobby)
    {
        _view = view;
        super(_view);

        init();
    }

    private function init():void
    {
        _controllerFriends = new ControllerFriends();
        _view.viewFriends = _controllerFriends.view;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _controllerFriends.cleanup();
        _controllerFriends = null;

        super.cleanup();
    }


}
}
