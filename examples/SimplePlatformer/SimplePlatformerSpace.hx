using heat.HeatPrelude;

@:build(SimplePlatformerPlugin.build())
class SimplePlatformerSpace extends HeatSpace {
    final cameraQuery = new ComQuery();
    final transformQuery = new ComQuery();
    final heroQuery = new ComQuery();

    public function new() {
        super();

        cameraQuery.with(com.camera).with(com.absPosTransform);
        transformQuery.with(com.transform);
        heroQuery.with(heroMap);

        final camId = getNextID();
        final camTX = new heat.core.MTransform();
        camTX.initTranslate(0, 0);
        com.camera.set(camId, new heat.core.Camera());
        com.drawOrder.set(camId, 0);
        com.transform.set(camId, camTX);
        com.absPosTransform.set(camId, camTX.clone());

        final heroID = getNextID();
        final tx1 = new heat.core.MTransform();
        tx1.initTranslate(10, 10);
        com.transform.set(heroID, tx1);
        com.absPosTransform.set(heroID, tx1.clone());
        com.drawOrder.set(heroID, 0);
        com.textureRegions.set(heroID, new heat.texture.TextureRegion(
            heat.texture.TextureHandle.Other(hxd.Res.girl_png), 0, 0, 32, 48
        ));
        heroMap.set(heroID, Noise);

    }

    override function onKeyPressed(keyCode:KeyCode) {
        switch (keyCode) {
            case A, LEFT: {
                moveHero(-20., 0.);
            }
            case D, RIGHT: {
                moveHero(20., 0.);
            }
            case W, UP: {
                moveHero(0., -20.);
            }
            case S, DOWN: {
                moveHero(0., 20.);
            }
            default: {}
        }
        trace(keyCode);
    }

    function translateCamera(x: Float, y:Float) {
        cameraQuery.run();
        for (id in cameraQuery.result) {
            com.absPosTransform.get(id).x += x;
            com.absPosTransform.get(id).y += y;
        }
    }

    function moveThing(id: EntityId, x: Float, y: Float) {
        if (!transformQuery.checkId(id)) return;
        com.transform.get(id).x += x;
        com.transform.get(id).y += y;
    }

    function moveHero(x: Float, y: Float) {
        heroQuery.run();
        for (id in heroQuery.result) {
            moveThing(id, x, y);
        }
    }
}