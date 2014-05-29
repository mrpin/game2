/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import core.implementations.Debug;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;
import mahjong.view.game.ViewFieldChips;

public class ControllerFieldChips extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewFieldChips;

    private var _chips:Array;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerFieldChips()
    {
        _view = new ViewFieldChips(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _chips = [];

        var gridChips:Array = GameInfo.instance.managerGame.grid;

        var chipsViews:Array = [];

        for each(var cellZ:Array in gridChips)
        {
            var chipsZ:Array = [];
            var chipsViewZ:Array = [];

            for each(var cellY:Array in cellZ)
            {
                var chipsY:Array = [];
                var chipsViewY:Array = [];

                for each(var chipEntry:ChipInfo in cellY)
                {
                    var chip:ControllerChip = new ControllerChip(chipEntry);

                    chipsY.push(chip);
                    chipsViewY.push(chip.view);
                }
                chipsZ.push(chipsY);
                chipsViewZ.push(chipsViewY);
            }
            _chips.push(chipsZ);
            chipsViews.push(chipsViewZ);
        }

        _view.viewsChips = chipsViews;

    }

    override public function update(type:String):void
    {
        switch (type)
        {
            case EControllerUpdate.ECUT_CHIPS_REMOVE:
            {
                for each(var chipsZ:Array in _chips)
                {
                    for each(var chipsY:Array in chipsZ)
                    {
                        for each(var chip:ControllerChip in chipsY)
                        {
                            chip.update(type);
                        }
                    }
                }

                break;
            }
            case EControllerUpdate.ECUT_CHIPS_SHUFFLE:
            {
//                subViewRemove();
//
//                var gridChips:Array = GameInfo.instance.managerGame.grid;
//
//                var chipsViews:Array = [];
//                var chips:Array = [];
//
//                for each(var cellZ:Array in gridChips)
//                {
//                    var chipZ:Array = [];
//                    var chipsViewZ:Array = [];
//
//                    for each(var cellY:Array in cellZ)
//                    {
//                        var chipY:Array = [];
//                        var chipsViewY:Array = [];
//
//                        for each(var chipEntry:ChipInfo in cellY)
//                        {
//                            var chipNew:ControllerChip = new ControllerChip(chipEntry);
//
//                            chipY.push(chipNew);
//                            chipsViewY.push(chipNew.view);
//                        }
//                        chipZ.push(chipY);
//                        chipsViewZ.push(chipsViewY);
//                    }
//                    chips.push(chipZ);
//                    chipsViews.push(chipsViewZ);
//                }
//
//                _chips = chips;
//                _view.viewsChips = chipsViews;
//
//                _view.placeViews(false);
//
                for each(var z:Array in _chips)
                {
                    for each(var y:Array in z)
                    {
                        for each(var chipController:ControllerChip in y)
                        {
                            chipController.update(type);
                        }
                    }
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

    public function subViewRemove():void
    {
        for each(var z:Array in _chips)
        {
            for each(var y:Array in z)
            {
                for each(var chip:ControllerChip in y)
                {
                    if (chip.typeChip != EChipType.ETB_EMPTY)
                    {
                        chip.view.source.parent.removeChild(chip.view.source);
                        chip.cleanup();
                        chip = null;
                    }
                }
            }
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var z:Array in _chips)
        {
            for each(var y:Array in z)
            {
                for each(var chip:ControllerChip in y)
                {
                    chip.cleanup();
                    chip = null;
                }
            }
        }
        super.cleanup();
    }


}
}
