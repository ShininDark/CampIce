function spawnFloatingText(xx, yy, txt, col = c_white) {
    var ft = instance_create_layer(xx, yy, "Instances", oFloatingText);
    ft.text = txt;
    ft.color = col;
    return ft;
}