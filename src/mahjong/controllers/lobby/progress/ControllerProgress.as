/**
 * Created by evgenyyurko on 4/2/14.
 */
package mahjong.controllers.lobby.progress
{
import controllers.implementations.Controller;
import controllers.interfaces.IController;

import mahjong.GameInfo;
import mahjong.view.lobby.progress.ViewProgress;

import models.interfaces.players.IManagerPlayers;
import models.interfaces.players.IPlayerInfo;

import utils.Utils;
import utils.UtilsArray;

public class ControllerProgress extends Controller
{
    /*
     * Fields
     */
    private var _view:ViewProgress;

    private var _itemsArray:Array;

    /*
     * Properties
     */


    /*
     * Events
     */

    /*
     * Methods
     */
    public function ControllerProgress()
    {
        _view = new ViewProgress(this);
        super(_view);

        init();
    }

    private function init():void
    {
        _itemsArray = [];
        initPlayers();
    }

    private function initPlayers():void
    {
        var managerPlayers:IManagerPlayers = GameInfo.instance.managerPlayers;

        var playersAll:Array = managerPlayers.playerFriends.length == 0 ? managerPlayers.playersTop : managerPlayers.playerFriends;
        var playerTop:IPlayerInfo = managerPlayers.playersTop[0];

        var players:Array = [];
        var playersBefore:Array = [];
        var playersAfter:Array = [];

        players.push(managerPlayers.playerCurrent);

        for each(var playerTo:IPlayerInfo in playersAll)
        {
            if (playerTo.points < managerPlayers.playerCurrent.points)
            {
                playersBefore.push(playerTo);
            }

            if (playerTo.points > managerPlayers.playerCurrent.points)
            {
                playersAfter.push(playerTo);
            }
        }

        if (playerTop != managerPlayers.playerCurrent && playersAfter.indexOf(playerTop) != ConstantsBase.INDEX_NONE)
        {
            UtilsArray.removeValue(playersAfter, playerTop);
        }

        for (var i:int = 0; i < _view.itemsCountMax - 1; i++)
        {
            if (i == 0 && playersBefore.length > 0)
            {
                var randomIndexTo:int = Utils.randomFromTo(0, playersBefore.length - 1);

                var toPlayer:IPlayerInfo = playersBefore[randomIndexTo];

                players.push(toPlayer);
            }

            if (playersAfter.length > 0)
            {
                var randomIndexAfter:int = Utils.randomFromTo(0, playersAfter.length - 1);

                var afterPlayer:IPlayerInfo = playersAfter[randomIndexAfter];

                players.push(afterPlayer);

                UtilsArray.removeValue(playersAfter, afterPlayer);
            }
        }

        players.sortOn("points", Array.NUMERIC | Array.DESCENDING);

        // Added top player to the first position
        _itemsArray.push(new ControllerAvatarItem(playerTop));

        // _view.itemsCountMax - 2 because of: 1. First top
        var itemIndex:uint = 0;

        while (_itemsArray.length < _view.itemsCountMax - 1)
        {
            if (itemIndex >= players.length)
            {
                _itemsArray.push(new ControllerAvatarItem(null));
            }
            else
            {
                if (playerTop == players[itemIndex])
                {
                    continue;
                }

                _itemsArray.push(new ControllerAvatarItem(players[itemIndex] as IPlayerInfo));
                itemIndex++;
            }
        }

        _itemsArray.push(new ControllerAvatarItem(null));

        for (i = 0; i < _itemsArray.length; i++)
        {
            _view.addViewItem = (_itemsArray[i] as IController).view;
        }
    }


    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        for each(var item:IController in _itemsArray)
        {
            item.cleanup();
        }

        _itemsArray = null;

        super.cleanup();
    }


}
}
