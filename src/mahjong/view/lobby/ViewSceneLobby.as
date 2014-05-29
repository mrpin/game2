/**
 * Created by evgenyyurko on 5/20/14.
 */
package mahjong.view.lobby
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.geom.Point;

import mahjong.view.base.ViewSceneBase;

import views.interfaces.EViewPosition;
import views.interfaces.IView;
import views.interfaces.buttons.IViewButtonLabeled;

public class ViewSceneLobby extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewTimerBonus:IView;

    private var _buttonTimeBonus:IViewButtonLabeled;

    private var _progress:IView;


    /*
     * Properties
     */
    public function set timeBonusView(value:IView):void
    {
        if (value == _viewTimerBonus)
        {
            return;
        }

        _viewTimerBonus = value;
        _viewTimerBonus.position = EViewPosition.EVP_ABSOLUTE;
        _viewTimerBonus.anchorPoint = new Point(1, 1);
        _source.addChild(_viewTimerBonus.source);
    }

    public function set progress(value:IView):void
    {
        _progress = value;
        _progress.position = EViewPosition.EVP_ABSOLUTE;
        _progress.anchorPoint = new Point(0, 1);
        _source.addChild(_progress.source);
    }


    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewSceneLobby(controller:IController, source:DisplayObjectContainer)
    {
        _source = source;
        super(controller, _source);

        init();
    }

    private function init():void
    {

    }

    override public function placeViews(fullscreen:Boolean):void
    {
        _viewTimerBonus.translate(1, 1);
        _viewTimerBonus.source.x += -120;
        _viewTimerBonus.source.y += -27;

        _progress.translate(0, 1);
        _progress.source.x += 7;
        _progress.source.y += -1;
        _progress.placeViews(fullscreen);

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        super.cleanup();
    }


}
}
