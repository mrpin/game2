/**
 * Created by evgenyyurko on 3/25/14.
 */
package mahjong.models.response
{
import core.implementations.Debug;

import models.implementations.remote.ResponseBase;
import models.interfaces.remote.EResponseStatus;

public class Response extends ResponseBase
{
    /*
     * Fields
     */
    private var _status:String;
    private var _entry:Object;

    /*
     * Properties
     */
    public override function get status():String
    {
        return _status;
    }


    public override function get entry():Object
    {
        return _entry;
    }

    /*
     * Events
     */


    /*
     * Methods
     */
    public function Response()
    {


        init();
    }

    private function init():void
    {

    }


    /*
     * IDisposable
     */
    public override function serialize():Object
    {
        return null;
    }

    public override function deserialize(data:Object):void
    {
        _entry = Debug.assertProperty(data, "response");

        switch (Debug.assertProperty(data, "status"))
        {
            case "ok":
            {
                _status = EResponseStatus.ERS_OK;
                break;
            }
            case "error":
            {
                _status = EResponseStatus.ERS_ERROR;
                break;
            }
            default :
            {
                Debug.assert(false);
                break;
            }
        }
    }


}
}
