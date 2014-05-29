/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;

import mahjong.view.lobby.ViewSceneLobby;
import mahjong.view.main.ViewContainerLevelContainers;

import views.implementations.ViewBase;

import views.interfaces.EViewPosition;
import views.interfaces.IView;

public class ViewSceneSelectionLevel extends ViewSceneLobby
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewContainerItems:ViewContainerLevelsItems;

    /*
     * Properties
     */
    public function set viewContainerItems(value:IView):void
    {
        if(value == _viewContainerItems)
        {
            return;
        }

        _viewContainerItems = value as ViewContainerLevelsItems;
        _source.addChild(_viewContainerItems.source);
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
        _viewContainerItems.source.y = (appSize.y - _viewContainerItems.size.y) / 2;

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
