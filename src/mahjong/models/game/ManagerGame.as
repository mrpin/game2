/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.game
{
import mahjong.models.data.ChipInfo;
import mahjong.models.data.LevelInfo;

import models.implementations.game.ManagerGameBase;
import models.interfaces.levels.ILevelInfo;

public class ManagerGame extends ManagerGameBase
{
    /*
     * Fields
     */
    private var _currentLevel:LevelInfo;

    private var _chipSelected:ChipInfo;

    /*
     * Properties
     */


    /*
     * Methods
     */
    public function ManagerGame(levelInfo:ILevelInfo)
    {
        super(levelInfo);

        init();
    }

    private function init():void
    {

    }


}
}
