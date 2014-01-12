/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.base
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.geom.Point;

import mahjong.GameInfo;

import views.IView;
import views.IViewButton;
import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;

public class ViewSceneBase extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _background:IView;

    private var _buttonTOP:IViewButton;
    private var _buttonSettings:IViewButton;
    private var _buttonSound:IViewButton;
    private var _buttonFullScreen:IViewButton;
    private var _buttonHelp:IViewButton;

    private var _appSize:Point;

    /*
     * Properties
     */
    public function get buttonTOP():IViewButton
    {
        return _buttonTOP;
    }

    public function get buttonSettings():IViewButton
    {
        return _buttonSettings;
    }

    public function get buttonSound():IViewButton
    {
        return _buttonSound;
    }

    public function get buttonFullScreen():IViewButton
    {
        return _buttonFullScreen;
    }

    public function get buttonHelp():IViewButton
    {
        return _buttonHelp;
    }

    /*
     * Methods
     */
    public function ViewSceneBase(controller:IController, source:DisplayObjectContainer)
    {
        _source = source;
        super(controller, _source);

        init();
    }

    private function init():void
    {
        _appSize = GameInfo.instance.managerApp.applicationSize;

        _background = new ViewBase(controller, new gViewBackground());
        _source.addChild(_background.source);

//        _buttonTOP = new ViewButton(controller /*TODO:вставить графику*/);
//        _source.addChild(_buttonTOP.source);

        var buttonSetting:gButtonSetting = new gButtonSetting();

        _buttonSettings = new ViewButton(controller, buttonSetting.button);
        _source.addChild(_buttonSettings.source);

//        _buttonSound = new ViewButton(controller /*TODO:вставить графику*/);
//        _source.addChild(_buttonSound.source);

//        _buttonFullScreen = new ViewButton(controller /*TODO:вставить графику*/);
//        _source.addChild(_buttonFullScreen.source);

//        _buttonHelp = new ViewButton(controller /*TODO:вставить графику*/);
//        _source.addChild(_buttonHelp.source);

    }


    override public function placeViews(fullscreen:Boolean):void
    {
             //TODO:доделать фуллскрин
//        var targetScale:Number = fullscreen ?  _background.source.width / _appSize.x : 1.0;
        var targetScale:Number = fullscreen ? _background.source.width : _appSize.x;

        Debug.log(_appSize.x.toString());
        Debug.log(_background.source.width.toString());

        _buttonSettings.x = targetScale - 100;
        _buttonSettings.y = 100;
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _background.cleanup();
        _background = null;

        _buttonTOP.cleanup();
        _buttonTOP = null;

        _buttonSettings.cleanup();
        _buttonSettings = null;

        _buttonSound.cleanup();
        _buttonSound = null;

        _buttonFullScreen.cleanup();
        _buttonFullScreen = null;

        _buttonHelp.cleanup();
        _buttonHelp = null;

        _appSize = null;

        _source = null;

        super.cleanup();
    }

    public function set appSize(value:Point):void
    {
        _appSize = value;
    }
}
}
