package heat;

using heat.HeatPrelude;

class NullBridge {
	var space:Null<HeatSpace>;

	public function new() {}

	public function attach(space:HeatSpace) {
		this.space = space;
	}

	public function go() {
		var tstamp = haxe.Timer.stamp();
		while (true) {
			var nextTStamp = haxe.Timer.stamp();
			var dt = nextTStamp - tstamp;
			space.update(dt);
			tstamp = nextTStamp;
		}
	}
}
