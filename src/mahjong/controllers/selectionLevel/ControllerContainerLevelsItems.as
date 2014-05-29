/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.IController;
import controllers.implementations.Controller;

import mahjong.GameInfo;
import mahjong.view.selectionLevel.ViewContainerLevelsItems;

import models.interfaces.levels.ILevelContainer;
import models.interfaces.levels.ILevelInfo;

public class ControllerContainerLevelsItems extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewContainerLevelsItems;

    private var _controllersItems:Array;

    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerContainerLevelsItems()
    {
        _view = new ViewContainerLevelsItems(this);
        super(_view);

        init();
    }

    private function init():void
    {
        var levelContainer:ILevelContainer = GameInfo.instance.managerLevels.currentLevelContainer;

        _controllersItems = [];
        var controllerItemsContainer:Array = [];

        var viewsItems:Array = [];
        var viewItemsContainer:Array = [];

        for (var i:int = 0; i < levelContainer.items.length; i++)
        {
            var itemLevel:ILevelInfo = levelContainer.items[i];
            var controllerItem:ControllerSceneSelectionLevelItem = new ControllerSceneSelectionLevelItem(itemLevel);
            controllerItemsContainer.push(controllerItem);
            viewItemsContainer.push(controllerItem.view);

            if ((i + 1) % 15 == 0)
            {
                viewsItems.push(viewItemsContainer);
                _controllersItems.push(controllerItemsContainer);

                viewItemsContainer = [];
                controllerItemsContainer = [];
            }
        }

        _view.viewsItems = viewsItems;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var items:Array in _controllersItems)
        {
            for each(var item:IController in items)
            {
                item.cleanup();
            }
        }


        super.cleanup();
    }


}
}
