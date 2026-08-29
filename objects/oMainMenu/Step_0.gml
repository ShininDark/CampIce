if (global.gamePaused) exit;

var clicked = mouse_check_button_pressed(mb_left);

if (point_in_rectangle(mouse_x, mouse_y, playX1, playY1, playX2, playY2) && clicked) {
    startSceneSequence([
        { image: sIntro1, lines: ["On a random day, you're flying a plane. Suddenly you reach an extremely hot place where your plane starts to melt and malfunction.."] },
        { image: sIntro2, lines: ["Your plane crashes and you fall into the extremely hot place. Luckily for you, a mysterious person comes to your aid and saves you..."] },
        { image: sIntro3, lines: ["The mysterious person gives you a CAMPICE that will keep you cold in that hot place. He asks you to go gather resources and bring back to him. He will then give you FALO - A snowman (portable campice)... Your Journey Begins."] }
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
    openOptionsPanel(false);
}