/**
 * Created by evgenyyurko on 5/22/14.
 */
package mahjong.models.plaeyr
{
import controllers.EControllerUpdateBase;

import core.implementations.Debug;

import mahjong.controllers.EControllerUpdate;

import models.implementations.players.PlayerInfoBase;
import models.interfaces.states.IState;

public class PlayerInfo extends PlayerInfoBase
{
    /*
     * Fields
     */
    private var _energy:uint;

    /*
     * Properties
     */
    public function get energy():uint
    {
        return _energy;
    }


    public function set energy(value:uint):void
    {
        if (_energy == value)
        {
            Debug.log("[WARNING]: currency soft not changed, but try update");
            return;
        }

        _energy = value;

        tryUpdateCurrentState(EControllerUpdate.ECU_PLAYER_ENERGY);
        _energy = value;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function PlayerInfo()
    {


        init();
    }

    private function init():void
    {

    }

    private function tryUpdateCurrentState(updateType:String):void
    {
        var currentState:IState = GameInfoBase.instance.managerStates.currentState;

        if (this == GameInfoBase.instance.managerPlayers.playerCurrent && currentState != null)
        {
            currentState.update(updateType);
        }
    }


    public override function deserialize(data:Object):void
    {
        _energy = Debug.assertProperty(data, "energy");

        super.deserialize(data);
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
