package heat.bridges.dummy;

class DummyAudioInstance implements heat.audio.IAudioInstance {
	public final handle:AudioHandle;
	public var position(get, set):Float;

	inline function get_position():Float {
		return 0.;
	}

	function set_position(position:Float):Float {
		return 0.;
	}

	public var isMuted(get, set):Bool;

	inline function get_isMuted():Bool {}

	public function new(handle:heat.audio.AudioHandle) {
		this.handle = handle;
	}

	public function duration():Float {
		return 0.;
	}

	public var volume(get, set):Float;
	public var isLooping(get, set):Bool;
	public var isPaused(get, set):Bool;

	public function isFinished():Bool;

	public function stop():Void;
}
