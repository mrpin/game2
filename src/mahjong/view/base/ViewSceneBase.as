/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.base
{
import com.greensock.TweenMax;

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
     *Static
     */
    private static function tween(view:IView, coordinate:Number):void
    {
        var tweenParam:Object =
        {
            x: coordinate
        };

        TweenMax.to(view.source, ConstantsBase.ANIMATION_DURATION * 4 * 2, tweenParam);
    }


    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _background:IView;
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

    private var _buttonTOP:IViewButton;

    private var _buttonBack:IViewButton;

    private var _appSize:Point;

    //objects for parallax
    private var _viewsForParallax:Array;

    private var _clouds:IView;
    private var _cloudsFull:IView;
    private var _ground:IView;
    private var _groundFull:IView;
    private var _bamboo:IView;
    private var _bambooForFull:IView;
    private var _bambooForest:IView;
    private var _bambooForestFull:IView;

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

    public function set coordinatesMouse(value:Point):void
    {
        if (value.x > 1)
        {
            for each(var view:IView in _viewsForParallax)
            {
                var speed:Number = 4;
                if(_bamboo == view || _bambooForFull == view)
                {
                    speed = 1;
                }
                tween(view, (((_appSize.x - view.source.width) / speed)/* (_appSize.x - view.source.width > 0 ? -1 : 1)*/ / _appSize.x) * value.x);
            }
        }

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

        _viewsForParallax = [];

        _background = new ViewBase(controller, new gBackgroundSmall());//gScreenShot());
        _source.addChild(_background.source);
        _background.hide();

        _backgroundFullscreen = new ViewBase(controller, new gBackgroundFull());
        _source.addChild(_backgroundFullscreen.source);
        _backgroundFullscreen.hide();


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

        _buttonTOP = new ViewButton(controller, new gButtonTop());
        _buttonTOP.position = EViewPosition.EVP_ABSOLUTE;
        _buttonTOP.anchorPoint = new Point(1, 1);
        _source.addChild(_buttonTOP.source);

        _buttonBack = new ViewButton(controller, new gButtonExit());
        _buttonBack.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBack.anchorPoint = new Point(0, 0);
        _source.addChild(_buttonBack.source);
    }

    private function initObjectsForParallax():void
    {
        _clouds = new ViewBase(controller, new gCloud);
        _clouds.anchorPoint = new Point(0, 0);
        _clouds.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_clouds.source);
        _viewsForParallax.push(_clouds);

        _cloudsFull = new ViewBase(controller, new gClouldFull());
        _cloudsFull.anchorPoint = new Point(0, 0);
        _cloudsFull.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_cloudsFull.source);
        _viewsForParallax.push(_cloudsFull);

        _bambooForest = new ViewBase(controller, new gBambooForest());
        _bambooForest.anchorPoint = new Point(0, 1);
        _bambooForest.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_bambooForest.source);
        _viewsForParallax.push(_bambooForest);

        _bambooForestFull = new ViewBase(controller, new gBambooForestFull());
        _bambooForestFull.anchorPoint = new Point(0, 1);
        _bambooForestFull.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_bambooForestFull.source);
        _viewsForParallax.push(_bambooForestFull);

        _ground = new ViewBase(controller, new gGround());
        _ground.anchorPoint = new Point(0, 1);
        _ground.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_ground.source);
        _viewsForParallax.push(_ground);

        _groundFull = new ViewBase(controller, new gGroundFull());
        _groundFull.anchorPoint = new Point(0, 1);
        _groundFull.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_groundFull.source);
        _viewsForParallax.push(_groundFull);


        _bamboo = new ViewBase(controller, new gBamboo());
        _bamboo.anchorPoint = new Point(0, 1);
        _bamboo.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_bamboo.source);
        _viewsForParallax.push(_bamboo);

        _bambooForFull = new ViewBase(controller, new gBambooFull());
        _bambooForFull.anchorPoint = new Point(0, 1);
        _bambooForFull.position = EViewPosition.EVP_ABSOLUTE;
        _source.addChild(_bambooForFull.source);
        _viewsForParallax.push(_bambooForFull);


    }


    override public function placeViews(fullscreen:Boolean):void
    {
        for each(var view:IView in _viewsForParallax)
        {
            TweenMax.killTweensOf(view.source);
            view.source.x = 0;
        }

        _appSize = GameInfo.instance.managerApp.applicationSize;

        if (!fullscreen)
        {
            _background.source.x = 0;//(_appSize.x - _background.source.width) / 2;
            _background.source.y = (_appSize.y - _background.source.height) / 2;
            _background.show();
            _backgroundFullscreen.hide();


            _clouds.translate(0, 0.1);
            _clouds.show();

            _cloudsFull.hide();

            _ground.translate(0, 1);
            _ground.show();

            _groundFull.hide();

            _bamboo.translate(0, 1);
            _bamboo.source.y += 20;
            _bamboo.show();


            _bambooForFull.hide();

            _bambooForest.show();
            _bambooForest.translate(0, 1);
            _bambooForest.source.y -= 10;

            _bambooForestFull.hide();
        }
        else
        {
            _backgroundFullscreen.source.width = _appSize.x;
            _backgroundFullscreen.source.height = _appSize.y;
            _backgroundFullscreen.show();
            _background.hide();


            _clouds.hide();

            _cloudsFull.translate(0, 0.1);
            _cloudsFull.show();
            _cloudsFull.show();

            _ground.hide();

            _groundFull.translate(0, 1);

            _groundFull.show();

            _bamboo.hide();

            _bambooForFull.translate(0, 1);

            _bambooForFull.show();

            _bambooForest.hide();

            _bambooForestFull.translate(0, 1);
            _bambooForestFull.source.y -= 35;
            _bambooForestFull.show();


            _bambooForFull.translate(0, 1);
            _bambooForFull.source.y += 50;
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

        _buttonTOP.translate(1, 1);
        _buttonTOP.source.x += -17;
        _buttonTOP.source.y += -19;

        _buttonBack.translate(0, 0);
        _buttonBack.source.x += 10;
        _buttonBack.source.y += 20;
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

        _background.cleanup();
        _background = null;

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

        _buttonTOP.cleanup();
        _buttonTOP = null;

        _buttonBack.cleanup();
        _buttonBack = null;

        _source = null;

        super.cleanup();
    }
}
}
