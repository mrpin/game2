/**
 * Created by evgenyyurko on 1/6/14.
 */
package
{

import flash.display.Sprite;
import flash.events.Event;

import mahjong.GameInfo;

[Frame(factoryClass="Preloader")]
[SWF(backgroundColor="#000000", width="1000", height="750", frameRate="29")]
public class Main extends Sprite
{
    /*
     * Static fields
     */
    /*
     * Static properties
     */
    /*
     * Fields
     */

    public function Main()
    {
//        Cc.startOnStage(this);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        //init model
        GameInfo.run(stage);
    }
}
}
