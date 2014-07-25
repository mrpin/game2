/**
 * Created by evgenyyurko on 7/14/14.
 */
package mahjong.view.base.skeletonAnimation
{
import controllers.interfaces.IController;

import core.implementations.Debug;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.NativeFactory;
import dragonBones.objects.SkeletonData;
import dragonBones.objects.XMLDataParser;
import dragonBones.textures.NativeTextureAtlas;

import flash.display.Bitmap;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.setTimeout;

import utils.Utils;

import views.implementations.ViewBase;

public class ViewSkeletonAnimation extends ViewBase
{
    /*
     * Field
     */
    private var _source:DisplayObjectContainer;
    private var _armature:Armature;

    private var _animationType:String;


    /*
     * Property
     */
    public function set scale(value:Point):void
    {
        _armature.display.scaleX = value.x;
        _armature.display.scaleY = value.y;
    }

    public function set animationType(value:String):void
    {
        _animationType = value;
    }

    /*
     * Methods
     */

    public function ViewSkeletonAnimation(controller:IController, skeletonXMLData:Class, textureXMLData:Class, textureData:Class)
    {
        _source = new Sprite();
        super(controller, _source);

        init(skeletonXMLData, textureXMLData, textureData);
    }

    private function init(skeletonXMLData:Class, textureXMLData:Class, textureData:Class):void
    {
        var factory:NativeFactory = new NativeFactory();
        factory.fillBitmapSmooth = true;

        //skeletonData
        var skeletonData:SkeletonData = XMLDataParser.parseSkeletonData(XML(new skeletonXMLData));
        var armatureName:String = skeletonData.armatureNames[0];

        factory.addSkeletonData(skeletonData, armatureName);

        var bitmap:Bitmap = new textureData;

        var nativeTextureAtlas:NativeTextureAtlas = new NativeTextureAtlas(bitmap.bitmapData, XML(new textureXMLData));

        factory.addTextureAtlas(nativeTextureAtlas, armatureName + "HD");

        _armature = factory.buildArmature(armatureName, null, armatureName, armatureName + "HD");

        _source.addChild(_armature.display as Sprite);
        WorldClock.clock.add(_armature);

        _source.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
    }

    public function gotoAndPlayRandomDelay(from:int, to:int):void
    {
        setTimeout(function ():void
                {
                    gotoAndPlayRandomDelay(from, to);
                    gotoAndPlay(1);
                },
                Utils.randomFromTo(from, to));
    }

    public function gotoAndPlay(numberOfRepetitions:int = 0):void
    {
        Debug.assert(_animationType != null, "set animationType");

        _armature.animation.gotoAndPlay(_animationType, -1, -1, numberOfRepetitions);
    }

    public function gotoAndStop(time:int = 0):void
    {
        Debug.assert(_animationType != null, "set animationType");

        _armature.animation.gotoAndStop(_animationType, time);
    }

    public function stop():void
    {
        _armature.animation.stop();
    }

    public function play():void
    {
        _armature.animation.play();
    }

    private static function onEnterFrameHandler(_e:Event):void
    {
        WorldClock.clock.advanceTime(-1);
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        WorldClock.clock.clear();

        _armature.dispose();

        _source.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);

        _armature = null;

        _source = null;

        super.cleanup();
    }
}
}
