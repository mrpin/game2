/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.view.main
{
import com.greensock.TweenMax;
import com.greensock.easing.Bounce;

import controllers.IController;

import fl.motion.Color;

import mahjong.GameInfo;

import models.interfaces.levels.ILevelContainer;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;

public class ViewMainItem extends ViewButton
{
    /*
     * Fields
     */
    private var _source:gSceneMainItem;


    /*
     * Properties
     */


    public function set nameLevelContainer(value:String):void
    {
        _source.labelLevel.text = value;
    }

    public function set isOpen(value:Boolean):void
    {
        _source.viewFence.visible = !value;
        _source.viewLock.visible = !value;

        if (!value)
        {
            var color:Color = new Color();

                color.brightness = -0.5;

            _source.transform.colorTransform = color;

            this.handleEvents();
        }
    }

    /*
     * Methods
     */
    public function ViewMainItem(controller:IController)
    {
        _source = new gSceneMainItem();
        super(controller, _source);

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
        _source = null;

        super.cleanup();
    }


}
}
