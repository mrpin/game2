/**
 * Created by evgenyyurko on 7/18/14.
 */
package mahjong.view.popup.popups.controller
{
import mahjong.view.popup.popups.*;

import controllers.implementations.popups.lose.ControllerLoseBase;

import mahjong.view.popup.popups.view.ViewPopupLose;

public class ControllerPopupLose extends ControllerLoseBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
   override protected function get classView():Class
   {
       return ViewPopupLose;
   }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ControllerPopupLose()
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
