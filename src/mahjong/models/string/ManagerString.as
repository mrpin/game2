/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.string
{
import flash.utils.Dictionary;

import models.implementations.string.ManagerStringBase;
import models.interfaces.social.IManagerSocial;
import models.interfaces.string.ELanguageType;

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

    protected override function initCurrentLanguage(managerSocial:IManagerSocial):void
    {
        _currentLanguage = new Dictionary(true);

        switch (managerSocial.currentLanguage)
        {
            case ELanguageType.ELT_ENGLISH:
            case ELanguageType.ELT_BELORUSSIAN:
            case ELanguageType.ELT_UKRAINIAN:
            case ELanguageType.ELT_RUSSIAN:
            {
                initLanguageRussian();
                break;
            }
            default :
            {
                Debug.assert(false);
                break;
            }
        }
    }

    protected override function initLanguageEnglish():void
    {
        super.initLanguageEnglish();

//        _currentLanguage[EStringType.EST_MAIN_ITEM] = "{0}/{1}";
    }

    protected override function initLanguageRussian():void
    {
        super.initLanguageRussian();

        {//overrides
//            _currentLanguage[EStringTypeBWF.EST_SOCIAL_WALLPOST_TEXT_SHARE] = 'Еще один кроссворд разгадан! Я жду вас на моей станции. Игра "Станция кроссвордов"';
//            _currentLanguage[EStringTypeBWF.EST_SOCIAL_WALLPOST_TEXT_HELP] = 'Помоги мне разгадать кроссворд! Заходи и играй вместе со мной!';

        }

        //popup help
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_0_0] = "Приветствуем тебя в игре \"Станция Кроссвордов\"! Заходи на станцию и отгадывай  кроссворды.";
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_1_0] = "Вопрос";
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_1_1] = "Картинка-подсказка";
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_1_2] = "Поле для ответа";
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_1_3] = "Буквы для ответа";
//        _currentLanguage[EStringType.EST_POPUP_HELP_TOOLTIP_2_0] = "Для того чтобы просмотреть \nкроссворд полностью нажмите \nкнопкой мыши на любую ячейку \nкроссворда и тяните в нужном \nнаправлении.";

        //game
//        _currentLanguage[EStringType.EST_GAME_BUTTON_FRIEND_HELP] = "Помощь\nдруга";
//        _currentLanguage[EStringType.EST_GAME_BUTTON_OPEN_ALL_WORDS] = "Открыть\nслова";
//        _currentLanguage[EStringType.EST_GAME_BUTTON_OPEN_WORD] = "Открыть\nслово";
//        _currentLanguage[EStringType.EST_GAME_BUTTON_OPEN_CHAR] = "Открыть\nбукву";
//        _currentLanguage[EStringType.EST_GAME_BUTTON_NEXT_LEVEL] = "Следующий";


        //map
//        _currentLanguage[EStringType.EST_MAP_STATION_CLOSED_TOOLTIP_TITLE] = "Закрыто";
//        _currentLanguage[EStringType.EST_MAP_STATION_CLOSED_TOOLTIP_TEXT0] = "Требуется";
//        _currentLanguage[EStringType.EST_MAP_STATION_CLOSED_TOOLTIP_TEXT1_FRIENDS] = "{0} друзей";
//        _currentLanguage[EStringType.EST_MAP_STATION_INVITE_BUTTON] = "Пригласить";
//
//        _currentLanguage[EStringType.EST_MAP_STATION_OPEN_TEXT0] = "разгадано";
//        _currentLanguage[EStringType.EST_MAP_STATION_OPEN_TEXT1] = "{0} из {1}";
//        _currentLanguage[EStringType.EST_MAP_STATION_OPEN_BUTTON_PLAY] = "Играть";

        //widget coins
//        _currentLanguage[EStringType.EST_MAP_WIDGET_COINS_TITLE] = "Монеты";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_COINS_BUTTON_ADD] = "Добавить";
//
//        //widget friends
//        _currentLanguage[EStringType.EST_MAP_WIDGET_FRIENDS_TITLE] = "Добавить друга в игру";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_FRIENDS_COUNT_TITLE] = "Всего друзей в игре:";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_FRIENDS_BUTTON_FRIENDS_ADD] = "Добавить";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_FRIENDS_POSITION_FORMAT] = "{0} среди друзей";
//        StringUtil.substitute("{0}{1}{3}{2}", "a", "b", 1, 3); //"ab31"
        //widget top
//        _currentLanguage[EStringType.EST_MAP_WIDGET_TOP_TITLE] = "Топ игроков";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_TOP_BUTTON] = "Топ";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_TOP_BUTTON_SHARE] = "Похвастаться";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_TOP_POSITION_FORMAT] = "Вы {0}";

        //widget stars
//        _currentLanguage[EStringType.EST_MAP_WIDGET_STARS_TITLE] = "Кроссвордов угадано";
//        _currentLanguage[EStringType.EST_MAP_WIDGET_STARS_CROSSWORDS_TOTAL] = "Всего кроссвордов";

        //purchases
//            _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE0] = "покупка 1";
//            _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE1] = "покупка 2";
//            _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE2] = "покупка 3";
//            _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE3] = "покупка 4";
    }

}
}
