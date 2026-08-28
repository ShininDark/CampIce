if (global.gamePaused) exit;

var clicked = mouse_check_button_pressed(mb_left);

if (point_in_rectangle(mouse_x, mouse_y, playX1, playY1, playX2, playY2) && clicked) {
    startSceneSequence([
        { image: sIntro1, lines: ["..."] },
        { image: sIntro2, lines: ["..."] },
        { image: sIntro3, lines: ["..."] }
    ], function() {
        room_goto(rMain);
    });
}

if (point_in_rectangle(mouse_x, mouse_y, loadX1, loadY1, loadX2, loadY2) && clicked) {
    show_debug_message("Load clicked — not implemented yet");
}

if (point_in_rectangle(mouse_x, mouse_y, exitX1, exitY1, exitX2, exitY2) && clicked) {
    game_end();
}

if (point_in_rectangle(mouse_x, mouse_y, settingsX1, settingsY1, settingsX2, settingsY2) && clicked) {
    show_debug_message("Settings clicked — not implemented yet");
}