/**
 * Created by evgenyyurko on 7/23/14.
 */
package mahjong.view.popup.popups.view.win
{
import controllers.interfaces.IControllerPopup;

import flash.display.DisplayObjectContainer;
import flash.utils.setTimeout;

import utils.Utils;

import views.implementations.popups.win.ViewWinBase0;
import views.interfaces.buttons.IViewButtonLabeled;
import views.interfaces.popups.win.IViewPopupWin;
//TODO:доделать звезды
public class ViewPopupWin extends ViewWinBase0
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;
    private var _star0:ViewPopupWinStar;
    private var _star1:ViewPopupWinStar;
    private var _star2:ViewPopupWinStar;

    /*
     * Properties
     */
    override public function get buttonNext():IViewButtonLabeled
    {
        return super.buttonNext;
    }

    override public function get buttonRestart():IViewButtonLabeled
    {
        return super.buttonRestart;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewPopupWin(controller:IControllerPopup)
    {
        super(controller);

        init();
    }

    private function init():void
    {
        _source = source as DisplayObjectContainer;

        _star0 = new ViewPopupWinStar(controller);
        _star0.source.rotation = -20;
        _source.addChild(_star0.source);

        _star1 = new ViewPopupWinStar(controller);
        _source.addChild(_star1.source);

        _star2 = new ViewPopupWinStar(controller);
        _star2.source.rotation = 20;
        _source.addChild(_star2.source);

//        GameInfo.instance.managerGame.currentLevel.progress.isStar1Received
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        _star0.source.x = 85;
        _star0.source.y = 102;

        _star1.source.x = _star0.source.x + 134;
        _star1.source.y = _star0.source.y - 44;

        _star2.source.x = _star1.source.x + 139;
        _star2.source.y = _star1.source.y + 13;

        super.placeViews(fullscreen);
    }


    override public function show(duration:Number = 0, onComplete:Function = null):void
    {
        Utils.performAfterDelay(1000,_star0.playAnimation);

        super.show(duration, onComplete);
    }

    override public function cleanup():void
    {
        _star0.cleanup();
        _star0 = null;

        _star1.cleanup();
        _star1 = null;

        _star2.cleanup();
        _star2 = null;

        _source = null;

        super.cleanup();
    }
}
}
