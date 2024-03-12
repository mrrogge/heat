package heat.audio;

interface IAudioBridge {
	public function playAudio(source:AudioSource):heat.core.Result<IAudioInstance, String>;
}
