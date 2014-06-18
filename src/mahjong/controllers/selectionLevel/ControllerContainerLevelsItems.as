/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.IController;
import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.view.selectionLevel.ViewContainerLevelsItems;

import models.interfaces.levels.ILevelContainer;
import models.interfaces.levels.ILevelInfo;

import mx.utils.StringUtil;

import views.interfaces.IView;

public class ControllerContainerLevelsItems extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewContainerLevelsItems;

    private var _controllersItems:Array;

    private var _currentContainer:uint;

    /*
     * Properties
     */


    /*
     * Events
     */
    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);

        switch (view)
        {
            case _view.buttonBack:
            {
                if(_currentContainer != 1 && _view.isTweenEnd)
                {
                    _view.moveAllItems(false);
                    _currentContainer --
                }

                result = true;

                break;
            }
            case _view.buttonNext:
            {
                if(_currentContainer < _controllersItems.length && _view.isTweenEnd)
                {
                    _view.moveAllItems(true);
                    _currentContainer ++;
                }

                result = true;

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }

        return result;
    }

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

       _view.textButtonNext = StringUtil.substitute("{0}/{1}", levelContainer.completeLevelsCount, levelContainer.items.length);

        _view.viewsItems = viewsItems;

        _currentContainer = 1;
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
