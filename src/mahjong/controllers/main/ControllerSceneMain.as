/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.main
{
import mahjong.GameInfo;
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.main.ViewSceneMain;

import models.interfaces.levels.ILevelContainer;

public class ControllerSceneMain extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneMain;

    private var _mainItems:Array;

    /*
     * Properties
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

        _mainItems = [];

        var items:Array = GameInfo.instance.managerLevels.items;

        for (var i:uint = 0; i < items.length; i++)
        {
            var levelContainer:ILevelContainer = i < items.length ? items[i] : null;

            var item:ControllerMainItem = new ControllerMainItem(levelContainer);
            _view.addSubView(item.view);
            _mainItems.push(item);
        }

    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var item:ControllerMainItem in _mainItems)
        {
            item.cleanup();
            item = null;
        }

        super.cleanup();
    }


}
}
