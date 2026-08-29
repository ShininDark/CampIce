if (variable_global_exists("harvestedNodeIds") && array_contains(global.harvestedNodeIds, saveId)) {
    clearCollisionAt(x, y);
    instance_destroy();
}