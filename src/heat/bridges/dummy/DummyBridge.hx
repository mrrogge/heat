package heat.bridges.dummy;

using heat.HeatPrelude;

class DummyBridge {
	final space:heat.I_MinimalHeatSpace;

	public function new(space:heat.I_MinimalHeatSpace, periodMS:Int) {
		this.space = space;
		final timer = new haxe.Timer(periodMS);
		timer.run = () -> {
			space.update(periodMS / 1000.);
		}
	}
}
