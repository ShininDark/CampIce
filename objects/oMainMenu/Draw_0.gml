draw_self();

var hoveredPlay = point_in_rectangle(mouse_x, mouse_y, playX1, playY1, playX2, playY2);
var hoveredLoad = point_in_rectangle(mouse_x, mouse_y, loadX1, loadY1, loadX2, loadY2);
var hoveredExit = point_in_rectangle(mouse_x, mouse_y, exitX1, exitY1, exitX2, exitY2);
var hoveredSettings = point_in_rectangle(mouse_x, mouse_y, settingsX1, settingsY1, settingsX2, settingsY2);

draw_set_alpha(0.25);

if (hoveredPlay) draw_rectangle_color(playX1, playY1, playX2, playY2, c_gray, c_gray, c_gray, c_gray, false);
if (hoveredLoad) draw_rectangle_color(loadX1, loadY1, loadX2, loadY2, c_gray, c_gray, c_gray, c_gray, false);
if (hoveredExit) draw_rectangle_color(exitX1, exitY1, exitX2, exitY2, c_gray, c_gray, c_gray, c_gray, false);
if (hoveredSettings) draw_rectangle_color(settingsX1, settingsY1, settingsX2, settingsY2, c_gray, c_gray, c_gray, c_gray, false);

draw_set_alpha(1);

if (menuNoticeTimer > 0) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((loadX1+loadX2)/2, loadY2 + 30, menuNotice);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}