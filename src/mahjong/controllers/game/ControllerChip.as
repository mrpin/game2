/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdateType;
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

        _view.handleEvents(true);

        super(_view);

        _entry = entry;

        init();
    }

    private function init():void
    {

    }


    override public function onViewClicked(view:IView, e:MouseEvent):Boolean
    {
        if (entry.isEnabled)
        {
            GameInfo.instance.managerGame.verificationCoincidenceChips(this);
        }


        return super.onViewClicked(view, e);
    }

    override public function update(type:String):void
    {
        var chipFirstSelected:ControllerChip = GameInfo.instance.managerGame.chipFirstSelected;
        var chipSecondSelected:ControllerChip = GameInfo.instance.managerGame.chipSecondSelected;

        switch (type)
        {
            case EControllerUpdateType.ECUT_USER_SELECT_CHIP:
            {
                if (this == chipFirstSelected)
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
                    var glow:GlowFilter = new GlowFilter(00000000, 0.3, 70, 70, 50, 1, true);
                    _view.filter = [glow];
                }

                break;
            }
            case EControllerUpdateType.ECUT_USER_DESELECT_CHIP:
            {

                if (this == chipFirstSelected)
                {
                    _view.filter = [];
                }

                break;
            }
            case EControllerUpdateType.ECUT_CHIPS_REMOVE:
            {

                if (chipFirstSelected == this || chipSecondSelected == this)
                {
                    _view.source.visible = false;
                }

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
        super.cleanup();
    }


}
}
