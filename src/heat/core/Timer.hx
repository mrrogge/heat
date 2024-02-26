package heat.core;

class Timer {
	public var acc(default, null) = 0.;

	public var overflow(default, null) = 0.;

	public var period:Null<Float>;
	public var mode:TimerMode = ONCE;

	var isPaused = false;

	public var isDone(get, never):Bool;
	public var justFinished(default, null) = false;

	public function new(period:Float) {
		this.period = period;
	}

	public inline function pause() {
		isPaused = true;
	}

	public inline function resume() {
		isPaused = false;
	}

	public function update(dt:Float) {
		justFinished = false;
		if (isPaused)
			return;
		if (acc >= period) {
			switch mode {
				case REPEATING:
					{
						acc = overflow;
						overflow = 0;
					}
				case ONCE:
					{}
			}
		}
		if (acc < period) {
			acc += dt;
			runningHandler();
			if (acc >= period) {
				justFinished = true;
				overflow = acc % period;
				acc = period;
				doneHandler();
			}
		}
	}

	function get_isDone():Bool {
		return acc >= period;
	}

	public function reset() {
		acc = 0;
	}

	function runningHandler() {
		onRunning();
	}

	function doneHandler() {
		onDone();
	}

	public dynamic function onDone() {}

	public dynamic function onRunning() {}
}

enum TimerMode {
	ONCE;
	REPEATING;
}
