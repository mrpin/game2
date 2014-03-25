/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.proxy
{
import mahjong.models.data.EChipType;

public class ManagerProxy
{

    public static function getLevelsData():Object
    {
        var grid00:Array = [];

        for (var z:int = 0; z < 1; z++)
        {
            var containerForY:Array = [];

            for (var y:int = 0; y < 10; y++)
            {
                var containerForX:Array = [];

                for (var x:int = 0; x < 20; x++)
                {
                    var chipData:Object =
                    {
                        chip_type: ((x % 2) == 0 && (y % 2) == 0) ? EChipType.ETB_STUB : EChipType.ETB_EMPTY,
//                        chip_type: EChipType.ETB_STUB,
                        x        : x,
                        y        : y,
                        z        : z
                    };

                    containerForX.push(chipData);
                }
                containerForY.push(containerForX)
            }
            grid00.push(containerForY);
        }

//        for (var z:int = 0; z < 2; z++)
//        {
//            var containerForY:Array = [];
//
//            for (var y:int = 0; y < 10; y++)
//            {
//                var containerForX:Array = [];
//
//                for (var x:int = 0; x < 10; x++)
//                {
//                    var chipData:Object =
//                    {
//                        chip_type: ((x == 2) &&  y == 2  && z == 0) ||
//                                  (((x == 4) &&  y == 2  && z == 0)) ||
//                                  (((x == 3) &&  y == 2  && z == 1)) ||
//                                  (((x == 8) &&  y == 0  && z == 1))
//                                ? EChipType.ETB_STUB : EChipType.ETB_EMPTY,
////                        chip_type: EChipType.ETB_STUB,
//                        x: x,
//                        y: y,
//                        z: z
//                    };
//
//                    containerForX.push(chipData);
//                }
//                containerForY.push(containerForX)
//            }
//            grid00.push(containerForY);
//        }

////////////////////// LEVELS_CONTAINER_0 /////////////////////
        var level0Container0:Object =
        {
            id                  : "level0Container0",
            name                : "",
            description         : "",
            number              : 0,
            grid_data           : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level1Container0:Object =
        {
            id                  : "level1Container0",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level2Container0:Object =
        {
            id                  : "level2Container0",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

///////////////////////////////////////////////////////

////////////////////// LEVELS_CONTAINER_1 /////////////////////
        var level0Container1:Object =
        {
            id                  : "level0Container1",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level1Container1:Object =
        {
            id                  : "level1Container1",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level2Container1:Object =
        {
            id                  : "level2Container1",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

///////////////////////////////////////////////////////

////////////////////// LEVELS_CONTAINER_2 /////////////////////
        var level0Container2:Object =
        {
            id                  : "level0Container2",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level1Container2:Object =
        {
            id                  : "level1Container2",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };

        var level2Container2:Object =
        {
            id                  : "level2Container2",
            name                : "",
            description         : "",
            number              : 0,
            grid                : grid00,
            reward_currency_soft: 1,
            reward_points       : 2,
            level_progress      : {
                complete: false
            }
        };


///////////////////////////////////////////////////////

////////////////////// CONTAINERS /////////////////////
        var container0:Object =
        {
            id            : "",
            number        : 4,
            name          : "name",
            description   : "",
            requirements  : [],
            levels        : [level0Container0],// level1Container0, level2Container0]
            level_progress: {}
        };

        var container1:Object =
        {
            id            : "",
            number        : 4,
            name          : "name",
            description   : "",
            requirements  : [],
            levels        : [level0Container0], //, level1Container1, level2Container1]
            level_progress: {}
        };

        var container2:Object =
        {
            id            : "",
            number        : 4,
            name          : "name",
            description   : "",
            requirements  : [],
            levels        : [level0Container0],
            level_progress: {}//, level1Container2, level2Container2]
        };
///////////////////////////////////////////////////////
        var result:Object =
        {
            level_containers: [container0, container1, container2, container0, container1, container2]
        };

        return result;
    }


    public static function getBonusData():Object
    {
        var bonus0:Object =
        {
            id          : 1,
            in_a_row    : true,
            reward_count: 340,
            reward_type : "EBT_CURRENCY_SOFT",
            time_left   : 10,
            time_period : 120
        };

        var bonus1:Object =
        {
            id          : 2,
            in_a_row    : true,
            reward_count: 240,
            reward_type : "EBT_CURRENCY_SOFT",
            time_left   : 30,
            time_period : 180
        };

        var result:Object =
        {
            bonuses                       : [bonus0, bonus1],
            reward_currency_invited_friend: 5
        };

        return result;
    }

    public static function getPlayersData():Object
    {
        var playerCurrent:Object =
        {
            currency_soft       : 100,
            id                  : 1,
            is_new              : false,
            last_played_level_id: "-1",
            name_first          : "Арнольд",
            name_last           : "Шварц",
            points              : 15,
            position_total      : 1,
            url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
        };

        var playerFriend0:Object =
        {
            currency_soft       : 10,
            id                  : 1,
            is_new              : false,
            last_played_level_id: "-1",
            name_first          : "Вася",
            name_last           : "Пупкин",
            points              : 0,
            position_total      : 2,
            url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
        };

        var playerFriend1:Object =
        {
            currency_soft       : 10,
            id                  : 2,
            is_new              : false,
            last_played_level_id: "-1",
            name_first          : "Петя",
            name_last           : "Пупкин",
            points              : 0,
            position_total      : 2,
            url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
        };

        var playerTop100_0:Object =
        {
            currency_soft       : 10,
            id                  : 1,
            is_new              : false,
            last_played_level_id: "-1",
            name_first          : "Эдуард",
            name_last           : "Пупкин",
            points              : 45,
            position_total      : 2,
            url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
        };

        var playerTop100_1:Object =
        {
            currency_soft       : 3,
            id                  : 2,
            is_new              : false,
            last_played_level_id: "-1",
            name_first          : "Юлий",
            name_last           : "Пупкин",
            points              : 17,
            position_total      : 2,
            url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
        };


        var players:Array = [];
        for (var i:int = 0; i < 36; i++) ///////////////////////////////////////
        {
            var playerTop100_2:Object =
            {
                currency_soft       : 10,
                id                  : 2,
                last_played_level_id: "-1",
                name_first          : "Геркулес",
                name_last           : "Пупкина",
                points              : 45,
                position_total      : 2,
                url_image           : "http://s3.amazonaws.com/mrpin-sdk/player_image.jpg"
            };

            players.push(playerTop100_2);
        }

        var result:Object =
        {
            player_current : playerCurrent,
            player_friends : [playerFriend0, playerFriend1],
            players_top_100: [playerTop100_0, playerTop100_1]
        };
        return result;
    }


    public static function getPurchasesData():Object
    {
        var purchases0:Object =
        {
            content_count: 1,
            id           : 1,
            name         : "EPT_OPEN_CHAR:1",
            price_hard   : 1,
            price_soft   : 2,
            purchase_type: "EPT_OPEN_CHAR"
        };

        var purchases1:Object =
        {
            content_count: 30,
            id           : 2,
            name         : "EPT_OPEN_WORD:1",
            price_hard   : 10,
            price_soft   : 5,
            purchase_type: "EPT_OPEN_WORD"
        };


        var purchases2:Object =
        {
            content_count: 4,
            id           : 3,
            name         : "EPT_OPEN_IMAGE_CHAR:1",
            price_hard   : 15,
            price_soft   : 4,
            purchase_type: "EPT_OPEN_IMAGE_CHAR"
        };

        var purchases3:Object =
        {
            content_count: 50,
            id           : 4,
            name         : "EPT_OPEN_IMAGE:10",
            price_hard   : 8,
            price_soft   : 20,
            purchase_type: "EPT_OPEN_IMAGE"
        };

        var purchases4:Object =
        {
            content_count: 60,
            id           : 5,
            name         : "EPT_BUY_CURRENCY_SOFT:24",
            price_hard   : 25,
            price_soft   : 2,
            purchase_type: "EPT_BUY_CURRENCY_SOFT"
        };


        var purchases5:Object =
        {
            content_count: 70,
            id           : 6,
            name         : "EPT_BUY_CURRENCY_SOFT:45",
            price_hard   : 30,
            price_soft   : 2,
            purchase_type: "EPT_BUY_CURRENCY_SOFT"
        };

        var purchases6:Object =
        {
            content_count: 70,
            id           : 7,
            name         : "EPT_BUY_CURRENCY_SOFT:100",
            price_hard   : 30,
            price_soft   : 2,
            purchase_type: "EPT_BUY_CURRENCY_SOFT"
        };


        var result:Object =
        {
            purchases_list: [purchases0, purchases1, purchases2, purchases3, purchases4, purchases5]
        };

        return result;
    }

    public static function getTutorialData():Object
    {
        var result:Object =
        {
            need_start: false
        };

        return result;
    }

    public static function getResponseData():Object
    {
        var result:Object =
        {
            bonus    : getBonusData(),
            levels   : getLevelsData(),
            players  : getPlayersData(),
            purchases: getPurchasesData(),
            tutorial : getTutorialData()
        };

        return result;
    }

}
}
