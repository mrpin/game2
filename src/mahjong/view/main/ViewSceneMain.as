/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.main
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.view.base.ViewSceneBase;

import views.IView;
import views.IViewButton;

public class ViewSceneMain extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    private var _items:Array;


    /*
     * Properties
     */
    public function set items(array:Array):void
    {
        _items = array;
        for each(var itemsArray:Array in _items)
        {
            for each(var item:IView in itemsArray)
            {
                _source.addChild(item.source);
            }
        }
    }

    /*
     * Methods
     */
    public function ViewSceneMain(controller:IController)
    {
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        super.buttonBack.source.visible = false;

        _items = [];
    }

    override public function addSubView(view:IView):void
    {
        _source.addChild(view.source);
        _items.push(view);
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);

        var startPositionX:int = 200;
        var startPositionY:int = 350;

        for each(var itemsArray:Array in _items)
        {
            var positionX:int = startPositionX;

            for each(var item:IView in itemsArray)
            {
                item.x = positionX;
                item.y = startPositionY;

                positionX += 300;
            }
            startPositionY += 250;
        }
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
