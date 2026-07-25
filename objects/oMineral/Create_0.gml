mineralType = "coal";   // default creation value to prevent crash, overridden by instance creation code

function setupMineral(){
    switch (mineralType){
        case "coal":
            sprite_index = sMineralCoal;
            sellValue = 5;
            break;
        case "iron":
            sprite_index = sMineralIron;
            sellValue = 12;
            break;
        case "gold":
            sprite_index = sMineralGold;
            sellValue = 30;
            break;
    
    }
}
