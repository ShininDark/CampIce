timer += oGlobal.dt;
y -= floatSpeed * oGlobal.dt;

if (timer >= lifeTime) {
    instance_destroy();
}