package
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;

/**
 *    Main Class
 *    @ purpose:            Exploding Things
 */

public class ExplodeDisolve extends Sprite
{
    private var _w:Number;
    private var _h:Number;
    private var _bitmap:Bitmap;
    private var _holder:Sprite = new Sprite();
    private var _holderSource:Sprite = new Sprite();
    private var _partsH:Number;
    private var _partsW:Number;
    private var _deviseBy:Number;
    private var _drawableObject:BitmapData;
    private var _explodeableObject:Sprite;
    private var _particleArray:Array = [];
    private var _motionArrayY:Array = [];
    private var _motionArrayX:Array = [];
    private var _motionArrayALPHA:Array = [];
    private var _motionArrayAngle:Array = [];
    private var _bitmapDataArray:Array = [];
    private var _multiplier:Number = -1;
    private var _friction:Number = .9;

    public static const ON_EXPLODE:String = "on_explode";
    public static const ON_END:String = "on_end";
    private var _rotationArray:Array = [];
    private var vx:Number = 0;
    private var vy:Number = 0;

    /*public function ExplodeDisolve()
     {
     trace("----------------- EXPLODING EFFECT INITIATED ----------------");
     }*/

    public function ExplodeDisolve(explodeableObject:Sprite, deviseBy:Number = 15)
    {
        _deviseBy = deviseBy;
        _explodeableObject = explodeableObject;
        _w = _explodeableObject.width;
        _h = _explodeableObject.height;
        _explodeableObject.visible = false;
        _drawableObject = new BitmapData(_w, _h, true, 0x000000);
        _drawableObject.draw(this._explodeableObject);
        _bitmap = new Bitmap(_drawableObject);
        _partsH = _h / _deviseBy;
        _partsW = _w / _deviseBy;
        _holderSource.addChild(_bitmap);
        _holder.x = _holderSource.x = _explodeableObject.x;
        _holder.y = _holderSource.y = _explodeableObject.y;
        //addChild(_holderSource);
        buildImage();
        addChild(_holder);
        //_holderSource.addEventListener(MouseEvent.CLICK, startAnimating);
        addEventListener(Event.ENTER_FRAME, animateMe);
    }

    private function buildImage():void
    {
        for (var i:uint = 0; i < _partsW; i++)
        {
            for (var j:uint = 0; j < _partsH; j++)
            {
                var tempBitmapData:BitmapData = new BitmapData(_w / _partsW, _h / _partsH, false, 0x000000);
                var m:Matrix = new Matrix(1, 0, 0, 1, -(i * _w / _partsW), -(j * _h / _partsH));
                tempBitmapData.draw(_drawableObject, m);
                var tempBitmap:Bitmap = new Bitmap(tempBitmapData);
                tempBitmap.x = i * _w / _partsW;
                tempBitmap.y = j * _h / _partsH;
                tempBitmap.cacheAsBitmap = true;
                _particleArray.push(tempBitmap);
                _bitmapDataArray.push(tempBitmapData);
                _motionArrayY.push(Math.sin(Math.random() * 360) * Math.random() * 10 + 3);
                _motionArrayX.push(Math.cos(Math.random() * 360) * Math.random() * 10 + 3);
                _rotationArray.push(Math.random() * 360);
                _motionArrayALPHA.push((Math.round(Math.random() * 100)) / 1000 + .01);
                _holder.addChild(tempBitmap);
            }
        }
    }

    private function startAnimating(e:MouseEvent):void
    {
        addChild(_holder);
        removeChild(_holderSource);
        addEventListener(Event.ENTER_FRAME, animateMe);
        dispatchEvent(new Event(ExplodeDisolve.ON_EXPLODE));
    }

    private function animateMe(e:Event):void
    {
        if (_particleArray.length > 0)
        {
            for (var n:uint = 0; n < _particleArray.length; n++)
            {
                /*_motionArrayY[n] *= _friction;
                 _motionArrayX[n] *= _friction;
                 _particleArray[n].x += _motionArrayY[n];
                 _particleArray[n].y += _motionArrayX[n];
                 _particleArray[n].scaleX = _particleArray[n].scaleY = _particleArray[n].scaleX+_motionArrayALPHA[n]*-1;
                 _particleArray[n].alpha -= _motionArrayALPHA[n];
                 * 
                 */
                var angle:Number = _rotationArray[n] * Math.PI / 180;
                var ax:Number = Math.cos(angle) * 2;
                var ay:Number = Math.sin(angle) * 2;


                vx = Math.cos(angle) * 4;
                vy = Math.sin(angle) * 4;


                _particleArray[n].x += vx;
                _particleArray[n].y += vy;
                _particleArray[n].scaleX += vx / 50;
                _particleArray[n].scaleY += vy / 50;

                _particleArray[n].alpha -= _motionArrayALPHA[n] * .8;

                if (_particleArray[n].alpha <= 0)
                {
                    _holder.removeChild(_particleArray[n]);
                    this._bitmapDataArray[n].dispose();
                    _particleArray.splice(n, 1);
                    _rotationArray.splice(n, 1);
                    _bitmapDataArray.splice(n, 1);
                    _motionArrayY.splice(n, 1);
                    _motionArrayX.splice(n, 1);
                }
            }
        } else
        {
            removeEventListener(Event.ENTER_FRAME, animateMe);
            cleanUp();
            dispatchEvent(new Event(ExplodeDisolve.ON_END));
        }
    }

    private function cleanUp():void
    {
        _holderSource.removeChild(_bitmap);
        removeChild(_holder);
        _drawableObject.dispose();
        _bitmap = null;
    }
}
}  