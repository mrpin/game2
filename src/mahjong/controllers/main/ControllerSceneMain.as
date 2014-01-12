/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.controllers.main
{
import mahjong.controllers.base.ControllerSceneBase;
import mahjong.view.main.ViewSceneMain;

public class ControllerSceneMain extends ControllerSceneBase
{
    /*
     * Fields
     */
    private var _view:ViewSceneMain;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ControllerSceneMain()
    {
        _view = new ViewSceneMain(this);

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
