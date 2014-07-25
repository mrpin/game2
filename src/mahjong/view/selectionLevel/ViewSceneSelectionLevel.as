/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.selectionLevel
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;
import mahjong.view.lobby.ViewSceneLobby;

import utils.UtilsDisplayObject;

import views.interfaces.IView;

public class ViewSceneSelectionLevel extends ViewSceneLobby
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewContainerItems:ViewContainerLevelsItems;

    private var _itemsPlaceholder:gItemsMask;


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

        _itemsPlaceholder.viewMask.itemsPlace.addChild(_viewContainerItems.source);
    }

    public function set popupView(value:IView):void
    {
        _source.addChild(value.source);
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
        _itemsPlaceholder = new gItemsMask();
        _itemsPlaceholder.viewMask.itemsPlace.removeChildren();

        UtilsDisplayObject.setMouseEnabledForChildren(_itemsPlaceholder, false);

        _source.addChild(_itemsPlaceholder);
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        _itemsPlaceholder.x = (appSize.x - _viewContainerItems.gridSizeInPixels.x - 45) / 2;
        _itemsPlaceholder.y = (appSize.y - _viewContainerItems.gridSizeInPixels.y - 90) / 2;

        _viewContainerItems.placeViews(fullscreen);

        _viewContainerItems.source.x = 25;
        _viewContainerItems.source.y = 10;

//        _viewContainerItems.source.x = (appSize.x - _viewContainerItems.gridSizeInPixels.x) / 2;
//        _viewContainerItems.source.y = (appSize.y - _viewContainerItems.gridSizeInPixels.y - 120) / 2;

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _viewContainerItems = null;

        _source = null;

        super.cleanup();
    }


}
}
