package heat.audio;

interface IAudioInstance {
	public final handle:AudioHandle;
	public var position(get, set):Float;
	public var isMuted(get, set):Bool;
	public function duration():Float;
	public var volume(get, set):Float;
	public var isLooping(get, set):Bool;
	public var isPaused(get, set):Bool;
	public function isFinished():Bool;
	public function stop():Void;
}
