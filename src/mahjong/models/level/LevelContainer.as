/**
 * Created by evgenyyurko on 5/21/14.
 */
package mahjong.models.level
{
import models.implementations.levels.LevelContainerBase;

public class LevelContainer extends LevelContainerBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */


    /*
     * Events
     */


    /*
     * Methods
     */
    public function LevelContainer(levelClass:Class)
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
