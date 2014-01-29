/**
 * Created by evgenyyurko on 1/28/14.
 */
//TODO: http://demiart.ru/forum/index.php?showtopic=114289

//package
//{
//import flash.display.Bitmap;
//import flash.display.BitmapData;
//import flash.display.Shape;
//import flash.display.Sprite;
//import flash.events.Event;
//import flash.events.MouseEvent;
//
//public class PixelExplosion extends Sprite
//{
//    private var _overAlpha:Number;  //Прозрачность при курсоре на изображении
//    private var _outAlpha:Number;  //Прозрачность при курсоре вне изображения
//    private var _V:Number;    //Скорость полета частиц
//    private var _K:Number;    //Параметр, отвечающий за случайный полет частиц
//    private var _xA:Number;    //Ускорение по x (pixel/sec)
//    private var _yA:Number;    //Ускорение по y (pixel/sec)
//    private var _minPixelLife:Number;	//Минимальное время жизни частиц (sec)
//    private var _maxPixelLife:Number;	//Максимальное время жизни частиц (sec)
//
//    private var _img:BitmapData;    	// Изображение BitmapData
//    private var _imgBmp:Bitmap;    	// Изображение Bitmap
//    private var _imgMc:Sprite = new Sprite();	// Спрайт, в который помещаем Bitmap
//
//    private var _w:uint;  //
//    private var _h:uint;  //
//
//    private var _pixel:Array;  // Массив пикселей
//    private var _pixelAlpha:Array;	// Массив, скорость изменения прозрачности для каждого пикселя
//    private var _xSpeed:Array;  // Массив, скорость по x для каждого пикселя
//    private var _ySpeed:Array;  // Массив, скорость по y для каждого пикселя
//
//    private var _deadPixel:uint;  // Количество пропавших пикселей после взрыва
//    private var _pixelsCount:uint;	// Количество всех пикселей
//
//    public function PixelExplosion(rate:uint, imgClass:BitmapData, V:Number = 8, K:Number = 0.1, xA:Number = 0, yA:Number = 4, minPixelLife:Number = 1.5, maxPixelLife:Number = 3, overAlpha:Number = 1.0, outAlpha:Number = 0.8)
//    {
//
//        // Пересчитываем для данной частоты кадров и сохранаяем передаваемые параметры в параметры класса
//        this._overAlpha = overAlpha;
//        this._outAlpha = outAlpha;
//        this._V = V / rate;
//        this._K = K;
//        this._xA = xA / rate;
//        this._yA = yA / rate;
//        this._minPixelLife = 1 / (minPixelLife * rate);
//        this._maxPixelLife = 1 / (maxPixelLife * rate);
//
//        // Создаем картинку
//        _img = imgClass;
//        _imgBmp = new Bitmap(_img);
//        _imgMc.addChild(_imgBmp);
//
//        // Заносим ширину м высоту картинки в переменные
//        _w = _img.width;
//        _h = _img.height;
//
//        // Считаем общее количество пикселей
//        _pixelsCount = _w * _h;
//
//        // Создаем 4 двумерных массива
//        _pixel = formArray(_w, _h);
//        _pixelAlpha = formArray(_w, _h);
//        _xSpeed = formArray(_w, _h);
//        _ySpeed = formArray(_w, _h);
//
//        // Создаем массив с пикселями, но не отображаем их на экране
//        createPixelArray();
//
//        // Задаем картинке прозрачность
//        _imgMc.alpha = outAlpha;
//
//        // Добавляем на сцену картинку
//        addChild(_imgMc);
//
//        _imgMc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
//        _imgMc.addEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
//        _imgMc.addEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
//    }
//
//    // Изменение прозрачности при наведении курсора с изображения
//    private function mouseOverListener(e:MouseEvent):void
//    {
//        _imgMc.alpha = _overAlpha;
//    }
//
//    // Изменение прозрачности при удалении курсора с изображения
//    private function mouseOutListener(e:MouseEvent):void
//    {
//        _imgMc.alpha = _outAlpha;
//    }
//
//    // Функция для формирования двумерного массива
//    private static function formArray(n:uint, m:uint):Array
//    {
//        var array:Array = new Array(n);
//        for (var i:uint = 0; i < n; i++)
//        {
//            array[i] = new Array(m);
//        }
//        return array;
//    }
//
//    // Создание массива с пикселей
//    // Каждый пиксель в массиве - это Shape с нарисовынным в нем квадрате 1 x 1px
//    private function createPixelArray():void
//    {
//        var alphaValue:uint;
//        for (var i:uint = 0; i < _w; i++)
//        {
//            for (var j:uint = 0; j < _h; j++)
//            {
//                alphaValue = _img.getPixel32(i, j) >> 24 & 0xFF;
//                _pixel[i][j] = new Shape();
//                var shape:Shape = _pixel[i][j];
//                if (alphaValue != 0)
//                {
//                    shape.alpha = alphaValue / 255;
//                    shape.graphics.lineStyle(0, 0, 0);
//                    shape.graphics.beginFill(_img.getPixel(i, j));
//                    shape.graphics.drawRect(0, 0, 1, 1);
//                    shape.graphics.endFill();
//                    shape.x = i;
//                    shape.y = j;
//                }
//            }
//        }
//    }
//
//    private function mouseDownListener(e:MouseEvent):void
//    {
//        setSpeed(e);
//        setAlpha();
//        showPixelArray();
//        deleteImage();
//        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
//    }
//
//    private function showPixelArray():void
//    {
//        for (var i:uint = 0; i < _w; i++)
//        {
//            for (var j:uint = 0; j < _h; j++)
//            {
//                addChild(_pixel[i][j]);
//            }
//        }
//    }
//
//    private function setSpeed(e:MouseEvent):void
//    {
//        for (var i:uint = 0; i < _w; i++)
//        {
//            for (var j:uint = 0; j < _h; j++)
//            {
//                _xSpeed[i][j] = _K * (0.5 - Math.random()) + _V * (i - e.localX) * (Math.random());
//                _ySpeed[i][j] = _K * (0.5 - Math.random()) + _V * (j - e.localY) * (Math.random());
//            }
//        }
//    }
//
//    private function setAlpha():void
//    {
//        for (var i:uint = 0; i < _w; i++)
//        {
//            for (var j:uint = 0; j < _h; j++)
//            {
//                _pixelAlpha[i][j] = _minPixelLife + (_maxPixelLife - _minPixelLife) * Math.random();
//            }
//        }
//    }
//
//    private function enterFrameHandler(e:Event):void
//    {
//        for (var i:uint = 0; i < _w; i++)
//        {
//            for (var j:uint = 0; j < _h; j++)
//            {
//                if (_pixel[i][j] != null)
//                {
//                    _pixel[i][j].x += _xSpeed[i][j] + _xA / 2;
//                    _xSpeed[i][j] += _xA;
//                    _pixel[i][j].y += _ySpeed[i][j] + _yA / 2;
//                    _ySpeed[i][j] += _yA;
//                    _pixel[i][j].alpha -= _pixelAlpha[i][j];
//                    if (_pixel[i][j].alpha <= 0)
//                    {
//                        removeChild(_pixel[i][j]);
//                        _pixel[i][j] = new Shape();
//                        _pixel[i][j] = null;
//                        _deadPixel++;
//                    }
//                }
//            }
//        }
//        if (_deadPixel == _pixelsCount)
//        {
//            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
//            dispatchEvent(new DeleteEvent(DeleteEvent.DELETE,
//                    true,
//                    false));
//            deactivate();
//        }
//    }
//
//    private function deleteImage():void
//    {
//        _imgMc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
//        _imgMc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
//        _imgMc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
//        _imgMc.removeChild(_imgBmp);
//        removeChild(_imgMc);
//        _img = null;
//        _imgBmp = null;
//        _imgMc = null;
//    }
//
//    public function deactivate():void
//    {
//        _pixel = null;
//        _pixelAlpha = null;
//        _xSpeed = null;
//        _ySpeed = null;
//    }
//}
//}


package effects
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

public class PixelExplosion extends Sprite
{
    private var _outAlpha:Number;  //Прозрачность при курсоре вне изображения
    private var _V:Number;    //Скорость полета частиц
    private var _K:Number;    //Параметр, отвечающий за случайный полет частиц
    private var _xA:Number;    //Ускорение по x (pixel/sec)
    private var _yA:Number;    //Ускорение по y (pixel/sec)
    private var _minPixelLife:Number;	//Минимальное время жизни частиц (sec)
    private var _maxPixelLife:Number;	//Максимальное время жизни частиц (sec)

    private var _img:BitmapData;    	// Изображение BitmapData
//    private var _imgBmp:Bitmap;    	// Изображение Bitmap
    private var _sprite:DisplayObjectContainer;	// Спрайт, в который помещаем Bitmap

    private var _w:uint;  //
    private var _h:uint;  //

    private var _pixel:Array;  // Массив пикселей
    private var _pixelAlpha:Array;	// Массив, скорость изменения прозрачности для каждого пикселя
    private var _xSpeed:Array;  // Массив, скорость по x для каждого пикселя
    private var _ySpeed:Array;  // Массив, скорость по y для каждого пикселя

    private var _deadPixel:uint;  // Количество пропавших пикселей после взрыва
    private var _pixelsAllCount:uint;	// Количество всех пикселей

    private var _pixelsCount:uint;

    public function PixelExplosion(rate:uint, sprite:DisplayObjectContainer, V:Number = 8, K:Number = 0.1, xA:Number = 0, yA:Number = 4, minPixelLife:Number = 1.5, maxPixelLife:Number = 3, outAlpha:Number = 0.8, pixelsCount:uint = 1)
    {

        // Пересчитываем для данной частоты кадров и сохранаяем передаваемые параметры в параметры класса
        _pixelsCount = pixelsCount > 0 ? pixelsCount : 1;

        this._outAlpha = outAlpha;

        this._V = V / rate;
        this._K = K;
        this._xA = xA / rate;
        this._yA = yA / rate;
        this._minPixelLife = 1 / (minPixelLife * rate);
        this._maxPixelLife = 1 / (maxPixelLife * rate);


        // Создаем картинку
        _sprite = sprite;

        _w = _sprite.width - 10;
        _h = _sprite.height - 10;

        _img = new BitmapData(_w, _h);
        _img.draw(_sprite);


        // Считаем общее количество пикселей
        _pixelsAllCount = _w * _h;

        // Создаем 4 двумерных массива
        _pixel = formArray(_w, _h);
        _pixelAlpha = formArray(_w, _h);
        _xSpeed = formArray(_w, _h);
        _ySpeed = formArray(_w, _h);

        // Создаем массив с пикселями, но не отображаем их на экране
        createPixelArray();

        // Задаем картинке прозрачность
        _sprite.alpha = outAlpha;

//        _sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
        mouseDownListener();
    }

    // Функция создания двумерного массива
    private function formArray(n:uint, m:uint):Array
    {
        var array:Array = new Array(n);
        for (var i:uint = 0; i < n; i += _pixelsCount)
        {
            array[i] = new Array(m);
        }
        return array;
    }

    // Создание массива пикселей
    private function createPixelArray():void
    {
        var alphaValue:uint;
        for (var i:uint = 0; i < _w; i += _pixelsCount)
        {
            for (var j:uint = 0; j < _h; j += _pixelsCount)
            {
                alphaValue = _img.getPixel32(i, j) >> 24 & 0xFF;
                _pixel[i][j] = new Shape();
                var shape:Shape = _pixel[i][j];
                if (alphaValue != 0)
                {
                    shape.alpha = alphaValue / 255;
                    shape.graphics.lineStyle(0, 0, 0);
                    shape.graphics.beginFill(_img.getPixel(i, j));
                    shape.graphics.drawRect(0, 0, 1, 1);
                    shape.graphics.endFill();
                    shape.x = i;
                    shape.y = j;
                }
            }
        }
    }

    // Функция, вызываемая при клике на изобрадение
//    public function mouseDownListener(e:MouseEvent):void
    public function mouseDownListener():void
    {
        // Расчет скорости каждой частицы
        setSpeed();

        // Расчет скорости уменьшения прозрачности для каждой частицы
        setAlpha();

        // Отображение всех пикселей
        showPixelArray();

        // Удаление картинки и ссылок на нее
//        deleteImage();

        // Обработчик события, который вызывается каждый раз, когда происходит обновление кадра
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    private function showPixelArray():void
    {
        for (var i:uint = 0; i < _w; i += _pixelsCount)
        {
            for (var j:uint = 0; j < _h; j += _pixelsCount)
            {
                _sprite.addChild(_pixel[i][j]);
            }
        }
    }

//    private function setSpeed(e:MouseEvent):void
    private function setSpeed():void
    {
        for (var i:uint = 0; i < _w; i += _pixelsCount)
        {
            for (var j:uint = 0; j < _h; j += _pixelsCount)
            {
                _xSpeed[i][j] = _K * (0.5 - Math.random()) + _V * (i - 37 /*e.localX*/) * (Math.random());
                _ySpeed[i][j] = _K * (0.5 - Math.random()) + _V * (j - 49 /*e.localY*/) * (Math.random());
            }
        }
    }

    private function setAlpha():void
    {
        for (var i:uint = 0; i < _w; i += _pixelsCount)
        {
            for (var j:uint = 0; j < _h; j += _pixelsCount)
            {
                _pixelAlpha[i][j] = _minPixelLife + (_maxPixelLife - _minPixelLife) * Math.random();
            }
        }
    }

    private function enterFrameHandler(e:Event):void
    {
        for (var i:uint = 0; i < _w; i += _pixelsCount)
        {
            for (var j:uint = 0; j < _h; j += _pixelsCount)
            {
                if (_pixel[i][j] != null)
                {
                    _pixel[i][j].x += _xSpeed[i][j] + _xA / 2;
                    _xSpeed[i][j] += _xA;
                    _pixel[i][j].y += _ySpeed[i][j] + _yA / 2;
                    _ySpeed[i][j] += _yA;
                    _pixel[i][j].alpha -= _pixelAlpha[i][j];
                    if (_pixel[i][j].alpha <= 0)
                    {
                        _sprite.removeChild(_pixel[i][j]);
                        _pixel[i][j] = new Shape();
                        _pixel[i][j] = null;
                        _deadPixel++;
                    }
                }
            }
        }
        if (_deadPixel == _pixelsAllCount)
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            deactivate();
        }
    }

    private function deleteImage():void
    {
//        _sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
//        _sprite.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
//        _sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
        _sprite.visible = false;
        _img = null;
        _sprite = null;
    }

    // Обнуление значений при исчезновении всех частиц после взрыва.
    public function deactivate():void
    {
        _sprite.visible = false;
        _pixel = null;
        _pixelAlpha = null;
        _xSpeed = null;
        _ySpeed = null;
    }
}
}
