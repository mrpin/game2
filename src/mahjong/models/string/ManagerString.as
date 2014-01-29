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
    }

    private function init():void
    {

    }

    protected override function initLanguageEnglish():void
    {
        super.initLanguageEnglish();

        _currentLanguage[EStringType.EST_MAIN_ITEM] = "{0}/{1}";
    }

    protected override function initLanguageRussian():void
    {
        super.initLanguageRussian();

        _currentLanguage[EStringType.EST_MAIN_ITEM] = "{0}/{1}";
    }

}
}
