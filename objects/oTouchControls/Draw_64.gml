if (!isMobile) exit;
if (instance_exists(oScenes) && oScenes.active) exit;
if (global.gamePaused) exit;

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

var nearColdLamp = false;

if (instance_exists(oPlayer)) {
    var lamp = instance_nearest(oPlayer.x, oPlayer.y, oColdLamp);

    if (
        lamp != noone &&
        lamp.isLit &&
        point_distance(
            oPlayer.x,
            oPlayer.y,
            lamp.x,
            lamp.y
        ) < lamp.interactRadius
    ) {
        nearColdLamp = true;
    }
}

// Joystick
joyBaseY = guiH - 110;

// Right-side buttons
var attackX = guiW - 100;
var attackY = guiH - 105;

var interactX = guiW - 235;
var interactY = guiH - 105;

var anchorX = guiW - 100;
var anchorY = guiH - 245;

var inventoryX = guiW - 235;
var inventoryY = guiH - 245;

// Pause
var pauseX = guiW - 60;
var pauseY = 60;
var pauseRadius = 34;


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// Outer shadow
draw_set_alpha(0.18);
draw_circle_color(
    joyBaseX,
    joyBaseY + 4,
    joyRadius + 5,
    c_black,
    c_black,
    false
);

// Outer ring
draw_set_alpha(0.28);
draw_circle_color(
    joyBaseX,
    joyBaseY,
    joyRadius,
    c_white,
    c_white,
    false
);

// Inner area
draw_set_alpha(0.12);
draw_circle_color(
    joyBaseX,
    joyBaseY,
    joyRadius - 8,
    c_black,
    c_black,
    false
);

// Knob shadow
draw_set_alpha(0.25);
draw_circle_color(
    joyKnobX,
    joyKnobY + 3,
    joyRadius * 0.45 + 3,
    c_black,
    c_black,
    false
);

// Knob
draw_set_alpha(0.65);
draw_circle_color(
    joyKnobX,
    joyKnobY,
    joyRadius * 0.45,
    c_white,
    c_white,
    false
);


// Attack
draw_set_alpha(0.20);
draw_circle_color(
    attackX,
    attackY + 4,
    btnRadius + 4,
    c_black,
    c_black,
    false
);

draw_set_alpha(0.38);
draw_circle_color(
    attackX,
    attackY,
    btnRadius,
    c_white,
    c_white,
    false
);

draw_set_alpha(0.12);
draw_circle_color(
    attackX,
    attackY,
    btnRadius - 7,
    c_black,
    c_black,
    false
);


// Interact
draw_set_alpha(0.20);
draw_circle_color(
    interactX,
    interactY + 4,
    btnRadius + 4,
    c_black,
    c_black,
    false
);

draw_set_alpha(0.38);
draw_circle_color(
    interactX,
    interactY,
    btnRadius,
    c_white,
    c_white,
    false
);

draw_set_alpha(0.12);
draw_circle_color(
    interactX,
    interactY,
    btnRadius - 7,
    c_black,
    c_black,
    false
);


// Inventory
draw_set_alpha(0.20);
draw_circle_color(
    inventoryX,
    inventoryY + 4,
    btnRadius + 4,
    c_black,
    c_black,
    false
);

draw_set_alpha(0.38);
draw_circle_color(
    inventoryX,
    inventoryY,
    btnRadius,
    c_white,
    c_white,
    false
);

draw_set_alpha(0.12);
draw_circle_color(
    inventoryX,
    inventoryY,
    btnRadius - 7,
    c_black,
    c_black,
    false
);


// Anchor
draw_set_alpha(0.20);
draw_circle_color(
    anchorX,
    anchorY + 4,
    btnRadius + 4,
    c_black,
    c_black,
    false
);

draw_set_alpha(0.38);
draw_circle_color(
    anchorX,
    anchorY,
    btnRadius,
    c_white,
    c_white,
    false
);

draw_set_alpha(0.12);
draw_circle_color(
    anchorX,
    anchorY,
    btnRadius - 7,
    c_black,
    c_black,
    false
);


draw_set_alpha(0.9);
draw_set_color(c_white);

draw_set_font(-1);

// Attack
draw_text(
    attackX,
    attackY,
    "⚔"
);

// Interact
draw_text(
    interactX,
    interactY,
    nearColdLamp ? "Ctrl" : "E"
);

// Inventory
draw_text(
    inventoryX,
    inventoryY,
    "▣"
);

// Anchor
draw_text(
    anchorX,
    anchorY,
    "⚓"
);


// Shadow
draw_set_alpha(0.20);
draw_circle_color(
    pauseX,
    pauseY + 3,
    pauseRadius + 3,
    c_black,
    c_black,
    false
);

// Button
draw_set_alpha(0.40);
draw_circle_color(
    pauseX,
    pauseY,
    pauseRadius,
    c_white,
    c_white,
    false
);

// Inner
draw_set_alpha(0.12);
draw_circle_color(
    pauseX,
    pauseY,
    pauseRadius - 6,
    c_black,
    c_black,
    false
);

// Pause symbol
draw_set_alpha(0.9);
draw_set_color(c_white);

draw_rectangle(
    pauseX - 8,
    pauseY - 9,
    pauseX - 3,
    pauseY + 9,
    false
);

draw_rectangle(
    pauseX + 3,
    pauseY - 9,
    pauseX + 8,
    pauseY + 9,
    false
);


draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);