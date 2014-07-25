/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.view.main
{
import controllers.interfaces.IController;

import flash.display.MovieClip;
import flash.geom.Matrix;
import flash.geom.Point;

import mahjong.view.base.skeletonAnimation.ViewSkeletonAnimation;
import mahjong.view.enums.EAnimationType;

import views.implementations.buttons.ViewButton;

public class ViewMainItem extends ViewButton
{
    /*
     * Static
     */

    /*
     * Constants
     */
    [Embed(source="../../../../assets/panda/skeleton.xml", mimeType="application/octet-stream")]
    private static const PandaSkeletonXMLData:Class;

    [Embed(source="../../../../assets/panda/texture.xml", mimeType="application/octet-stream")]
    private static const PandaTextureHDXMLData:Class;

    [Embed(source="../../../../assets/panda/texture.png")]
    private static const PandaTextureHDData:Class;


    /*
     * Fields
     */
    private var _source:gSceneMainItem;

    private var _size:Point;

    private var _pandaSkeletonAnimation:ViewSkeletonAnimation;

    private var _themesView:Array;



    /*
     * Properties
     */
    public function set nameLevelContainer(value:String):void
    {
        _source.labelLevel.text = value;
    }

    public function set textCountStar(value:String):void
    {
        _source.viewItemPoints.labelPoints.text = value;
    }

    public function isOpen(value:Boolean, animationType:String, level:int):void
    {
        var theme:MovieClip = _themesView[(level - 1) % 1];

        _pandaSkeletonAnimation.animationType = animationType;

        if (value)
        {
            _source.addChildAt(_pandaSkeletonAnimation.source, _source.numChildren - 1);

            _pandaSkeletonAnimation.gotoAndPlay();

            theme.gotoAndPlay(1);
            theme.visible = value;
        }
        else
        {
            _source.addChildAt(_source.viewFence, _source.numChildren - 1);
            _source.addChildAt( _source.viewLock, _source.numChildren - 1);

            _pandaSkeletonAnimation.gotoAndStop();
        }
        _source.viewLock.visible = !value;

        this.enabled = value;
    }

    public function get size():Point
    {
        return _size;
    }

    /*
     * Methods
     */
    public function ViewMainItem(controller:IController)
    {
        _source = new gSceneMainItem();
        super(controller, _source);

        this.handleEvents(true, false, false, false, false, true, true);

        init();
    }

    private function init():void
    {
        _themesView = [_source.viewFishing, _source.viewTea];

        for each (var movieClip:MovieClip in _themesView)
        {
            movieClip.gotoAndStop(1);
            movieClip.visible = false;
        }

        _size = new Point(_source.width, _source.height);

        _pandaSkeletonAnimation = new ViewSkeletonAnimation(controller, PandaSkeletonXMLData, PandaTextureHDXMLData, PandaTextureHDData);
        _pandaSkeletonAnimation.scale = new Point(0.7, 0.7);
        _source.addChild(_pandaSkeletonAnimation.source);
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        _pandaSkeletonAnimation.source.x = 20;

        super.placeViews(fullscreen);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _pandaSkeletonAnimation.cleanup();
        _pandaSkeletonAnimation = null;

        for each (var animation:MovieClip in _themesView)
        {
            animation.stop();
        }
        _themesView = null;

        _source = null;

        super.cleanup();
    }
}
}
