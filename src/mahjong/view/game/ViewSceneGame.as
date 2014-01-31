/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mahjong.GameInfo;

import mahjong.view.base.ViewSceneBase;

import views.IView;
import views.IViewButton;
import views.IViewButtonLabeled;
import views.implementations.buttons.ViewButton;
import views.implementations.buttons.ViewButtonLabeled;

public class ViewSceneGame extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewFieldChips:ViewFieldChips;
//TODO: переименовать buttons
    private var _button0:IViewButtonLabeled;
    private var _button1:IViewButtonLabeled;
    private var _button2:IViewButtonLabeled;
    private var _button3:IViewButtonLabeled;

    /*
     * Properties
     */
    public function set viewFieldChips(value:IView):void
    {
        _viewFieldChips = value as ViewFieldChips;
        _source.addChild(_viewFieldChips.source);
    }

    public function get button0():IViewButtonLabeled
    {
        return _button0;
    }

    public function get button1():IViewButtonLabeled
    {
        return _button1;
    }

    public function get button2():IViewButtonLabeled
    {
        return _button2;
    }

    public function get button3():IViewButtonLabeled
    {
        return _button3;
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
        _button0 = new ViewButtonLabeled(controller, new gButtonPurchase());
        _source.addChild(_button0.source);

        _button1 = new ViewButtonLabeled(controller, new gButtonPurchase());
        _source.addChild(_button1.source);

        _button2 = new ViewButtonLabeled(controller, new gButtonPurchase());
        _source.addChild(_button2.source);

        _button3 = new ViewButtonLabeled(controller, new gButtonPurchase());
        _source.addChild(_button3.source);
    }


    override public function addSubView(view:IView):void
    {

    }


    override public function placeViews(fullscreen:Boolean):void
    {
        var appSize:Point = GameInfo.instance.managerApp.applicationSize;

        _viewFieldChips.x =   (appSize.x / 2) + (_viewFieldChips.width / 2); // 700 : 900;
        _viewFieldChips.y =  (appSize.y / 2) - (_viewFieldChips.height / 2);// 300 : 600;


        _button0.x = 130;
        _button0.y = 180;

        _button1.x = 130;
        _button1.y = 260;

        _button2.x = 130;
        _button2.y = 340;

        _button3.x = 130;
        _button3.y = 420;

        _viewFieldChips.placeViews(fullscreen);

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
//        _viewFieldChips.cleanup();
//        _viewFieldChips = null;

        _button0.cleanup();
        _button0 = null;

        _button1.cleanup();
        _button1 = null;

        _button2.cleanup();
        _button2 = null;

        _button3.cleanup();
        _button3 = null;

        super.cleanup();
    }


}
}
