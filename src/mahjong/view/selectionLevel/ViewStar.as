/**
 * Created by evgenyyurko on 6/11/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import core.implementations.Debug;

import mahjong.models.level.EStarType;

import views.implementations.ViewBase;

public class ViewStar extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gStar2;


    /*
     * Properties
     */
    public function set visibleTypeStarBy(typeString:String):void
    {
        switch (typeString)
        {
            case EStarType.EST_EMPTY:
            {
                _source.gotoAndStop(1);

                break;
            }
            case EStarType.EST_FOR_PASSING_ERROR_FREE:
            case EStarType.EST_FOR_PASSING_TWICE_MODE_CLASSIC:
            {
                _source.gotoAndStop(2);

                break;
            }
            case EStarType.EST_FOR_PURCHASE:
            {
                _source.gotoAndStop(3);

                break;
            }
            case EStarType.EST_FOR_SHORT_TIME_PASSING:
            {
                _source.gotoAndStop(4);

                break;
            }
            case EStarType.EST_VICTORY_MODE_ADVANCED:
            {
                _source.gotoAndStop(5);

                break;
            }
            case EStarType.EST_VICTORY_MODE_CLASSIC:
            {
                _source.gotoAndStop(6);

                break;
            }
            case EStarType.EST_VICTORY_MODE_TIME:
            {
                _source.gotoAndStop(7);

                break;
            }
            default :
            {
                Debug.assert(false);

                break;
            }
        }
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function ViewStar(controller:IController)
    {
        _source = new gStar2();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        visibleTypeStarBy = EStarType.EST_EMPTY;
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
