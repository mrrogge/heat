package heat.bridges.heaps;

import heat.audio.IAudioInstance;
import heat.audio.AudioHandle;

class HeapsAudioInstance implements IAudioInstance {
	public final handle:AudioHandle;

	final channel:hxd.snd.Channel;

	public var position(get, set):Float;

	inline function get_position():Float {
		return channel.position;
	}

	inline function set_position(position:Float):Float {
		channel.position = position;
		return channel.position;
	}

	public var isMuted(get, set):Bool;

	inline function get_isMuted():Bool {
		return channel.mute;
	}

	inline function set_isMuted(isMuted:Bool):Bool {
		channel.mute = isMuted;
		return channel.mute;
	}

	public inline function duration():Float {
		return channel.duration;
	}

	public var volume(get, set):Float;

	inline function get_volume():Float {
		return channel.volume;
	}

	inline function set_volume(volume:Float):Float {
		channel.volume = volume;
		return channel.volume;
	}

	public var isLooping(get, set):Bool;

	inline function get_isLooping():Bool {
		return channel.loop;
	}

	inline function set_isLooping(isLooping:Bool):Bool {
		channel.loop = isLooping;
		return channel.loop;
	}

	public var isPaused(get, set):Bool;

	inline function get_isPaused():Bool {
		return channel.pause;
	}

	inline function set_isPaused(isPaused:Bool):Bool {
		channel.pause = isPaused;
		return channel.pause;
	}

	public inline function isFinished():Bool {
		return channel.isReleased();
	}

	public function new(handle:AudioHandle, channel:hxd.snd.Channel) {
		this.handle = handle;
		this.channel = channel;
	}

	public inline function stop() {
		this.channel.stop();
	}
}
