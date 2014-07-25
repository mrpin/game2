/**
 * Created by evgenyyurko on 6/26/14.
 */
package mahjong.controllers.lobby.friends
{
import controllers.implementations.friends.ControllerFriendsBase0;

import mahjong.view.lobby.friends.ViewFriends;

public class ControllerFriends extends ControllerFriendsBase0
{
    /*
     * Fields
     */

    /*
     * Properties
     */
    override public function get viewClass():Class
    {
        return ViewFriends;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerFriends()
    {

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
