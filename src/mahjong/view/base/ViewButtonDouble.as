/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.base
{
import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.MouseEvent;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.buttons.IViewButton;

public class ViewButtonDouble extends ViewBase
{
    /*
     * Fields
     */
    private var _source:MovieClip;

    private var _buttonOn:IViewButton;
    private var _buttonOff:IViewButton;

    private var _isOn:Boolean;

    /*
     * Properties
     */
    public function get On():IViewButton
    {
        return _buttonOn;
    }

    public function get Off():IViewButton
    {
        return _buttonOff;
    }

    public function get isOn():Boolean
    {
        return _isOn;
    }

    public function set isOn(value:Boolean):void
    {
        if (value == _isOn)
        {
            return;
        }

        _isOn = value;

        _buttonOn.source.visible = _isOn;
        _buttonOff.source.visible = !_isOn;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewButtonDouble(controller:IController, buttonOn:DisplayObjectContainer, buttonOff:DisplayObjectContainer, isOn:Boolean = true)
    {
        _source = new MovieClip();
        super(controller, _source);

        _isOn = isOn;

        _buttonOn = new ViewButton(controller, buttonOn);
        _source.addChild(_buttonOn.source);
        _buttonOn.source.visible = _isOn;

        _buttonOff = new ViewButton(controller, buttonOff);
        _source.addChild(_buttonOff.source);
        _buttonOff.source.visible = !_isOn;


        init();
    }

    private function init():void
    {

    }

    protected override function onMouseClick(e:MouseEvent):void
    {
//        super.onMouse  Click(e);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonOn.cleanup();
        _buttonOn = null;

        _buttonOff.cleanup();
        _buttonOff = null;

        _source = null;

        super.cleanup();
    }


}
}
