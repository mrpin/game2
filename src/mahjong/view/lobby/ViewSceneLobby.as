/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.lobby
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.geom.Point;

import mahjong.view.base.ViewSceneBase;

import views.implementations.ViewBase;

import views.implementations.friends.ViewFriendsBase0;
import views.interfaces.EViewPosition;

import views.interfaces.IView;
import views.interfaces.buttons.IViewButtonLabeled;
import views.interfaces.friends.IViewFriendItem;
import views.interfaces.friends.IViewFriends;

public class ViewSceneLobby extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewFriends:IView;


    /*
     * Properties
     */
    public function set viewFriends(value:IView):void
    {
        if (value == _viewFriends)
        {
            return;
        }

        _viewFriends = value;
        _viewFriends.position = EViewPosition.EVP_ABSOLUTE;
        _viewFriends.anchorPoint = new Point(0, 1);
        _source.addChild(_viewFriends.source);
    }


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewSceneLobby(controller:IController, source:DisplayObjectContainer)
    {
        _source = source;
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }

    override public function placeViews(fullscreen:Boolean):void
    {
        _viewFriends.placeViews(fullscreen);

        _viewFriends.translate(0, 1);
        _viewFriends.source.x += 200;
        _viewFriends.source.y -= 10;

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _viewFriends = null;

        _source = null;

        super.cleanup();
    }


}
}
