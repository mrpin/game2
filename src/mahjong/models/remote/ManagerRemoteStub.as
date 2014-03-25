/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.remote
{
import mahjong.Constants;
import mahjong.GameInfo;

import models.implementations.remote.ManagerRemoteBase;
import models.interfaces.social.IManagerSocial;

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
    public function ManagerRemoteStub(serverURL:String, managerSocial:IManagerSocial)
    {
        super("http://google.com", managerSocial, Constants.SECRET_KEY);
    }

    public override function update(type:String, data:Object, onComplete:Function = null):void
    {
        if (onComplete != null)
            onComplete(GameInfo.instance.response);


//        super.update(type, data, onComplete);
    }

}
}
