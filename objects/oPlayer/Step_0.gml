var _h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var _len = point_distance(0,0,_h,_v);
if (_len > 0){
    _h /= _len;
    _v /= _len;
}


x += _h * playerSpeed;
y += _v * playerSpeed;