/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.controllers.selectionLevel
{
import controllers.implementations.Controller;
import controllers.interfaces.IController;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.view.selectionLevel.ViewContainerLevelsItems;

import models.interfaces.levels.ILevelContainer;
import models.interfaces.levels.ILevelInfo;

import views.interfaces.IView;

public class ControllerContainerLevelsItems extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewContainerLevelsItems;

    private var _items:Array;

    private var _pageCurrent:uint;
    private var _pagesCount:uint;

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
            case _view.buttonPrev:
            {
                _view.buttonPrev.enabled = false;
                _view.buttonNext.enabled = false;

                _view.moveCurrentPageToRight(_pageCurrent,
                        function ():void
                        {
                            _view.buttonPrev.enabled = true;
                            _view.buttonNext.enabled = true;
                        });

                _pageCurrent--;
                updateButtons();

                result = true;

                break;
            }
            case _view.buttonNext:
            {
                _view.buttonPrev.enabled = false;
                _view.buttonNext.enabled = false;

                _view.moveCurrentPageToLeft(_pageCurrent,
                        function ():void
                        {
                            _view.buttonPrev.enabled = true;
                            _view.buttonNext.enabled = true;
                        });
                _pageCurrent++;
                updateButtons();
//                }

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

        _items = [];
        var controllerItemsContainer:Array = [];
        var itemsRow:Array = [];

        var viewsItems:Array = [];
        var viewItemsContainer:Array = [];
        var viewRow:Array = [];

        var itemsOnPage:uint = _view.gridSize.x * _view.gridSize.y;

        for (var i:int = 0; i < levelContainer.items.length; i++)
        {
            var itemLevel:ILevelInfo = levelContainer.items[i];

            var controllerItem:ControllerSceneSelectionLevelItem = new ControllerSceneSelectionLevelItem(itemLevel);
            itemsRow.push(controllerItem);
            viewRow.push(controllerItem.view);
            if ((i + 1) % 5 == 0)
            {
                controllerItemsContainer.push(itemsRow);
                viewItemsContainer.push(viewRow);

                itemsRow = [];
                viewRow = [];
            }

            if ((i + 1) % itemsOnPage == 0)
            {
                viewsItems.push(viewItemsContainer);
                _items.push(controllerItemsContainer);

                viewItemsContainer = [];
                controllerItemsContainer = [];
            }
        }

        _view.updateButtonNext(levelContainer.completeLevelsCount, levelContainer.items.length);

        _view.items = viewsItems;

        _pageCurrent = 0;
        _pagesCount = levelContainer.items.length / itemsOnPage;

        updateButtons();
    }

    private function updateButtons():void
    {
        _pageCurrent == 0 ? _view.buttonPrev.hide() : _view.buttonPrev.show();
        _pageCurrent == _pagesCount - 1 ? _view.buttonNext.hide() : _view.buttonNext.show();
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var items:Array in _items)
        {
            for each (var row:Array in items)
            {
                for each(var item:IController in row)
                {
                    item.cleanup();
                }
            }

        }

        _items = null;

        _view = null;

        super.cleanup();
    }


}
}
