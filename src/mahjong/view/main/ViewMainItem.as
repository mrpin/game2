/**
 * Created by evgenyyurko on 1/30/14.
 */
package mahjong.view.main
{
import com.greensock.TweenMax;
import com.greensock.easing.Bounce;

import controllers.IController;

import mahjong.GameInfo;

import models.interfaces.levels.ILevelContainer;

import views.implementations.ViewBase;

public class ViewMainItem extends ViewBase
{
    /*
     * Fields
     */
    private var _source:gSceneMainItem;


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ViewMainItem(controller:IController, entry:ILevelContainer)
    {
        _source = new gSceneMainItem();
        super(controller, _source);


        var index:int = -1;

        if (entry != null)
        {
            index = GameInfo.instance.managerLevels.items.indexOf(entry);
        }
        else
        {
//            _source.viewLabel.visible = false;
        }

        _source.art.gotoAndStop(1);

        _source.art.item.stop();
        _source.lightning.stop();

        this.handleEvents(true, false, false, false, false, true, true);

        init();
    }

    private function init():void
    {
        _source.scaleX = 0.5;
        _source.scaleY = 0.5;
    }

    public function startAnimation():void
    {
        _source.art.item.play();
        _source.lightning.gotoAndPlay(1);
    }

    public function stopAnimation():void
    {
        _source.art.item.stop();
        _source.lightning.stop();
    }

    public function setBounce():void
    {
        TweenMax.to(_source, 1, {scaleX:1, scaleY:1, ease:Bounce.easeIn});
    }

    /*
     * IDisposable
     */
    public override function cleanup():void
    {
        _source = null;

        super.cleanup();
    }


}
}
