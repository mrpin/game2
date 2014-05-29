/**
 * Created by evgenyyurko on 1/29/14.
 */
package effects
{
import com.greensock.TweenMax;
import com.greensock.easing.Circ;
import com.greensock.easing.Strong;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.filters.GlowFilter;




public class PixelExplosionEffect
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function PixelExplosionEffect()
    {


        init();
    }

    private function init(sprite:DisplayObjectContainer):void
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var mcLogo:DisplayObjectContainer = sprite;

        var pixelContainer:MovieClip = new MovieClip();
        var glow:GlowFilter = new GlowFilter(0xFFFF00, 1, 10, 10, 5, 2);
        var animating:Boolean = false;
        var pixelBMP:BitmapData = new BitmapData(sprite.width, sprite.height);
        pixelBMP.draw(sprite);

        var i:int = 0;
        var j:int = 0;

        var xArray:Array = new Array();
        var yArray:Array = new Array();


        sprite.addChild(pixelContainer);
        pixelContainer.x = mcLogo.x;
        pixelContainer.y = mcLogo.y;

        pixelBMP = new BitmapData(mcLogo.width, mcLogo.height, true, 0x000000);
        pixelBMP.draw(mcLogo);

        for (i = 0; i < mcLogo.height; i += 2)
        {
            for (j = 0; j < mcLogo.width; j += 2)
            {
                if (pixelBMP.getPixel(j, i) > 0)
                {
                    glow.color = pixelBMP.getPixel(j, i);
                    var pixel_mc:myPixel = new myPixel();
                    pixel_mc.setUpPixel(new BitmapData(2, 2, false, pixelBMP.getPixel(j, i)), glow);
                    pixel_mc.y = i;
                    pixel_mc.x = j;
                    xArray.push(j);
                    yArray.push(i);

                    pixelContainer.addChild(pixel_mc);
                    pixelContainer.visible = false;

                }
            }
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        super.cleanup();
    }


    stage.align = StageAlign.TOP_LEFT;
    stage.scaleMode = StageScaleMode.NO_SCALE;

    var pixelContainer:MovieClip = new MovieClip();
    var glow:GlowFilter = new GlowFilter(0xFFFF00, 1, 10, 10, 5, 2);
    var animating:Boolean = false;
    var pixelBMP:BitmapData;

    var i:int = 0;
    var j:int = 0;

    var xArray:Array = new Array();
    var yArray:Array = new Array();


    addChild(pixelContainer)
    pixelContainer.x = mcLogo.x;
    pixelContainer.y = mcLogo.y;

    pixelBMP = new BitmapData(mcLogo.width, mcLogo.height, true, 0x000000);
    pixelBMP.draw(mcLogo);

    for (i = 0; i < mcLogo.height; i += 2)
        for (j = 0; j < mcLogo.width; j += 2)
        {
            if (pixelBMP.getPixel(j, i) > 0)
            {
                glow.color = pixelBMP.getPixel(j, i);
                var pixel_mc:myPixel = new myPixel();
                pixel_mc.setUpPixel(new BitmapData(2, 2, false, pixelBMP.getPixel(j, i)), glow);
                pixel_mc.y = i;
                pixel_mc.x = j;
                xArray.push(j);
                yArray.push(i);

                pixelContainer.addChild(pixel_mc);
                pixelContainer.visible = false;

            }
        }
    function initbutton()
    {
        btn_mc.buttonMode = true;
        btn_mc.mouseChildren = false;
        btn_mc.addEventListener(MouseEvent.CLICK, clickHandler);
        function clickHandler(e:MouseEvent)
        {
            if (animating == false)
            {
                explode();
                animating = true;
                btn_mc.gotoAndStop(2);
            }
            else
            {

                implode()
                btn_mc.gotoAndStop(1);
            }
        }
    }

    initbutton();


    function explode()
    {
        pixelContainer.alpha = 1;
        mcLogo.visible = false;
        setChildIndex(mcLogo, numChildren - 1);
        setChildIndex(btn_mc, numChildren - 1);
        pixelContainer.visible = true;

        for (var i:int = 0; i < pixelContainer.numChildren; i++)
        {
            var pixel_mc:myPixel = myPixel(pixelContainer.getChildAt(i));
            pixel_mc.visible = true;
            var xdest:int = Math.random() * (stage.stageWidth + 300) - 300;
            var ydest:int = Math.random() * (stage.stageHeight + 300) - 300;


            TweenMax.to(pixel_mc, 14, {x: xdest, y: ydest, ease: Circ.easeOut});

        }
    }

    function implode()
    {
        for (var i:int = 0; i < pixelContainer.numChildren; i++)
        {
            var pixel_mc:myPixel = myPixel(pixelContainer.getChildAt(i));
            pixelContainer.visible = true;
            TweenMax.to(pixel_mc, 3, {y: yArray[i], x: xArray[i], ease: Strong.easeIn, onComplete: smoothit});
        }
    }

    function smoothit()
    {
        mcLogo.visible = true;
        TweenMax.to(pixelContainer, 1, {alpha: 0, onComplete: function ()
        {
            pixelContainer.visible = false;
            mcLogo.visible = true;
            animating = false;
        }})
    }

}
}
