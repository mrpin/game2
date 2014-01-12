/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.states.main
{
import mahjong.states.EStateType;
import mahjong.states.base.StateMahjongBase;

public class StateMain extends StateMahjongBase
{
    /*
     * Fields
     */


    /*
     * Properties
     */
    public override function get type():String
    {
        return EStateType.EST_MAIN;
    }

    /*
     * Methods
     */
    public function StateMain()
    {


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
