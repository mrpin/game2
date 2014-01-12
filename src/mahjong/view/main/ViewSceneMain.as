/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.main
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.view.base.ViewSceneBase;

public class ViewSceneMain extends ViewSceneBase
{
    /*
     * Fields
     */
    private var _source:DisplayObjectContainer;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewSceneMain(controller:IController)
    {
        _source = new Sprite();
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
