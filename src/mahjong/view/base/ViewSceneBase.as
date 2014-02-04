/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.base
{
import controllers.IController;

import flash.display.DisplayObjectContainer;

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

//    private var _buttonSettings:IViewButton;
//    private var _buttonSound:IViewButton;
    private var _buttonTOP:IViewButton;
    private var _buttonFullScreen:IViewButton;
    private var _buttonHelp:IViewButton;
    private var _buttonBack:IViewButton;
    private var _buttonCurrency:IViewButton;

    private var _viewCurrency:IView;
    private var _viewEnergy:IView;
    private var _viewPoints:IView;

    /*
     * Properties
     */
//    public function get buttonSettings():IViewButton
//    {
//        return _buttonSettings;
//    }

//    public function get buttonSound():IViewButton
//    {
//        return _buttonSound;
//    }

    public function get buttonTOP():IViewButton
    {
        return _buttonTOP;
    }

    public function get buttonFullScreen():IViewButton
    {
        return _buttonFullScreen;
    }

    public function get buttonHelp():IViewButton
    {
        return _buttonHelp;
    }

    public function get buttonBack():IViewButton
    {
        return _buttonBack;
    }

    public function get buttonCurrency():IViewButton
    {
        return _buttonCurrency;
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
        _background = new ViewBase(controller, new gViewBackground());
        _source.addChild(_background.source);


        var viewCurrency:gViewCurrency = new gViewCurrency();
        _viewCurrency = new ViewBase(controller, viewCurrency);
        _source.addChild(_viewCurrency.source);

        _viewEnergy = new ViewBase(controller, new gViewEnergy());
        _source.addChild(_viewEnergy.source);


        _buttonCurrency = new ViewButton(controller, viewCurrency.buttonCurrency);

        _viewPoints = new ViewBase(controller, new gViewPoints);
        _source.addChild(_viewPoints.source);


//        _buttonSettings = new ViewButton(controller, new gButtonSetting());
//        _source.addChild(_buttonSettings.source);

//        _buttonSound = new ViewButton(controller, new gButtonSound());
//        _source.addChild(_buttonSound.source);

        _buttonTOP = new ViewButton(controller, new gButtonTop());
        _source.addChild(_buttonTOP.source);

        _buttonFullScreen = new ViewButton(controller, new gButtonFullscreen());
        _source.addChild(_buttonFullScreen.source);

        _buttonHelp = new ViewButton(controller, new gButtonHelp());
        _source.addChild(_buttonHelp.source);

        _buttonBack = new ViewButton(controller, new gButtonBack());
        _source.addChild(_buttonBack.source);


    }


    override public function placeViews(fullscreen:Boolean):void
    {
//        _background.x = 5;

        _viewCurrency.x = fullscreen ? 304 + 460 : 304;
        _viewCurrency.y = fullscreen ? 55 : 55;

        _viewEnergy.x = fullscreen ? 504 + 460 : 504;
        _viewEnergy.y = fullscreen ? 60 : 60;

        _viewPoints.x = fullscreen ? 704 + 460 : 704;
        _viewPoints.y = fullscreen ? 53 : 53;


//        _buttonSettings.x = targetScale - 100;
//        _buttonSettings.y = 100;
//
//        _buttonSound.x = targetScale - 100;
//        _buttonSound.y = 250;

        _buttonTOP.x = fullscreen ? 885 + 890 : 885;
        _buttonTOP.y = fullscreen ? 55 : 55;

        _buttonFullScreen.x = fullscreen ? 955 + 890 : 955;
        _buttonFullScreen.y = fullscreen ? 55 : 55;

        _buttonHelp.x = fullscreen ? 955 + 890 : 955;
        _buttonHelp.y = fullscreen ? 120 : 120;

        _buttonBack.x = fullscreen ? 55 : 55;
        _buttonBack.y = fullscreen ? 55 : 55;
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _background.cleanup();
        _background = null;

        _viewCurrency.cleanup();
        _viewCurrency = null;

        _viewEnergy.cleanup();
        _viewEnergy = null;

        _viewPoints.cleanup();
        _viewPoints = null;

        _buttonCurrency.cleanup();
        _buttonCurrency = null;

//        _buttonSettings.cleanup();
//        _buttonSettings = null;

//        _buttonSound.cleanup();
//        _buttonSound = null;

        _buttonTOP.cleanup();
        _buttonTOP = null;

        _buttonFullScreen.cleanup();
        _buttonFullScreen = null;

        _buttonHelp.cleanup();
        _buttonHelp = null;

        _buttonBack.cleanup();
        _buttonBack = null;

        _source = null;

        super.cleanup();
    }
}
}
