isMobile = (os_type == os_android || os_type == os_ios);

joyBaseX = 105;
joyBaseY = 0;
joyRadius = 72;

joyKnobX = joyBaseX;
joyKnobY = 0;

joyActive = false;
joyTouchSlot = -1;

btnRadius = 58;

attackTouchSlot = -1;
interactTouchSlot = -1;
inventoryTouchSlot = -1;
anchorTouchSlot = -1;
pauseTouchSlot = -1;

global.touchMoveX = 0;
global.touchMoveY = 0;

global.touchAttackPressed = false;
global.touchInteractHeld = false;
global.touchInventoryPressed = false;
global.touchAnchorPressed = false;
global.touchPausePressed = false;
global.touchInteractPressed = false;