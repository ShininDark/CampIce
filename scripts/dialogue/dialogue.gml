function startDialogue(linesArr, callback = noone) {
    show_debug_message("startDialogue called, oDialogue exists: " + string(instance_exists(oDialogue)));
    with (oDialogue) {
        active = true;
        lines = linesArr;
        lineIndex = 0;
        onComplete = callback;
    }
}