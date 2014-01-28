/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.view.base.ViewSceneBase;

import views.IView;

public class ViewSceneGame extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _viewFieldChips:IView;


    /*
     * Properties
     */
      public function set viewFieldChips(value:IView):void
      {
          _viewFieldChips = value;
          _source.addChild(_viewFieldChips.source);
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

    }


    override public function addSubView(view:IView):void
    {

    }


    override public function placeViews(fullscreen:Boolean):void
    {
        _viewFieldChips.x = 400;
        _viewFieldChips.y = 200;

        _viewFieldChips.placeViews(fullscreen);

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
