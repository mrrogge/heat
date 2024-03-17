using heat.HeatPrelude;

class SimplePlatformer {
	public static function main() {
		new SimplePlatformer();
	}

	public function new() {
		new heat.bridges.heaps.HeapsBridge((bridge:heat.bridges.heaps.HeapsBridge) -> {
			bridge.attachSpace(new SimplePlatformerSpace());
		});
	}
}
