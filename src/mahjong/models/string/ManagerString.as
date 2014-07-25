/**
 * Created by evgenyyurko on 1/8/14.
 */
package mahjong.models.string
{
import core.implementations.Debug;

import models.implementations.string.ManagerStringBase;
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
    public function ManagerString(languageType:String)
    {
        super(languageType);
    }

    protected override function initCurrentLanguage(languageType:String):void
    {
        switch (languageType)
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

        //scene base ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ scene base

        //scene lobby ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ scene lobby
        _currentLanguage[EStringType.EST_LOBBY_BUTTON_GET_TIME_BONUS] = "забрать бонус";

        //scene main ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ scene main

        //scene selection level ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ scene selection level

        //scene game ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ scene game


        {//popups
            //popup top
            _currentLanguage[EStringType.EST_POPUP_TOP_WIDGET_TITLE] = "Название";
            _currentLanguage[EStringType.EST_POPUP_TOP_BUTTON] = "Зарисовка";
            _currentLanguage[EStringType.EST_POPUP_TOP_BOTTOM_LABEL_MY_PHOTO] = "Федя";
            _currentLanguage[EStringType.EST_POPUP_TOP_BOTTOM_LABEL_FRIEND] = "Степа";
            _currentLanguage[EStringType.EST_POPUP_TOP_UP_LABEL_FRIEND] = "чувак";

            //popup bank
            _currentLanguage[EStringType.EST_POPUP_BANK_WIDGET_TITLE] = "Магазин";
            _currentLanguage[EStringType.EST_POPUP_BANK_ITEM_BUTTON_BUY] = "купить";
            _currentLanguage[EStringType.EST_POPUP_BANK_ITEM_CONTENT_COUNT0] = "покупка";
            _currentLanguage[EStringType.EST_POPUP_BANK_ITEM_CONTENT_COUNT1] = "покупка";

            //popup bonus
            _currentLanguage[EStringType.EST_POPUP_BONUS_WIDGET_TITLE] = "Название";
            _currentLanguage[EStringType.EST_POPUP_BONUS_LABEL_BONUS] = "бонус";
            _currentLanguage[EStringType.EST_POPUP_BONUS_TEXT] = "Бонус дается раз в сутки при входе в игру.";
            _currentLanguage[EStringType.EST_POPUP_BONUS_BUTTON_CLOSE] = "Далее";


           // popup out of time
            _currentLanguage[EStringType.EST_POPUP_OUT_OF_TIME_BUTTON_PASS_LEVEL] = "Пройти уровень";
        }

        //purchases
        _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE0] = "покупка 1";
        _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE1] = "покупка 2";
        _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE2] = "покупка 3";
        _currentLanguage[EStringType.EST_GAME_BUTTON_PURCHASE3] = "покупка 4";
    }

}
}
