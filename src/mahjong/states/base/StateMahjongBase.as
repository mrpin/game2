/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.states.base
{
import controllers.IControllerPopup;

import models.implementations.states.base.StateBase;

import views.EViewPosition;

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
