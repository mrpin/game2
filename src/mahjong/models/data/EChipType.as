/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.data
{
import utils.Utils;
import utils.UtilsArray;

public class EChipType
{


    public static const ETB_EMPTY:int = -2;
    //TODO: change ETB to ECT
    public static const ETB_STUB:int = -1;

    public static const ET_BAMBOO_0:uint = 0;
    public static const ET_BAMBOO_1:uint = 1;
    public static const ET_BAMBOO_2:uint = 2;
    public static const ET_BAMBOO_3:uint = 3;
    public static const ET_BAMBOO_4:uint = 4;
    public static const ET_BAMBOO_5:uint = 5;
    public static const ET_BAMBOO_6:uint = 6;
    public static const ET_BAMBOO_7:uint = 7;
    public static const ET_BAMBOO_8:uint = 8;

    public static const ET_DOT_0:uint = 9;
    public static const ET_DOT_1:uint = 10;
    public static const ET_DOT_2:uint = 11;
    public static const ET_DOT_3:uint = 12;
    public static const ET_DOT_4:uint = 13;
    public static const ET_DOT_5:uint = 14;
    public static const ET_DOT_6:uint = 15;
    public static const ET_DOT_7:uint = 16;
    public static const ET_DOT_8:uint = 17;

    public static const ET_DRAGON_0:uint = 18;
    public static const ET_DRAGON_1:uint = 19;
    public static const ET_DRAGON_2:uint = 20;

    public static const ET_FLOWERS_0:uint = 21;
    public static const ET_FLOWERS_1:uint = 22;
    public static const ET_FLOWERS_2:uint = 23;
    public static const ET_FLOWERS_3:uint = 24;

    public static const ET_SEASON_0:uint = 25;
    public static const ET_SEASON_1:uint = 26;
    public static const ET_SEASON_2:uint = 27;
    public static const ET_SEASON_3:uint = 28;
    public static const ET_SYMBOL_0:uint = 29;
    public static const ET_SYMBOL_1:uint = 30;
    public static const ET_SYMBOL_2:uint = 31;
    public static const ET_SYMBOL_3:uint = 32;
    public static const ET_SYMBOL_4:uint = 33;
    public static const ET_SYMBOL_5:uint = 34;
    public static const ET_SYMBOL_6:uint = 35;
    public static const ET_SYMBOL_7:uint = 36;
    public static const ET_SYMBOL_8:uint = 37;

    public static const ET_WIND_0:uint = 38;
    public static const ET_WIND_1:uint = 39;
    public static const ET_WIND_2:uint = 40;
    public static const ET_WIND_3:uint = 41;

    public static const ETB_COUNT:uint = 42;


    public static function getRandomType():uint
    {
        var allTypes:Array =
                [
                    ET_BAMBOO_0,
                    ET_BAMBOO_1,
                    ET_BAMBOO_2,
                    ET_BAMBOO_3,
                    ET_BAMBOO_4,
                    ET_BAMBOO_5,
                    ET_BAMBOO_6,
                    ET_BAMBOO_7,
                    ET_BAMBOO_8,
                    ET_DOT_0,
                    ET_DOT_1,
                    ET_DOT_2,
                    ET_DOT_3,
                    ET_DOT_4,
                    ET_DOT_5,
                    ET_DOT_6,
                    ET_DOT_7,
                    ET_DOT_8,
                    ET_DRAGON_0,
                    ET_DRAGON_1,
                    ET_DRAGON_2,
                    ET_FLOWERS_0,
                    ET_FLOWERS_1,
                    ET_FLOWERS_2,
                    ET_FLOWERS_3,
                    ET_SEASON_0,
                    ET_SEASON_1,
                    ET_SEASON_2,
                    ET_SEASON_3,
                    ET_SYMBOL_0,
                    ET_SYMBOL_1,
                    ET_SYMBOL_2,
                    ET_SYMBOL_3,
                    ET_SYMBOL_4,
                    ET_SYMBOL_5,
                    ET_SYMBOL_6,
                    ET_SYMBOL_7,
                    ET_SYMBOL_8,
                    ET_WIND_0,
                    ET_WIND_1,
                    ET_WIND_2,
                    ET_WIND_3
                ];

        UtilsArray.shuffle(allTypes);
        UtilsArray.shuffle(allTypes);
        UtilsArray.shuffle(allTypes);
        UtilsArray.shuffle(allTypes);

        var randomValue:uint = Utils.randomFromTo(0, allTypes.length - 1);

        return allTypes[randomValue];
    }

}
}
