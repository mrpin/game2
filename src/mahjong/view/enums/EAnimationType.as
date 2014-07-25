/**
 * Created by evgenyyurko on 7/15/14.
 */
package mahjong.view.enums
{
public class EAnimationType
{
    public static const EAT_SAT:String = "sad";
    public static const EAT_EAT:String = "eat";
    public static const EAT_YAWNS:String = "yawns";
    public static const EAT_WAVES:String = "waves";
    public static const EAT_FISH:String = "fish";

    public static var animationsForMainItems:Array =
            [
                EAT_SAT,
                EAT_FISH,
                EAT_YAWNS,
                EAT_WAVES,
                EAT_WAVES
//                EAT_EAT
            ];
}
}
