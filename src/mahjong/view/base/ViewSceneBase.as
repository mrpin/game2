/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.base
{
import com.greensock.TweenMax;

import controllers.interfaces.IController;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.geom.Point;

import mahjong.GameInfo;
import mahjong.view.base.paralax.IViewParallax;
import mahjong.view.base.paralax.ViewParallax;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.EViewPosition;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewSceneBase extends ViewBase
{
    /*
     *Static
     */


    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _backgroundFullscreen:IView;

    private var _gViewCurrency:gViewCurrency;
    private var _viewIconCurrency:IView;
    private var _buttonCurrency:IViewButton;

    private var _viewEnergy:IView;

    private var _gViewPoints:gViewPoints;
    private var _viewIconPoints:IView;

    private var _buttonHelp:IViewButton;

    private var _buttonSound:ViewButtonDouble;

    private var _buttonMusic:ViewButtonDouble;

    private var _buttonFullScreen:IViewButton;

    private var _buttonBack:IViewButton;

    //objects for parallax
    private var _viewsForParallax:Array;

    private var _cloud:IViewParallax;
    private var _ground:IViewParallax;
    private var _bamboo:IViewParallax;
    private var _bambooForest:IViewParallax;


    /*
     * Properties
     */
    public function get buttonCurrency():IViewButton
    {
        return _buttonCurrency;
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

    public function get buttonFullScreen():IViewButton
    {
        return _buttonFullScreen;
    }

    public function get buttonBack():IViewButton
    {
        return _buttonBack;
    }


    public function set viewCurrencyInfo(value:Number):void
    {
        _gViewCurrency.lebelCount.text = value.toString();
    }

    public function set viewPointsInfo(value:int):void
    {
        _gViewPoints.lebelCount.text = value.toString();
    }

    public function set viewEnergy(value:IView):void
    {
        if (value == _viewEnergy)
        {
            return;
        }

        _viewEnergy = value;
        _viewEnergy.position = EViewPosition.EVP_ABSOLUTE;
        _viewEnergy.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewEnergy.source);
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
        _viewsForParallax = [];

        _backgroundFullscreen = new ViewBase(controller, new gBackgroundFull());
        _source.addChild(_backgroundFullscreen.source);


        initObjectsForParallax();

        _gViewCurrency = new gViewCurrency();
        _viewIconCurrency = new ViewBase(controller, _gViewCurrency);
        _viewIconCurrency.position = EViewPosition.EVP_ABSOLUTE;
        _viewIconCurrency.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewIconCurrency.source);

        _buttonCurrency = new ViewButton(controller, _gViewCurrency.buttonBank);

        _gViewPoints = new gViewPoints();
        _viewIconPoints = new ViewBase(controller, _gViewPoints);
        _viewIconPoints.position = EViewPosition.EVP_ABSOLUTE;
        _viewIconPoints.anchorPoint = new Point(0.5, 0);
        _source.addChild(_viewIconPoints.source);

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

        _buttonBack = new ViewButton(controller, new gButtonExit());
        _buttonBack.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBack.anchorPoint = new Point(0, 0);
        _source.addChild(_buttonBack.source);
    }

    private function initObjectsForParallax():void
    {
        _cloud = createViewParallax(gCloudFull, new Point(0.5, 0), new Point(90, 25), new Point(-1, 1));
        _bambooForest = createViewParallax(gBambooForestFull, new Point(0.5, 1), new Point(150, 30), new Point(-1, 1));
        _ground = createViewParallax(gGroundFull, new Point(0.5, 1), new Point(90, 25), new Point(-1, 1));
        _bamboo = createViewParallax(gBambooFull, new Point(0.5, 1), new Point(90, 20), new Point(1, 1));
    }

    private function createViewParallax(sourceClass:Class, anchor:Point, moveLimits:Point, moveDirection:Point):IViewParallax
    {
        var movieClip:MovieClip = new sourceClass();
        var result:IViewParallax = new ViewParallax(controller, movieClip);
        result.anchorPoint = anchor;
        result.moveLimits = moveLimits;
        result.moveDirection = moveDirection;

        result.duration = 3;
        result.position = EViewPosition.EVP_ABSOLUTE;

        _source.addChild(result.source);

        return result;
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        if (!fullscreen)
        {
            _backgroundFullscreen.source.x = (appSize.x - _backgroundFullscreen.source.width) / 2;
            _backgroundFullscreen.source.y = appSize.y - _backgroundFullscreen.source.height;
        }
        else
        {
            _backgroundFullscreen.source.x = 0;
            _backgroundFullscreen.source.y = 0;
            _backgroundFullscreen.source.width = appSize.x;
            _backgroundFullscreen.source.height = appSize.y;
        }

        var offsetY:int = 15;

        _viewIconCurrency.translate(0.234, 0);
        _viewIconCurrency.source.y += offsetY;

        _viewEnergy.translate(0.491, 0);
        _viewEnergy.source.y += offsetY;

        _viewIconPoints.translate(0.73, 0);
        _viewIconPoints.source.y += offsetY;

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

        _buttonBack.translate(0, 0);
        _buttonBack.source.x += 10;
        _buttonBack.source.y += 20;

        //place views parallax
        _cloud.translate(0.5, 0.1);
        _cloud.placeViews(fullscreen);

        _ground.translate(0.5, 1);
        _ground.source.y += 20;
        _ground.placeViews(fullscreen);

        _bamboo.translate(0.5, 1);
        _bamboo.source.y += 40;
        _bamboo.placeViews(fullscreen);

        _bambooForest.translate(0.5, 1);
        _bambooForest.source.y -= 5;
        _bambooForest.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var view:IView in _viewsForParallax)
        {
            TweenMax.killTweensOf(view.source);
            view.cleanup();
        }
        _viewsForParallax = null;

        _backgroundFullscreen.cleanup();
        _backgroundFullscreen = null;

        _cloud.cleanup();
        _cloud = null;

        _ground.cleanup();
        _ground = null;

        _bamboo.cleanup();
        _bamboo = null;

        _bambooForest.cleanup();
        _bambooForest = null;

        _viewIconCurrency.cleanup();
        _viewIconCurrency = null;

        _buttonCurrency.cleanup();
        _buttonCurrency = null;

        _viewIconPoints.cleanup();
        _viewIconPoints = null;

        _buttonHelp.cleanup();
        _buttonHelp = null;

        _buttonSound.cleanup();
        _buttonSound = null;

        _buttonMusic.cleanup();
        _buttonMusic = null;

        _buttonFullScreen.cleanup();
        _buttonFullScreen = null;

        _buttonBack.cleanup();
        _buttonBack = null;

        _gViewPoints = null;

        _gViewCurrency = null;

        _source = null;

        _viewEnergy = null;

        super.cleanup();
    }
}
}
