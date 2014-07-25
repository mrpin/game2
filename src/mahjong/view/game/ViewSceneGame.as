/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.game
{
import controllers.interfaces.IController;

import effects.PixelExplosion;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;
import mahjong.view.base.ViewSceneBase;

import views.implementations.buttons.ViewButton;
import views.interfaces.EViewPosition;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButton;

public class ViewSceneGame extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewFieldChips:ViewFieldChips;

    private var _viewMeasurePoints:IView;

    private var _buttonBoosterDoneLevel:IViewButton;
    private var _buttonBoosterHint:IViewButton;
    private var _buttonBoosterUndo:IViewButton;
    private var _buttonBoosterMix:IViewButton;

    private var _buttonRetry:IViewButton;

    /*
     * Properties
     */
    public function set viewFieldChips(value:IView):void
    {
        if (value == _viewFieldChips)
        {
            return;
        }

        _viewFieldChips = value as ViewFieldChips;
        _source.addChild(_viewFieldChips.source);
    }

    public function set viewMeasurePoints(value:IView):void
    {
        if (value == _viewMeasurePoints)
        {
            return;
        }

        _viewMeasurePoints = value as ViewMeasurePoints;
        _viewMeasurePoints.position = EViewPosition.EVP_ABSOLUTE;
        _viewMeasurePoints.anchorPoint = new Point(0, 1);
        _source.addChild(_viewMeasurePoints.source);
    }

    public function get buttonBoosterDoneLevel():IViewButton
    {
        return _buttonBoosterDoneLevel;
    }

    public function get buttonBoosterHint():IViewButton
    {
        return _buttonBoosterHint;
    }

    public function get buttonBoosterUndo():IViewButton
    {
        return _buttonBoosterUndo;
    }

    public function get buttonBoosterMix():IViewButton
    {
        return _buttonBoosterMix;
    }

    public function get buttonRetry():IViewButton
    {
        return _buttonRetry;
    }


    /*
     * Methods
     */
    public function ViewSceneGame(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {
//        _viewTimer = new gTimer();
//        _source.addChild(_viewTimer);

        _buttonBoosterDoneLevel = new ViewButton(controller, new gButtonBoosterDoneLevel());
        _buttonBoosterDoneLevel.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBoosterDoneLevel.anchorPoint = new Point(0.5, 1);
        _source.addChild(_buttonBoosterDoneLevel.source);

        _buttonBoosterHint = new ViewButton(controller, new gButtonBoosterHint());
        _buttonBoosterHint.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBoosterHint.anchorPoint = new Point(0.5, 1);
        _source.addChild(_buttonBoosterHint.source);

        _buttonBoosterUndo = new ViewButton(controller, new gButtonBoosterUndo());
        _buttonBoosterUndo.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBoosterUndo.anchorPoint = new Point(0.5, 1);
        _source.addChild(_buttonBoosterUndo.source);

        _buttonBoosterMix = new ViewButton(controller, new gButtonBoosterMix());
        _buttonBoosterMix.position = EViewPosition.EVP_ABSOLUTE;
        _buttonBoosterMix.anchorPoint = new Point(0.5, 1);
        _source.addChild(_buttonBoosterMix.source);

        _buttonRetry = new ViewButton(controller, new gButtonRetry());
        _buttonRetry.position = EViewPosition.EVP_ABSOLUTE;
        _buttonRetry.anchorPoint = new Point(0, 0);
        _source.addChild(_buttonRetry.source);
    }


    public function pixelExplosion():void
    {
        var pixel:PixelExplosion = new PixelExplosion(5, _viewFieldChips.source as DisplayObjectContainer, 8, 0.1, 0, 4, 1.5, 3, 0.8, 2);
        _source.addChild(pixel);
        _viewFieldChips.source.visible = false;
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        _viewFieldChips.placeViews(fullscreen);

        _viewFieldChips.source.x = (appSize.x - _viewFieldChips.source.width) / 2;
        _viewFieldChips.source.y = (appSize.y - _viewFieldChips.source.height) / 2;

        _viewMeasurePoints.translate(0, 1);
        _viewMeasurePoints.source.x += 40;
        _viewMeasurePoints.source.y += -20;


        var offSetY:int = -18;

        _buttonBoosterDoneLevel.translate(0.5, 1);
        _buttonBoosterDoneLevel.source.x += -118;
        _buttonBoosterDoneLevel.source.y += offSetY;

        _buttonBoosterHint.translate(0.5, 1);
        _buttonBoosterHint.source.x += -16;
        _buttonBoosterHint.source.y += offSetY;

        _buttonBoosterUndo.translate(0.5, 1);
        _buttonBoosterUndo.source.x += 86;
        _buttonBoosterUndo.source.y += offSetY;

        _buttonBoosterMix.translate(0.5, 1);
        _buttonBoosterMix.source.x += 186;
        _buttonBoosterMix.source.y += offSetY;

        _buttonRetry.translate(0, 0);
        _buttonRetry.source.x += 70;
        _buttonRetry.source.y += 20;


        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _buttonBoosterDoneLevel.cleanup();
        _buttonBoosterDoneLevel = null;

        _buttonBoosterHint.cleanup();
        _buttonBoosterHint = null;

        _buttonBoosterUndo.cleanup();
        _buttonBoosterUndo = null;

        _buttonBoosterMix.cleanup();
        _buttonBoosterMix = null;

        _buttonRetry.cleanup();
        _buttonRetry = null;

        _viewFieldChips = null;

        _source = null;

        super.cleanup();
    }


}
}
