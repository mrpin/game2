/**
 * Created by evgenyyurko on 6/26/14.
 */
package mahjong.view.lobby.friends
{
import controllers.interfaces.IController;

import flash.geom.Point;

import views.implementations.friends.ViewFriendsBase0;

public class ViewFriends extends ViewFriendsBase0
{
    /*
     * Fields
     */

    /*
     * Properties
     */
    override protected function get positionItems():Point
    {
        return new Point(-97, 10);
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewFriends(controller:IController)
    {
        super(controller);

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
