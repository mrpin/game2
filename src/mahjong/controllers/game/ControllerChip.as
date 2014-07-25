/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import com.greensock.TweenMax;
import com.greensock.easing.Linear;

import controllers.implementations.Controller;

import core.implementations.Debug;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.view.game.ViewChip;

import views.interfaces.IView;

public class ControllerChip extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewChip;

    private var _entry:ChipInfo;

    private var _isGlow:Boolean;

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
        _view = new ViewChip(this);

        _view.handleEvents(true, true);

        super(_view);

        _entry = entry;
        _entry.controller = this;

        init();
    }

    private function init():void
    {
        if (_entry.chipType != EChipType.ETB_EMPTY)
        {
            _view.type = _entry.chipType;
        }
        else
        {
            _view.source.visible = false;
        }
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
                _view.showEffectSelectChip();

                break;
            }
            case EControllerUpdate.ECUT_USER_DESELECT_CHIP:
            {
                _view.hideAllEffects();

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_CANCEL_MOVE:
            {
                _view.playAnimationCancelMove(ConstantsBase.ANIMATION_DURATION * 4);

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            {
                _view.hideAllEffects();

                _view.playAnimationRemoveChip(ConstantsBase.ANIMATION_DURATION * 4);

                break;
            }
            case EControllerUpdate.ECUT_SHOW_CHIPS_DISABLE:
            {
                _view.showEffectNotActiveChip();

                break;
            }
            case EControllerUpdate.ECUT_CHIP_SHOW_COMBINATION:
            {
                GameInfo.instance.managerGame.isOnButtonHint = true;
                _view.showEffectHint(ConstantsBase.ANIMATION_DURATION * 4, false, true);

                break;
            }
            case EControllerUpdate.ECUT_CHIP_AUTO_HINT:
            {
                _view.showEffectHint(ConstantsBase.ANIMATION_DURATION * 4, true);

                break;
            }
            case EControllerUpdate.ECUT_HIDE_CHIPS_DISABLE:
            {
                _view.hideAllEffects();

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_SHUFFLE:
            {
                _view.hideAllEffects();
                _view.type = _entry.chipType;

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }

    }

    private function glowEffect():void
    {
        _isGlow = !_isGlow;

        var valueBlur:uint = _isGlow ? 20 : 0;
        var scale:Number = _isGlow ? 1.03 : 1;

        var time:Number = ConstantsBase.ANIMATION_DURATION * 2;

        var tweenParam:Object =
        {
            glowFilter: {
                color   : 0xFF1414,
                alpha   : 1,
                blurX   : valueBlur,
                blurY   : valueBlur,
                strength: 2
            },
            scaleX    : scale,
            scaleY    : scale,
            ease      : Linear.easeNone,
            onComplete: glowEffect
        };
        TweenMax.to(_view.source, time, tweenParam);
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
