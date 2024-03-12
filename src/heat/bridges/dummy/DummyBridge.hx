package heat.bridges.dummy;

using heat.HeatPrelude;

class DummyBridge implements heat.audio.IAudioBridge {
	final space:heat.core.HeatSpace;

	public function new(space:heat.core.HeatSpace) {
		this.space = space;
	}

	public function playAudio(source:heat.audio.AudioSource):heat.core.Result<heat.audio.IAudioInstance, String> {
		return new DummyAudioInstance(source.handle);
	}
}
