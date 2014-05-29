/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.base
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.geom.Point;

import mahjong.GameInfo;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.EViewPosition;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewSceneBase extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _background:IView;
    private var _backgroundFullscreen:IView;

    private var _gViewCurrency:gViewCurrency;
    private var _viewCurrency:IView;
    private var _buttonCurrency:IViewButton;

    private var _gViewEnergy:gViewEnergy;
    private var _viewEnergy:IView;
    private var _buttonEnergy:IViewButton;

    private var _gViewPoints:gViewPoints;
    private var _viewPoints:IView;

    private var _buttonHelp:IViewButton;

    private var _buttonSound:ViewButtonDouble;

    private var _buttonMusic:ViewButtonDouble;

    private var _buttonFullScreen:IViewButton;

    private var _buttonTOP:IViewButton;

    private var _buttonBack:IViewButton;

    /*
     * Properties
     */
    public function get buttonCurrency():IViewButton
    {
        return _buttonCurrency;
    }

    public function get buttonEnergy():IViewButton
    {
        return _buttonEnergy;
    }

    public function get buttonHelp():IViewButton
    {
        return _buttonHelp;
    }

    public function get buttonSound():ViewButtonDouble
    {
        return _buttonSound;
    }

    public function get buttonMusic():ViewButtonDouble
    {
        return _buttonMusic;
    }

    public function get buttonTOP():IViewButton
    {
        return _buttonTOP;
    }

    public function get buttonFullScreen():IViewButton
    {
        return _buttonFullScreen;
    }

    public function get buttonBack():IViewButton
    {
        return _buttonBack;
    }


    public function set viewCurrencyInfo(value:String):void
    {
        _gViewCurrency.lebelCount.text = value;
    }

    public function set viewEnergyInfo(value:String):void
    {
        _gViewEnergy.lebelCount.text = value;
    }

    public function set viewPointsInfo(value:String):void
    {
        _gViewPoints.lebelCount.text = value;
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
        _background = new ViewBase(controller, new gBackgroundSmall());//gScreenShot());
        _source.addChild(_background.source);
        _background.hide();

        _backgroundFullscreen = new ViewBase(controller, new gBackgroundFull());
        _source.addChild(_backgroundFullscreen.source);
        _backgroundFullscreen.hide();


        _gViewCurrency = new gViewCurrency();
        _viewCurrency = new ViewBase(controller, _gViewCurrency);
        _viewCurrency.position = EViewPosition.EVP_ABSOLUTE;
        _viewCurrency.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewCurrency.source);

        _buttonCurrency = new ViewButton(controller, _gViewCurrency.buttonBank);

        _gViewEnergy = new gViewEnergy();
        _viewEnergy = new ViewBase(controller, _gViewEnergy);
        _viewEnergy.position = EViewPosition.EVP_ABSOLUTE;
        _viewEnergy.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewEnergy.source);

        _buttonEnergy = new ViewButton(controller, _gViewEnergy.buttonEnergy);

        _gViewPoints = new gViewPoints();
        _viewPoints = new ViewBase(controller, _gViewPoints);
        _viewPoints.position = EViewPosition.EVP_ABSOLUTE;
        _viewPoints.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewPoints.source);

        _buttonFullScreen = new ViewButton(controller, new gButtonFullscreen());
        _buttonFullScreen.position = EViewPosition.EVP_ABSOLUTE;
        _buttonFullScreen.anchorPoint = new Point(1, 0);
        _source.addChild(_buttonFullScreen.source);


        _buttonHelp = new ViewButton(controller, new gButtonHelp());
        _buttonHelp.position = EViewPosition.EVP_ABSOLUTE;
        _buttonHelp.anchorPoint = new Point(1, 0);
        _source.addChild(_buttonHelp.source);

        {//init button sound
            _buttonSound = new ViewButtonDouble(controller, new gButtonSoundOn(), new gButtonSoundOff());
            _buttonSound.position = EViewPosition.EVP_ABSOLUTE;
            _buttonSound.anchorPoint = new Point(1, 0);
            _source.addChild(_buttonSound.source);
        }

        {//init button music
            _buttonMusic = new ViewButtonDouble(controller, new gButtonMusicOn(), new gButtonMusicOff());
            _buttonMusic.position = EViewPosition.EVP_ABSOLUTE;
            _buttonMusic.anchorPoint = new Point(1, 0);
            _source.addChild(_buttonMusic.source);
        }

        _buttonTOP = new ViewButton(controller, new gButtonTop());
        _buttonTOP.position = EViewPosition.EVP_ABSOLUTE;
        _buttonTOP.anchorPoint = new Point(1, 1);
        _source.addChild(_buttonTOP.source);

        _buttonBack = new ViewButton(controller, new gButtonExit());
        _buttonBack.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBack.anchorPoint = new Point(0, 0);
        _source.addChild(_buttonBack.source);
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        if (!fullscreen)
        {
            _background.source.x = (appSize.x - _background.source.width) / 2;
            _background.source.y = (appSize.y - _background.source.height) / 2;
            _background.show();
            _backgroundFullscreen.hide();
        }
        else
        {
            _backgroundFullscreen.source.width = appSize.x;
            _backgroundFullscreen.source.height = appSize.y;
            _backgroundFullscreen.show();
            _background.hide();
        }

        var offsetY:int = 15;

        _viewCurrency.translate(0.234, 0);
        _viewCurrency.source.y += offsetY;

        _viewEnergy.translate(0.491, 0);
        _viewEnergy.source.y += offsetY;

        _viewPoints.translate(0.73, 0);
        _viewPoints.source.y += offsetY;

        _buttonFullScreen.translate(1, 0);
        _buttonFullScreen.source.x += -offsetY;
        _buttonFullScreen.source.y += offsetY + 7;

        _buttonHelp.translate(1, 0);
        _buttonHelp.source.x += -offsetY - 54;
        _buttonHelp.source.y += offsetY + 7;

        _buttonSound.translate(1, 0);
        _buttonSound.source.x += -69;
        _buttonSound.source.y += 75;

        _buttonMusic.translate(1, 0);
        _buttonMusic.source.x += -15;
        _buttonMusic.source.y += 75;

        _buttonTOP.translate(1, 1);
        _buttonTOP.source.x += -17;
        _buttonTOP.source.y += -19;

        _buttonBack.translate(0, 0);
        _buttonBack.source.x += 24;
        _buttonBack.source.y += 20;
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _background.cleanup();
        _background = null;

        _backgroundFullscreen.cleanup();
        _backgroundFullscreen = null;

        _viewCurrency.cleanup();
        _viewCurrency = null;

        _buttonCurrency.cleanup();
        _buttonCurrency = null;

        _viewEnergy.cleanup();
        _viewEnergy = null;

        _buttonEnergy.cleanup();
        _buttonEnergy = null;

        _viewPoints.cleanup();
        _viewPoints = null;

        _buttonHelp.cleanup();
        _buttonHelp = null;

        _buttonSound.cleanup();
        _buttonSound = null;

        _buttonMusic.cleanup();
        _buttonMusic = null;

        _buttonFullScreen.cleanup();
        _buttonFullScreen = null;

        _buttonTOP.cleanup();
        _buttonTOP = null;

        _buttonBack.cleanup();
        _buttonBack = null;

        _source = null;

        super.cleanup();
    }
}
}
