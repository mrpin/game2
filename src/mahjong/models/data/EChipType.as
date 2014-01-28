/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import utils.Utils;

public class EChipType
{
    public static const ETB_EMPTY:int = -2;
    //TODO: change ETB to ECT
    public static const ETB_STUB:int = -1;

    public static const ETB_0:uint = 0;
    public static const ETB_1:uint = 1;
    public static const ETB_2:uint = 2;
    public static const ETB_3:uint = 3;
    public static const ETB_4:uint = 4;
    public static const ETB_5:uint = 5;
    public static const ETB_6:uint = 6;
    public static const ETB_7:uint = 7;

    public static const ETP_0:uint = 8;
    public static const ETP_1:uint = 9;
    public static const ETP_2:uint = 10;
    public static const ETP_3:uint = 11;
    public static const ETP_4:uint = 12;
    public static const ETP_5:uint = 13;
    public static const ETP_6:uint = 14;
    public static const ETP_7:uint = 15;
    public static const ETP_8:uint = 16;

    public static const ETS_0:uint = 17;
    public static const ETS_1:uint = 18;
    public static const ETS_2:uint = 19;
    public static const ETS_3:uint = 20;
    public static const ETS_4:uint = 21;
    public static const ETS_5:uint = 22;
    public static const ETS_6:uint = 23;
    public static const ETS_7:uint = 24;
    public static const ETS_8:uint = 25;

    public static const ETB_COUNT:uint = 26;

    public static function getRandomType():uint
    {
        return Utils.randomFromTo(0, 25);
    }

}
}
