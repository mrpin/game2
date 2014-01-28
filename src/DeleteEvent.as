/**
 * Created by evgenyyurko on 1/28/14.
 */
package
{
import flash.events.Event;

public class DeleteEvent extends Event
{
    public static const DELETE = "delete";

    public function DeleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }

    public override function clone():Event
    {
        return new DeleteEvent(type, bubbles, cancelable);
    }

    public override function toString():String
    {
        return formatToString("DeleteEvent", "type", "bubbles", "cancelable", "eventPhase");
    }

}
}
