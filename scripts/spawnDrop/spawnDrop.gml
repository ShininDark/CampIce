function spawnDrop(itemDef, amount, xx, yy) {
    var drop = instance_create_layer(xx, yy, "Instances", oItemDrop);
    drop.itemDef = itemDef;
    drop.amount = amount;
    drop.sprite_index = itemDef.dropSprite;
    return drop;
}