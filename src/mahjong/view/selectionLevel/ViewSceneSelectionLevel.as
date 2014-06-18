/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Point;

import mahjong.GameInfo;
import mahjong.view.lobby.ViewSceneLobby;

import views.interfaces.IView;

public class ViewSceneSelectionLevel extends ViewSceneLobby
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewContainerItems:ViewContainerLevelsItems;

    private var _mask:Sprite;

    /*
     * Properties
     */
    public function set viewContainerItems(value:IView):void
    {
        if (value == _viewContainerItems)
        {
            return;
        }

        _viewContainerItems = value as ViewContainerLevelsItems;
        _source.addChild(_viewContainerItems.source);

        _mask = new Sprite();
        _mask.graphics.beginFill(0x000000);
        _mask.graphics.drawRect(-5, -5, _viewContainerItems.size.x, _viewContainerItems.size.y + 60);
        _mask.graphics.endFill();

        _source.addChild(_mask);

        _viewContainerItems.source.mask = _mask;
    }


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewSceneSelectionLevel(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        _viewContainerItems.placeViews(fullscreen);

        _viewContainerItems.source.x = (appSize.x - _viewContainerItems.size.x) / 2;
        _viewContainerItems.source.y = (appSize.y - _viewContainerItems.size.y - 120) / 2;

        _mask.x =  _viewContainerItems.source.x;
        _mask.y =  _viewContainerItems.source.y;


        super.placeViews(fullscreen);
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
