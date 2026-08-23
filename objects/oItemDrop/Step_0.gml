// scatter/bounce settle
if (abs(hspBounce) > 0.05 || abs(vspBounce) > 0.05) {
    x += hspBounce;
    y += vspBounce;
    hspBounce *= bounceFriction;
    vspBounce *= bounceFriction;
}

// pop-in scale animation
image_xscale = lerp(image_xscale, 1, 0.2);
image_yscale = lerp(image_yscale, 1, 0.2);

// pickup delay
if (!canPickup) {
    pickupTimer += oGlobal.dt;
    if (pickupTimer >= pickupDelay) {
        canPickup = true;
    }
}

// pickup check
if (canPickup && instance_exists(oPlayer)) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) < pickupRadius) {
        addItem(itemDef, amount);
        instance_destroy();
    }
}