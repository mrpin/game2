/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.view.main
{
import controllers.IController;

import views.implementations.ViewBase;

import views.implementations.buttons.ViewButton;

public class ViewMainItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gSceneMainItem;



    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewMainItem(controller:IController)
    {
        _source = new gSceneMainItem();
        super(controller, _source);

        _source.art.gotoAndStop(1);

        _source.art.item.gotoAndStop(1);

        this.handleEvents(true, false, false, false, false, true, true);

        init();
    }

    private function init():void
    {

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
