/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.controllers.game
{
import controllers.implementations.Controller;

import flash.events.MouseEvent;

import mahjong.GameInfo;
import mahjong.controllers.EControllerUpdate;
import mahjong.models.data.ChipInfo;
import mahjong.view.game.ViewFieldChips;

import views.IView;

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

        //TODO:удалить после тестирования
       GameInfo.instance.managerGame.onShowChipsDisable = true;
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
                //TODO:бывает при перетасовке замыкается for
                _view.subViewRemove();

                var gridChips:Array = GameInfo.instance.managerGame.grid;

                var chipsViews:Array = [];
                var chips:Array = [];

                for each(var cellZ:Array in gridChips)
                {
                    var chipZ:Array = [];
                    var chipsViewZ:Array = [];

                    for each(var cellY:Array in cellZ)
                    {
                        var chipY:Array = [];
                        var chipsViewY:Array = [];

                        for each(var chipEntry:ChipInfo in cellY)
                        {
                            var chipNew:ControllerChip = new ControllerChip(chipEntry);

                            chipY.push(chipNew);
                            chipsViewY.push(chipNew.view);
                        }
                        chipZ.push(chipY);
                        chipsViewZ.push(chipsViewY);
                    }
                    chips.push(chipZ);
                    chipsViews.push(chipsViewZ);
                }

                _chips = chips;
                _view.viewsChips = chipsViews;

                _view.placeViews(false);

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
