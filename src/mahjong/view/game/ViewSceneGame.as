/**
 * Created by evgenyyurko on 1/9/14.
 */
package mahjong.view.game
{
import controllers.IController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import mahjong.view.base.ViewSceneBase;

import views.implementations.ViewBase;

public class ViewSceneGame extends ViewSceneBase
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
    public function ViewSceneGame(controller:IController)
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
