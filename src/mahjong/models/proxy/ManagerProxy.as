/**
 * Created by evgenyyurko on 1/6/14.
 */
package mahjong.models.proxy
{
import bwf.models.proxy.IManagerProxy;

import mahjong.models.data.EChipType;

import models.interfaces.social.IManagerSocial;

public class ManagerProxy implements IManagerProxy
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
    public function ManagerProxy(managerSocial:IManagerSocial)
    {


        init();
    }

    private function init():void
    {

    }


    public function getAdData(data:Object):Object
    {
        return null;
    }

    public function getTutorialData(data:Object):Object
    {
        return null;
    }


    /*
     * IManagerProxy
     */

    public function toRemoteRequestParams(type:String, data:Object):Object
    {
        return null;
    }

    public function getBonusData(data:Object):Object
    {
        return null;
    }

    public function getPurchasesData(data:Object):Object
    {
        return null;
    }

    public function getLevelsData(data:Object):Object
    {
        var grid00:Array = [];

        for (var z:int = 0; z < 2; z++)
        {
            var containerForY:Array = [];

            for (var y:int = 0; y < 10; y++)
            {
                var containerForX:Array = [];

                for (var x:int = 0; x < 10; x++)
                {
                    var chipData:Object =
                    {
                        chip_type: ((x % 2) == 0 && (y % 2) == 0) ? EChipType.ETB_STUB : EChipType.ETB_EMPTY,
//                        chip_type: EChipType.ETB_STUB,
                        x: x,
                        y: y,
                        z: z
                    };

                    containerForX.push(chipData);
                }
                containerForY.push(containerForX)
            }
            grid00.push(containerForY);
        }

////////////////////// LEVELS_CONTAINER_0 /////////////////////
        var level0Container0:Object =
        {
            id: "level0Container0",
            name: "",
            number: 0,
            grid_data: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level1Container0:Object =
        {
            id: "level1Container0",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level2Container0:Object =
        {
            id: "level2Container0",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };
///////////////////////////////////////////////////////

////////////////////// LEVELS_CONTAINER_1 /////////////////////
        var level0Container1:Object =
        {
            id: "level0Container1",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level1Container1:Object =
        {
            id: "level1Container1",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level2Container1:Object =
        {
            id: "level2Container1",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };
///////////////////////////////////////////////////////

////////////////////// LEVELS_CONTAINER_2 /////////////////////
        var level0Container2:Object =
        {
            id: "level0Container2",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level1Container2:Object =
        {
            id: "level1Container2",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };

        var level2Container2:Object =
        {
            id: "level2Container2",
            name: "",
            number: 0,
            grid: grid00,
            reward_currency_soft: 1,
            reward_points: 2
        };
///////////////////////////////////////////////////////

////////////////////// CONTAINERS /////////////////////
        var container0:Object =
        {
            id: "",
            number: 4,
            name: "name",
            description: "",
            requirements: [],
            levels: [level0Container0]// level1Container0, level2Container0]
        };

//        var container1:Object =
//        {
//            id: "",
//            number: 4,
//            name: "name",
//            description: "",
//            requirements: [],
//            levels: [level0Container1, level1Container1, level2Container1]
//        };
//
//        var container2:Object =
//        {
//            id: "",
//            number: 4,
//            name: "name",
//            description: "",
//            requirements: [],
//            levels: [level0Container2, level1Container2, level2Container2]
//        };
///////////////////////////////////////////////////////
        var result:Object =
        {
            level_containers: [container0], // container1, container2],
            level_progress: null,
            level_complete_ids: []
        };

        return result;
    }


    public function getPlayersData(dataObj:Object):Object
    {

        var currentPlayerData:Object =
        {
            points: "1",
            url_image: "http://app1.greemlins.com/static/crossword/2.jpg",
            first_name: "Vasya",
            last_name: "Pupkin",
            social_player_id: 1,
            current_level_id: 2,
            player_id: 3
        };

        var result:Object =
        {
            current_player: currentPlayerData,
            friends: []
        };

        return result;
    }

    public function getPlayersTopPageData(data:Object):Array
    {
        return null;
    }

    public function getPlayerInfoData(dataObj:Object):Object
    {
        return null;
    }

}
}
