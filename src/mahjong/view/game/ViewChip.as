/**
 * Created by evgenyyurko on 1/10/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.models.data.ChipInfo;
import mahjong.models.data.EChipType;

import views.IView;
import views.implementations.ViewBase;

public class ViewChip extends ViewBase
{
    /*
     * Static
     */

    private static function getChipViewClass(index:int):Class
    {
        var result:Class = null;

        switch (index)
        {
        /***************** ETB ****************/
            case EChipType.ETB_0:
            {
                result = gBamboo0;

                break;
            }
            case EChipType.ETB_1:
            {
                result = gBamboo1;

                break;
            }
            case EChipType.ETB_2:
            {
                result = gBamboo2;

                break;
            }
            case EChipType.ETB_3:
            {
                result = gBamboo3;

                break;
            }
            case EChipType.ETB_4:
            {
                result = gBamboo4;

                break;
            }
            case EChipType.ETB_5:
            {
                result = gBamboo5;

                break;
            }
            case EChipType.ETB_6:
            {
                result = gBamboo6;

                break;
            }
            case EChipType.ETB_7:
            {
                result = gBamboo7;

                break;
            }

        /***************** ETP ****************/
            case EChipType.ETP_0:
            {
                result = gPoint0;

                break;
            }
            case EChipType.ETP_1:
            {
                result = gPoint1;

                break;
            }
            case EChipType.ETP_2:
            {
                result = gPoint2;

                break;
            }
            case EChipType.ETP_3:
            {
                result = gPoint3;

                break;
            }
            case EChipType.ETP_4:
            {
                result = gPoint4;

                break;
            }
            case EChipType.ETP_5:
            {
                result = gPoint5;

                break;
            }
            case EChipType.ETP_6:
            {
                result = gPoint6;

                break;
            }
            case EChipType.ETP_7:
            {
                result = gPoint7;

                break;
            }
            case EChipType.ETP_8:
            {
                result = gPoint8;

                break;
            }

        /***************** ETP ****************/
            case EChipType.ETS_0:
            {
                result = gSymbol0;

                break;
            }
            case EChipType.ETS_1:
            {
                result = gSymbol1;

                break;
            }
            case EChipType.ETS_2:
            {
                result = gSymbol2;

                break;
            }
            case EChipType.ETS_3:
            {
                result = gSymbol3;

                break;
            }
            case EChipType.ETS_4:
            {
                result = gSymbol4;

                break;
            }
            case EChipType.ETS_5:
            {
                result = gSymbol5;

                break;
            }
            case EChipType.ETS_6:
            {
                result = gSymbol6;

                break;
            }
            case EChipType.ETS_7:
            {
                result = gSymbol7;

                break;
            }
            case EChipType.ETS_8:
            {
                result = gSymbol8;

                break;
            }

            case EChipType.ETB_EMPTY:
            {
                result = Sprite;

                break;
            }
            default:
            {
                Debug.assert(false);

                break;
            }
        }

        return result;
    }

    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;

    public var _type:int;

    private var _offsetX:Number;
    private var _offsetY:Number;

    private var _chipView:IView;
    private var _shadow:IView;

    private var _chipFace:DisplayObjectContainer;

    /*
     * Properties
     */
    public function get offsetX():Number
    {
        return _offsetX;
    }

    public function get offsetY():Number
    {
        return _offsetY;
    }

    public function set enabled(value:Boolean):void
    {
        //TODO:Implement!
        Debug.assert(false, "Implement");
    }

    public function set filter(value:Array):void
    {
        _source.filters = value;
    }


    public function get chipView():IView
    {
        return _chipView;
    }

    public function get chipFace():DisplayObjectContainer
    {
        return _chipFace;
    }

    /*
     * Methods
     */
    public function ViewChip(controller:IController, entry:ChipInfo)
    {
        _type = entry.chipType;

        _source = new Sprite();

        if (_type != EChipType.ETB_EMPTY)
        {
            _shadow = new ViewBase(controller, new gChipShadow());
            _source.addChild(_shadow.source);

            _shadow.handleEvents();
        }


        var sourceClass:Class = getChipViewClass(entry.chipType);
        _chipView = new ViewBase(controller, new sourceClass);
        _source.addChild(_chipView.source);

//        if (_type != EChipType.ETB_EMPTY)
//        {
//            _chipFace = new gChipFace();
//            _chipFace.mouseEnabled = false;
//
//            _source.addChild(_chipFace);
//        }

        super(controller, _source);

        _offsetX = (entry.x % 2 == 0) ? 42 : 21;
        _offsetY = (entry.y % 2 == 0) ? 60 : 30;

        init();
    }

    private function init():void
    {


    }

    /*
     * IDisposable
     */

    public function addChild(value:Sprite):void
    {
        _source.addChild(value);
    }

    public function visibleSubViews(value:Boolean):void
    {
        _chipView.source.visible = value;
        _shadow.source.visible = value;
    }


    override public function placeViews(fullscreen:Boolean):void
    {
        if (_type != EChipType.ETB_EMPTY)
        {
            _shadow.x = 20;
            _shadow.y = 65;

//            _chipFace.x = 300;
//            _chipFace.y = 0;
        }

    }

    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
