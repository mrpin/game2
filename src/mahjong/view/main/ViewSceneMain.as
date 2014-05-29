/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.main
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.view.lobby.ViewSceneLobby;

import views.interfaces.EViewPosition;
import views.interfaces.IView;

public class ViewSceneMain extends ViewSceneLobby
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _containerItems:IView;


    /*
     * Properties
     */
    public function set containerItems(value:IView):void
    {
        if (value == _containerItems)
        {
            return;
        }

        _containerItems = value;
        _containerItems.position = EViewPosition.EVP_ABSOLUTE;
        _containerItems.anchorPoint = new Point(0.5, 0.5);
        _source.addChild(_containerItems.source);
    }

    /*
     * Methods
     */
    public function ViewSceneMain(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        super.buttonBack.source.visible = false;
    }

    override public function addSubView(view:IView):void
    {
        _source.addChild(view.source);
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);

        _containerItems.placeViews(fullscreen);
        _containerItems.translate(0.5, 0.5);
        _containerItems.source.y += -30;
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
