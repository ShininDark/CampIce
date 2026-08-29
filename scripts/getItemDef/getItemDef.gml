function getItemDef(typeStr) {
    typeStr = string_lower(typeStr);
    switch (typeStr) {
        case "oak":   return global.itemOak;
        case "birch": return global.itemBirch;
        case "maple": return global.itemMaple;
        case "coal":  return global.itemCoal;
        case "gold":  return global.itemGold;
        case "iron":  return global.itemIron;
        case "shard": return global.itemShard;
        default:
            show_debug_message("getItemDef: unknown type " + string(typeStr));
            return noone;
    }
}