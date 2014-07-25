/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.states.base
{
import controllers.interfaces.IControllerPopup;

import mahjong.view.popup.popups.controller.ControllerPopupLose;
import mahjong.view.popup.popups.controller.ControllerPopupNoEnergy;
import mahjong.view.popup.popups.controller.bank.ControllerPopupBank;

import states.StateBase;

import views.interfaces.EViewPosition;

public class StateMahjongBase extends StateBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function StateMahjongBase()
    {

    }

    /*
     * IControl
     */

    public override function placeViews(isFullscreen:Boolean):void
    {
        for each(var popup:IControllerPopup in popups)
        {
            popup.view.position = EViewPosition.EVP_ABSOLUTE;
            popup.view.translate(0.5, 0.5);
        }

        super.placeViews(isFullscreen);
    }

    public override function prepareLayerUI():void
    {
        super.prepareLayerUI();
    }

    override public function prepareLayerPopups():void
    {
        super.prepareLayerPopups();

        {//register popups
            registerPopup(new ControllerPopupNoEnergy());
            registerPopup(new ControllerPopupLose());
            registerPopup(new ControllerPopupBank());
        }
    }

    public override function update(type:String):void
    {
        controllerScene.update(type);
    }

    override public function onLoadingEnd():void
    {
        super.onLoadingEnd();
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
