var inRange = instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius;

if (inRange && keyboard_check_pressed(ord("E"))) {
    shopOpen = !shopOpen;
}

if (!inRange && shopOpen) {
    shopOpen = false; // walking away closes the shop
}