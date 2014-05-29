/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import core.implementations.Debug;

import mahjong.models.level.ELevelMode;

import views.implementations.buttons.ViewButton;

public class ViewSceneSelectionLevelItem extends ViewButton
{
    /*
     * Fields
     */
    private var _source:gSceneSelectionLevelItem;

    /*
     * Properties
     */
    public function set typeLevelMode(value:String):void
    {
        _source.viewLevelMode.viewTime.visible = false;
        _source.viewLevelMode.viewClassic.visible = false;
        _source.viewLevelMode.viewAdvanced.visible = false;

        switch (value)
        {
            case ELevelMode.ELM_TIME:
            {
                _source.viewLevelMode.viewTime.visible = true;

                break;
            }
            case ELevelMode.ELM_CLASSIC:
            {
                _source.viewLevelMode.viewClassic.visible = true;

                break;
            }
            case ELevelMode.ELM_ADVANCED:
            {
                _source.viewLevelMode.viewAdvanced.visible = true;

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }
    }

    public function set labelLevel(value:uint):void
    {
        _source.labelLevel.text = value.toString();
    }

    public function set isVisibleLock(value:Boolean):void
    {
        _source.viewLock.visible = value;
    }

    public function set visibleTypeStar(value:String):void
    {
        //TODO:реализовать метод до конца
        _source.viewStar0.visible = false;
        _source.viewStar1.visible = false;
        _source.viewStar2.visible = false;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewSceneSelectionLevelItem(controller:IController)
    {
        _source = new gSceneSelectionLevelItem();
        super(controller, _source);

        init();
    }

    private function init():void
    {

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
