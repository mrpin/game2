/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

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
                    _view.source.alpha = 0.5;
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
            case EControllerUpdateType.ECUT_USER_DESELECT_CHIP:
            {

                if (this == chipFirstSelected)
                {
                    _view.source.alpha = 1;
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
