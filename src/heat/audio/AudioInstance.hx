package heat.audio;

class AudioInstance {
	public final handle:AudioHandle;
	public var position(default, null) = 0.;
	public var mute = false;

	public function new(handle:AudioHandle) {
		this.handle = handle;
	}
}
