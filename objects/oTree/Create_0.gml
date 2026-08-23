treeType = "oak";   // default creation value to prevent crash, overridden by instance creation code
treeHealth = 3;     // default value
sellValue = 5;          // default value

treeHealthMax = treeHealth;
isMining = false;

function setupTree(){
    switch (treeType){
        case "oak":
            sprite_index = sOakTree;
            sellValue = 5;
            treeHealth = 3;
            break;
        case "birch":
            sprite_index = sBirchTree;
            sellValue = 15;
            treeHealth = 5;
            break;
        case "maple":
            sprite_index = sMapleTree;
            sellValue = 30;
            treeHealth = 7;
            break;
    }
}
