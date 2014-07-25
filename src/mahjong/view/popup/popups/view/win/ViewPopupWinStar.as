/**
 * Created by evgenyyurko on 7/23/14.
 */
package mahjong.view.popup.popups.view.win
{
import com.greensock.TweenMax;

import controllers.interfaces.IController;

import flash.utils.setTimeout;

import views.implementations.ViewBase;
//TODO:доделать звезды
public class ViewPopupWinStar extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gStar0;

    private var _tweenParam:Object;

    /*
     * Properties
     */

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewPopupWinStar(controller:IController)
    {
        _source = new gStar0();

        super(controller, _source);

        init();
    }

    private function init():void
    {
        _source.viewStarActive.gotoAndStop(1);
        _source.viewStarActive.visible = false;
    }

    public function playAnimation():void
    {
        _source.viewStarActive.visible = true;
        _source.viewStarActive.gotoAndStop(1);

        var time:int = ConstantsBase.ANIMATION_DURATION * 4;

        _tweenParam =
        {
            frame: _source.viewStarActive.totalFrames
        };

        TweenMax.to(_source.viewStarActive, time, _tweenParam);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        TweenMax.killTweensOf(_source.viewStarActive, false, _tweenParam);

        super.cleanup();
    }


}
}
