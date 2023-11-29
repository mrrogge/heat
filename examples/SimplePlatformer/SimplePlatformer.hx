using heat.HeatPrelude;

class SimplePlatformer {
    public static function main() {
        new SimplePlatformer();
    }

    var space = new MyHeatSpace();
    var bridge = new heat.bridges.heaps.HeapsBridge();

    public function new() {
        bridge.attach(space);
        final camId = space.getNextID();
        final camTX = new heat.core.MTransform();
        camTX.initTranslate(0, 0);
        space.com.camera.set(camId, new heat.core.Camera());
        space.com.drawOrder.set(camId, 0);
        space.com.transform.set(camId, camTX);
        space.com.absPosTransform.set(camId, camTX.clone());

        final squareId1 = space.getNextID();
        final tx1 = new heat.core.MTransform();
        tx1.initTranslate(10, 10);
        space.com.transform.set(squareId1, tx1);
        space.com.absPosTransform.set(squareId1, tx1.clone());
        space.com.drawOrder.set(squareId1, 0);
        space.com.names.set(squareId1, "thing1");

        final squareId2 = space.getNextID();
        final tx2 = new heat.core.MTransform();
        tx2.initTranslate(50, 50);
        space.com.transform.set(squareId2, tx2);
        final absTx2 = new heat.core.MTransform();
        space.com.absPosTransform.set(squareId2, absTx2);
        space.com.drawOrder.set(squareId2, 0);
        space.com.names.set(squareId2, "thing2");
        space.setParent(squareId2, squareId1);
    }
}

class MyHeatSpace extends HeatSpace {
    final cameraQuery = new ComQuery();

    public function new() {
        super();
        cameraQuery.with(com.camera).with(com.absPosTransform);
    }

    override function onKeyPressed(keyCode:KeyCode) {
        switch (keyCode) {
            case A: {
                moveThing("thing1", -20., 0.);
            }
            case D: {
                moveThing("thing1", 20., 0.);
            }
            case W: {
                moveThing("thing1", 0., -20.);
            }
            case S: {
                moveThing("thing1", 0., 20.);
            }
            case LEFT: {
                moveThing("thing2", -20., 0.);
            }
            case RIGHT: {
                moveThing("thing2", 20., 0.);
            }
            case UP: {
                moveThing("thing2", 0., -20.);
            }
            case DOWN: {
                moveThing("thing2", 0., 20.);
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

    function moveThing(name: String, x: Float, y: Float) {
        final query = new ComQuery().whereEqualTo(com.names, name)
            .with(com.transform);
        query.run();
        for (id in query.result) {
            com.transform.get(id).x += x;
            com.transform.get(id).y += y;
        }
    }
}