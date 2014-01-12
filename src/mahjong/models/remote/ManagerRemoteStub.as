/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.remote
{
import bwf.models.proxy.IManagerProxy;

import models.implementations.remote.ManagerRemoteBase;

public class ManagerRemoteStub extends ManagerRemoteBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ManagerRemoteStub(serverURL:String, proxy:IManagerProxy)
    {
        super("http://google.com", proxy);
    }

    public override function update(type:String, data:Object, onComplete:Function = null):void
    {
        if (onComplete != null)
            onComplete(null);
    }

}
}
