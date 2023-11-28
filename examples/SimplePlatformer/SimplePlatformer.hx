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
        space.com.absPosTransform.set(camId, camTX);        

        final squareId1 = space.getNextID();
        final tx1 = new heat.core.MTransform();
        tx1.initTranslate(10, 10);
        space.com.absPosTransform.set(squareId1, tx1);
        space.com.drawOrder.set(squareId1, 0);

        final squareId2 = space.getNextID();
        final tx2 = new heat.core.MTransform();
        tx2.initTranslate(50, 50);
        space.com.absPosTransform.set(squareId2, tx2);
        space.com.drawOrder.set(squareId2, 0);
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
            case LEFT: {
                translateCamera(-20., 0.);
            }
            case RIGHT: {
                translateCamera(20., 0.);
            }
            case UP: {
                translateCamera(0., -20.);
            }
            case DOWN: {
                translateCamera(0., 20.);
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
}