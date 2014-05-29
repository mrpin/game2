/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.main
{
import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.controllers.lobby.ControllerSceneLobby;
import mahjong.view.main.ViewContainerLevelContainers;
import mahjong.view.main.ViewSceneMain;

import models.interfaces.levels.ILevelContainer;

import views.interfaces.IView;

public class ControllerSceneMain extends ControllerSceneLobby
{
    /*
     * Fields
     */
    private var _view:ViewSceneMain;

    private var _controllerItems:Array;

    private var _viewContainerItems:ViewContainerLevelContainers;

    /*
     * Properties
     */

    /*
     * Events
     */

    /*
     * Methods
     */
    public function ControllerSceneMain()
    {
        _view = new ViewSceneMain(this);

        super(_view);

        init();
    }

    private function init():void
    {
        _view.buttonBack.hide();

        _controllerItems = [];


        var itemsInfo:Array = GameInfo.instance.managerLevels.items;
        Debug.assert(itemsInfo.length > 5);

        var viewItems:Array = [];

        for (var i:uint = 0; i < itemsInfo.length; i++)
        {
            var levelContainer:ILevelContainer = itemsInfo[i];

            var item:ControllerMainItem = new ControllerMainItem(levelContainer);
            viewItems.push(item.view);
            _controllerItems.push(item);
        }

        _viewContainerItems = new ViewContainerLevelContainers(this);
        _viewContainerItems.viewItems = viewItems;

        _view.containerItems = _viewContainerItems;
    }

    override public function update(type:String):void
    {
       super.update(type);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var item:ControllerMainItem in _controllerItems)
        {
            item.cleanup();
        }

        _viewContainerItems.cleanup();
        _viewContainerItems = null;

        super.cleanup();
    }


}
}
