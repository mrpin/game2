/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.view.selectionLevel
{
import controllers.IController;

import core.implementations.Debug;

import fl.motion.Color;

import mahjong.models.level.ELevelMode;

import views.implementations.buttons.ViewButton;
import views.interfaces.IView;

public class ViewSceneSelectionLevelItem extends ViewButton
{
    /*
     * Fields
     */
    private var _source:gSceneSelectionLevelItem;

    private var _viewStars:Array;

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

    public function set isOpen(value:Boolean):void
    {
        _source.viewLock.visible = !value;

        if (!value)
        {
            var color:Color = new Color();

            color.brightness = -0.5;

            _source.viewItem.transform.colorTransform = color;
            _source.labelLevel.transform.colorTransform = color;

            for each(var viewStar:IView in _viewStars)
            {
                viewStar.source.transform.colorTransform = color;
            }

            this.handleEvents();
        }
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
        _viewStars = [];

        var countStar:int = 3;

        for (var i:int = 0; i < countStar; i++)
        {
            var viewStar:ViewStar = new ViewStar(controller);
            _source.addChild(viewStar.source);
            _viewStars.push(viewStar);
        }
    }

    public function setTypeStar(typeStar:String, numberStar:uint):void
    {
        Debug.assert(numberStar < 3);

        var viewStar:ViewStar = _viewStars[numberStar];
        viewStar.visibleTypeStarBy = typeStar;
    }

    override public function placeViews(fullscreen:Boolean):void
    {
        var startPosition:int = 19;

        for each(var viewStar:IView in _viewStars)
        {
            viewStar.source.x = startPosition;
            viewStar.source.y = 75;

            startPosition += viewStar.source.width + 5;
        }
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var viewStar:IView in _viewStars)
        {
            viewStar.cleanup();
        }

        _viewStars = null;

        super.cleanup();
    }


}
}
