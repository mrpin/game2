/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import com.greensock.TweenLite;

import controllers.implementations.Controller;

import effects.PixelExplosion;

import flash.display.DisplayObjectContainer;

import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.view.game.ViewChip;

import views.IView;

public class ControllerChip extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewChip;

    private var _entry:ChipInfo;

    /*
     * Properties
     */


    public function get entry():ChipInfo
    {
        return _entry;
    }

    public function get typeChip():int
    {
        return _entry["chipType"];
    }


    /*
     * Methods
     */
    public function ControllerChip(entry:ChipInfo)
    {
        _view = new ViewChip(this, entry);

        _view.chipView.handleEvents(true);

        super(_view);

        _entry = entry;
        _entry.controller = this;

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        if (entry.isEnabled)
        {
            GameInfo.instance.managerGame.checkCoincidenceChips(_entry);
        }

        return super.onViewClicked(view, e);
    }

    override public function update(type:String):void
    {
        switch (type)
        {
            case EControllerUpdate.ECUT_USER_SELECT_CHIP:
            {
                /*
                 color:uint=0xFF0000 – цвет свечения, по умолчанию красный
                 alpha:Number=1 – прозрачность, по умолчанию не прозрачное свечение
                 blurX:Number=6 – размытие по X, значение по умолчанию 6
                 blurY:Number=6 – размытие по Y, значение по умолчанию 6
                 strength:Number=2 – степень вдавливания. Может принимать значения от 0 до 255. Чем выше значение, тем сильнее контраст тени фильтра.
                 quality:int=1 – сколько раз применить фильтр. Может принимать значения от 1 до 3.
                 inner:Boolean=false – если задать значение true, то свечение направляется внутрь объекта
                 knockout:Boolean=false – если задать значение true, то визуальный объект становится не видимым, видно только само свечение.
                 */

//                       _view.viewFace.filter = [];

//                var glow:GlowFilter = new GlowFilter(0x000000, 0.3, 70, 70, 50, 1, true);
                    var glow:GlowFilter = new GlowFilter(0xff0000 , 1, 6, 6, 100, 1, true);


                _view.filter = [glow];
//                _view.chipFace.filters = [glow];

                break;
            }
            case EControllerUpdate.ECUT_USER_DESELECT_CHIP:
            {
                _view.filter = [];
//                _view.chipFace.filters = [];

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            {
                _view.source.visible = false;

//                var pixelExplosion:PixelExplosion = new PixelExplosion(20, _view.source as DisplayObjectContainer, 2, 0.1, 0, 4, 0.5, 0.5, 1, 2);
//                _view.visibleSubViews(false);


                break;
            }
            case EControllerUpdate.ECUT_SHOW_CHIPS_DISABLE:
            {
                var glowColor:GlowFilter = new GlowFilter(0x000000, 0.8, 70, 70, 50, 1, true);

                _view.filter = _entry.isEnabled ? [] : [glowColor];

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }

    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _view = null;

        super.cleanup();
    }


}
}
