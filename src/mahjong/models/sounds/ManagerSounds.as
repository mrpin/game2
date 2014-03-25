/**
 * Created by evgenyyurko on 3/25/14.
 */
package mahjong.models.sounds
{
import flash.media.Sound;
import flash.media.SoundLoaderContext;
import flash.net.URLRequest;

import models.implementations.sounds.ManagerSoundsBase;

public class ManagerSounds extends ManagerSoundsBase
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
    public function ManagerSounds()
    {
    }

    override protected function initMusic():void
    {
        super.initMusic();

        var musicMain:Sound = new Sound();
        var request:URLRequest = new URLRequest("https://s3.amazonaws.com/game_crosswords/music/mMain.mp3");
        var context:SoundLoaderContext = new SoundLoaderContext(8000, true);
        musicMain.load(request, context);

        registerMusic(musicMain, ESoundType.EST_MUSIC_MAIN);
    }


    override protected function initSounds():void
    {
        super.initSounds();

        registerSound(new sMainItem.mp3, ESoundType.EST_MAIN_ITEM);
    }

}
}
