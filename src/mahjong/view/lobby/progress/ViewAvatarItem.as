/**
 * Created by evgenyyurko on 4/3/14.
 */
package mahjong.view.lobby.progress
{
import controllers.IController;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import mahjong.GameInfo;

import models.interfaces.players.IManagerPlayers;
import models.interfaces.players.IPlayerInfo;
import models.interfaces.string.IManagerString;

import utils.UtilsFilters;

import views.implementations.ViewBase;
import views.implementations.buttons.ViewButton;
import views.interfaces.buttons.IViewButton;

public class ViewAvatarItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;
    private var _entry:IPlayerInfo;

    private var _labelName:TextField;
    private var _labelPoints:TextField;
    private var _imageContainer:MovieClip;
    private var _buttonAddFriend:IViewButton;

    /*
     * Properties
     */

    public function set name(value:String):void
    {
        _labelName.text = value;
    }


    public function set points(value:String):void
    {
        _labelPoints.text = value;
    }

    public function get buttonAddFriend():IViewButton
    {
        return _buttonAddFriend;
    }


    /*
     * Events
     */


    /*
     * Methods
     */


    //todo: remove entry
    public function ViewAvatarItem(controller:IController, player:IPlayerInfo)
    {
        _entry = player;
        _source = new Sprite();
        super(controller, _source);

        init();
    }

    private function init():void
    {
        var managerPlayers:IManagerPlayers = GameInfo.instance.managerPlayers;

        var playerFirstTop:IPlayerInfo = managerPlayers.playersTop[0];

        var sourceValue:DisplayObject;

        if (_entry == playerFirstTop)
        {
            var sourceBig:gMeasureBig = new gMeasureBig();

            _labelName = sourceBig.labelName;
            _labelPoints = sourceBig.labelPoints;
            _imageContainer = sourceBig.viewImage;

            sourceValue = sourceBig;
        }
        else
        {
            var sourceSmall:gMeasureSmall = new gMeasureSmall();

            _labelName = sourceSmall.labelName;
            _labelPoints = sourceSmall.labelPoints;
            _imageContainer = sourceSmall.viewImage;

            _buttonAddFriend = new ViewButton(controller, sourceSmall.buttonAddFriend);

            sourceValue = sourceSmall;
        }

        _source.addChild(sourceValue);

        // _entry == null - "Add Friend" item
        if (_entry != null)
        {
            if (sourceValue is gMeasureSmall)
            {
                _buttonAddFriend.hide();
            }

            _labelName.text = _entry.nameFirst;
            _labelPoints.text = _entry.points.toString();
            _entry.tryLoadPicture(function (player:IPlayerInfo, image:Bitmap):void
            {
                image.width = _imageContainer.width;
                image.height = _imageContainer.height;
                _imageContainer.addChild(image);
            });
        }
        else
        {
            var managerString:IManagerString = GameInfo.instance.managerString;
//            _labelName.text = managerString.localizedString(EStringType.EST_MAIN_PROGRESS_PANEL_ADD_FRIEND);
            _labelPoints.text = "";
            if (sourceValue is gMeasureSmall)
            {
                _buttonAddFriend.show();
            }

            _source.filters = [UtilsFilters.FILTER_GRAYSCALE];
        }


    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        if (_buttonAddFriend != null)
        {
            _buttonAddFriend.cleanup();
            _buttonAddFriend = null;
        }

        _source = null;

        super.cleanup();
    }


}
}
