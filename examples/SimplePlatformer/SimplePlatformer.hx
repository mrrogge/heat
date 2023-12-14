using heat.HeatPrelude;

class SimplePlatformer {
    public static function main() {
        new SimplePlatformer();
    }

    final bridge:heat.bridges.heaps.HeapsBridge;

    public function new() {
        bridge = new heat.bridges.heaps.HeapsBridge(() -> {
            final space = new SimplePlatformerSpace();
            bridge.attach(space, space);
        });
    }
}