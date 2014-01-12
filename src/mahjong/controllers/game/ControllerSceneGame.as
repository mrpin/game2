/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.game
{
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.game.ViewSceneGame;

public class ControllerSceneGame extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneGame;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerSceneGame()
    {
        _view = new ViewSceneGame(this);

        super(_view);

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
        _view.cleanup();
        _view = null;

        super.cleanup();
    }


}
}
