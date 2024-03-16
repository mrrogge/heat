using heat.HeatPrelude;

class SimplePlatformer {
	public static function main() {
		new SimplePlatformer();
	}

	public function new() {
		new heat.bridges.heaps.HeapsBridge(new SimplePlatformerSpace());
	}
}
