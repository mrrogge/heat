package heat.bridges.dummy;

import heat.audio.AudioHandle;

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

	var _isMuted = false;

	inline function get_isMuted():Bool {
		return _isMuted;
	}

	function set_isMuted(isMuted:Bool):Bool {
		_isMuted = isMuted;
		return _isMuted;
	}

	public function new(handle:heat.audio.AudioHandle) {
		this.handle = handle;
	}

	public function duration():Float {
		return 0.;
	}

	public var volume(get, set):Float;

	var _volume = 0.;

	inline function get_volume():Float {
		return _volume;
	}

	function set_volume(volume:Float):Float {
		_volume = volume;
		return _volume;
	}

	public var isLooping(get, set):Bool;

	var _isLooping = false;

	inline function get_isLooping():Bool {
		return _isLooping;
	}

	function set_isLooping(isLooping:Bool):Bool {
		_isLooping = isLooping;
		return _isLooping;
	}

	public var isPaused(get, set):Bool;

	var _isPaused = false;

	inline function get_isPaused():Bool {
		return _isPaused;
	}

	function set_isPaused(isPaused:Bool):Bool {
		_isPaused = isPaused;
		return _isPaused;
	}

	public function isFinished():Bool {
		return true;
	}

	public function stop():Void {}
}
