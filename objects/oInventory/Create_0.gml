invWidth = 6;   // slots per row
invHeight = 3;  // rows
hotbarSize = 6;


invTotal = invWidth * invHeight;
inventory = array_create(invTotal, noone);
hotbar = array_create(hotbarSize, noone);

// hover animation state, one per full-inventory slot
invAnims = array_create(invTotal);
for (var i = 0; i < array_length(invAnims); i++) {
    invAnims[i] = { size: 1 };
}

invOpen = false;