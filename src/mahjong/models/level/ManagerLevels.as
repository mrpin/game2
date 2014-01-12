/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.level
{
import models.implementations.levels.ManagerLevelsBase;

public class ManagerLevels extends ManagerLevelsBase
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
    public function ManagerLevels(levelClass:Class)
    {
        super(levelClass);

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
