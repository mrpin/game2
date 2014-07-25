/**
 * Created by evgenyyurko on 7/23/14.
 */
package mahjong.view.popup.popups.controller.win
{
import controllers.implementations.popups.win.ControllerWinBase;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;

import mahjong.view.popup.popups.view.win.ViewPopupWin;

import views.interfaces.IView;
import views.interfaces.popups.win.IViewPopupWin;
//TODO:доделать звезды
public class ControllerPopupWin extends ControllerWinBase
{
    /*
     * Fields
     */
    /*
     * Properties
     */
    override protected function get classView():Class
    {
        return ViewPopupWin;
    }

    /*
     * Events
     */
    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        var result:Boolean = super.onViewClicked(view, e);



        return result;
    }

    /*
     * Methods
     */
    public function ControllerPopupWin()
    {


        init();
    }

    private function init():void
    {

    }
}
}
