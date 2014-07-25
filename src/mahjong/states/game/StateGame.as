/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.states.game
{
import mahjong.controllers.game.ControllerSceneGame;
import mahjong.controllers.popups.bonus.ControllerPopupBonus;
import mahjong.states.EStateType;
import mahjong.states.base.StateMahjongBase;
import mahjong.view.popup.popups.controller.ControllerPopupOutOfTime;
import mahjong.view.popup.popups.controller.win.ControllerPopupWin;

public class StateGame extends StateMahjongBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    public override function get type():String
    {
        return EStateType.EST_GAME;
    }

    /*
     * Methods
     */
    public function StateGame()
    {


        init();
    }

    private function init():void
    {

    }

    public override function prepareLayerScene():void
    {
        super.prepareLayerScene();

        this.controllerScene = new ControllerSceneGame();
    }


    override public function prepareLayerPopups():void
    {
        super.prepareLayerPopups();

        {//register popups
            registerPopup(new ControllerPopupWin());
            registerPopup(new ControllerPopupOutOfTime());
        }
    }

    override public function loadResources(onComplete:Function):void
    {
        onComplete();

//        controllerScene.view.loadContent(onComplete);
    }

    public override function placeViews(fullscreen:Boolean):void
    {
        super.placeViews(fullscreen);
    }

    public override function onLoadingEnd():void
    {
        GameInfoBase.instance.managerGameBase.registerStateGame(this);

        super.onLoadingEnd();
    }


    override public function update(type:String):void
    {
        super.update(type);
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
