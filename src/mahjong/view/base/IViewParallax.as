/**
 * Created by evgenyyurko on 6/18/14.
 */
package mahjong.view.base
{
import flash.geom.Point;

import views.interfaces.IView;

public interface IViewParallax extends IView
{
    //distance parallax shift
    function set moveLimits(value:Point):void;

    // direction of motion parallax
    function set moveDirection(value:Point):void;

    //delay time animation
    function set duration(value:Number):void;

    //tween type
    function set typeTween(value:Function):void;
}
}
