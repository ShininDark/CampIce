// 1. Vertical bounce effect (ADD THIS)
z += z_speed;
z_speed += gravity_z;

if (z >= 0) {
    z = 0;
    if (abs(z_speed) > 1) {
        z_speed = -z_speed * 0.35; // Ground bounce dampening
    } else {
        z_speed = 0;
        gravity_z = 0;
    }
}

// 2. Scatter/bounce settle 
if (abs(hspBounce) > 0.05 || abs(vspBounce) > 0.05) {
    x += hspBounce;
    y += vspBounce;
    hspBounce *= bounceFriction;
    vspBounce *= bounceFriction;
}

// 3. Pop-in scale animation 
image_xscale = lerp(image_xscale, 1, 0.2);
image_yscale = lerp(image_yscale, 1, 0.2);

// 4. Pickup delay 
if (!canPickup) {
    pickupTimer += oGlobal.dt;
    if (pickupTimer >= pickupDelay) {
        canPickup = true;
    }
}

// 5. Pickup check 
if (canPickup && instance_exists(oPlayer)) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) < pickupRadius) {
        addItem(itemDef, amount);
        instance_destroy();
    }
}