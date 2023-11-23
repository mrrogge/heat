using heat.HeatPrelude;

class SimplePlatformer {
    public static function main() {
        new SimplePlatformer();
    }

    var space = new MyHeatSpace();
    var bridge = new heat.bridges.heaps.HeapsBridge();

    public function new() {
        bridge.attach(space);
    }
}

class MyHeatSpace extends HeatSpace {
    override function onKeyPressed(keyCode:KeyCode) {
        trace(keyCode);
    }
}