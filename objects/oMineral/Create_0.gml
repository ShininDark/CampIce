mineralType = "coal";   // default creation value to prevent crash, overridden by instance creation code
mineralHealth = 10;     // default value

function setupMineral(){
    switch (mineralType){
        case "coal":
            sprite_index = sMineralCoal;
            sellValue = 5;
            mineralHealth = 10;
            break;
        case "iron":
            sprite_index = sMineralIron;
            sellValue = 12;
            mineralHealth = 15;
            break;
        case "gold":
            sprite_index = sMineralGold;
            sellValue = 30;
            mineralHealth = 20;
            break;
    }
}
