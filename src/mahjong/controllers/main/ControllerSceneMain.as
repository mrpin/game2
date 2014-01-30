/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.main
{
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.main.ViewSceneMain;

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
        _mainItems = [];
        var mainItemsView:Array = [];

        for(var i:int = 0; i < 2; i++)
        {
            var items:Array = [];
            var itemsView:Array = [];

            for(var k:int = 0; k < 3; k++)
            {
                var item:ControllerMainItem = new ControllerMainItem();
                items.push(item);
                itemsView.push(item.view);
            }
            _mainItems.push(items);
            mainItemsView.push(itemsView);
        }
          _view.items = mainItemsView;
    }



    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view.cleanup();
        _view = null;

        super.cleanup();
    }


}
}
