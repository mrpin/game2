/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.Bitmap;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Static
     */


    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;//gChip;

    private var _chip:gChip;

    private var _viewAnimation:gChipAnimations;

    private var _isEmpty:Boolean;


    /*
     * Properties
     */
    public function set filter(value:Array):void
    {
        _source.filters = value;
    }

    public function set type(value:int):void
    {
        _chip.viewArt.gotoAndStop(value + 1);
    }

    public function set chipVisible(value:Boolean):void
    {
        _chip.visible = value;
    }


    /*
     * Methods
     */
    public function ViewChip(controller:IController)
    {
        _source = new Sprite();//gChip();


        super(controller, _source);

        init();
    }

    private function init():void
    {
        _chip = new gChip();
        _source.addChild(_chip);

        _viewAnimation = new gChipAnimations();
        _source.addChild(_viewAnimation);
        _viewAnimation.gotoAndStop(1);
        _viewAnimation.visible = false;
    }

    /*
     * IDisposable
     */

    public function addChild(value:Sprite):void
    {
        _source.addChild(value);
    }

    public function addChildBitmap(value:Bitmap):void
    {
        _source.addChild(value);
    }

    public function goAnimation():void
    {
       _viewAnimation.visible = true;
       _viewAnimation.play();
    }

    override public function placeViews(fullscreen:Boolean):void
    {

    }

    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
