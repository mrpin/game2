/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.string
{
import models.implementations.string.ManagerStringBase;
import models.interfaces.social.IManagerSocial;

public class ManagerString extends ManagerStringBase
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
    public function ManagerString(managerSocial:IManagerSocial)
    {
        super(managerSocial);

        init();
    }

    private function init():void
    {

    }

}
}
