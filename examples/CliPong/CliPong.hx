using heat.HeatPrelude;

class CliPong {
	public static function main() {
		new CliPong();
	}

	public function new() {
		new heat.bridges.dummy.DummyBridge(new CliPongSpace(), 1000);
	}
}
