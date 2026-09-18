if (!isMobile) exit;
if (instance_exists(oScenes) && oScenes.active) exit;
if (global.gamePaused) exit;

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

joyBaseY = guiH - 110;
joyKnobY = joyBaseY;

// Right side - spaced vertically
var attackX = guiW - 100;
var attackY = guiH - 105;

var interactX = guiW - 235;
var interactY = guiH - 105;

var anchorX = guiW - 100;
var anchorY = guiH - 245;

var inventoryX = guiW - 235;
var inventoryY = guiH - 245;

// Pause - top right
var pauseX = guiW - 65;
var pauseY = 65;

var pauseRadius = 38;


global.touchAttackPressed = false;
global.touchInventoryPressed = false;
global.touchAnchorPressed = false;
global.touchPausePressed = false;
global.touchInteractPressed =  false;

var joyStillDown = false;
var attackStillDown = false;
var interactStillDown = false;
var inventoryStillDown = false;
var anchorStillDown = false;
var pauseStillDown = false;

var touchCount = 5;

for (var i = 0; i < touchCount; i++) {

    var tx = device_mouse_x_to_gui(i);
    var ty = device_mouse_y_to_gui(i);

    var down = device_mouse_check_button(i, mb_left);

    if (!down) continue;

    if (
        joyTouchSlot == i ||
        (
            joyTouchSlot == -1 &&
            point_distance(tx, ty, joyBaseX, joyBaseY) <= joyRadius * 1.5
        )
    ) {

        if (joyTouchSlot == -1) {
            joyTouchSlot = i;
        }

        joyStillDown = true;

        var dist = min(
            point_distance(joyBaseX, joyBaseY, tx, ty),
            joyRadius
        );

        var dir = point_direction(
            joyBaseX,
            joyBaseY,
            tx,
            ty
        );

        joyKnobX = joyBaseX + lengthdir_x(dist, dir);
        joyKnobY = joyBaseY + lengthdir_y(dist, dir);

        global.touchMoveX =
            (joyKnobX - joyBaseX) / joyRadius;

        global.touchMoveY =
            (joyKnobY - joyBaseY) / joyRadius;

        continue;
    }

    if (
        attackTouchSlot == i ||
        (
            attackTouchSlot == -1 &&
            point_distance(tx, ty, attackX, attackY) <= btnRadius
        )
    ) {

        if (attackTouchSlot == -1) {
            attackTouchSlot = i;
            global.touchAttackPressed = true;
        }

        attackStillDown = true;
        continue;
    }

    // Interact button
    if (
        (interactTouchSlot == i || interactTouchSlot == -1) &&
        point_distance(tx, ty, interactX, interactY) <= btnRadius
    ) {
        if (interactTouchSlot == -1) {
            interactTouchSlot = i;
            global.touchInteractPressed = true;
        }
    
        interactStillDown = true;
        global.touchInteractHeld = true;
        continue;
    }

    if (
        inventoryTouchSlot == i ||
        (
            inventoryTouchSlot == -1 &&
            point_distance(tx, ty, inventoryX, inventoryY) <= btnRadius
        )
    ) {

        if (inventoryTouchSlot == -1) {
            inventoryTouchSlot = i;
            global.touchInventoryPressed = true;
        }

        inventoryStillDown = true;
        continue;
    }

    if (
        anchorTouchSlot == i ||
        (
            anchorTouchSlot == -1 &&
            point_distance(tx, ty, anchorX, anchorY) <= btnRadius
        )
    ) {

        if (anchorTouchSlot == -1) {
            anchorTouchSlot = i;
            global.touchAnchorPressed = true;
        }

        anchorStillDown = true;
        continue;
    }

    if (
        pauseTouchSlot == i ||
        (
            pauseTouchSlot == -1 &&
            point_distance(tx, ty, pauseX, pauseY) <= pauseRadius
        )
    ) {

        if (pauseTouchSlot == -1) {
            pauseTouchSlot = i;
            global.touchPausePressed = true;
        }

        pauseStillDown = true;

        continue;
    }
}

if (!joyStillDown) {

    joyTouchSlot = -1;

    joyKnobX = joyBaseX;
    joyKnobY = joyBaseY;

    global.touchMoveX = 0;
    global.touchMoveY = 0;
}

if (!attackStillDown)
    attackTouchSlot = -1;

if (!interactStillDown) {
    interactTouchSlot = -1;
    global.touchInteractHeld = false;
}

if (!inventoryStillDown)
    inventoryTouchSlot = -1;

if (!anchorStillDown)
    anchorTouchSlot = -1;

if (!pauseStillDown)
    pauseTouchSlot = -1;