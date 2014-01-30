/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.controllers.main
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.view.main.ViewMainItem;

import views.IView;

public class ControllerMainItem extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewMainItem;



    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerMainItem()
    {
        _view = new ViewMainItem(this);
        super(_view);

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {

        }

        return result;
    }

    override public function onViewMouseOver(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {

        }

        return result;
    }

    override public function onViewMouseOut(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewMouseOver(view, e);

        if (!result)
        {

        }

        return result;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view.cleanup();

        super.cleanup();
    }


}
}
