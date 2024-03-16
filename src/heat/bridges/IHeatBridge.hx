package heat.bridges;

import heat.key.KeyCode;
import heat.graphics.WindowResizedEvent;
import heat.graphics.WindowIndex;
import heat.graphics.IWindow;
import heat.audio.IAudioInstance;
import heat.audio.AudioSource;

interface IHeatBridge {
	// basic
	@:allow(heat.I_MinimalHeatSpace)
	private function onAttach(space:heat.I_MinimalHeatSpace):Void;
	@:allow(heat.I_MinimalHeatSpace)
	private function onDetach():Void;
	// audio
	// public function playAudio(source:AudioSource):heat.core.Result<IAudioInstance, String>;
	// // graphics
	// public function makeTextGraphic():heat.text.ITextGraphic;
	// public function getDrawCallCount():Int;
	// public function getFPS():Float;
	// public function makeWindow():heat.core.Result<heat.core.Tuple2<IWindow, WindowIndex>, String>;
	// public function destroyWindow(index:WindowIndex):heat.core.Result<heat.core.Noise, String>;
	// public final windowResizedSignal:heat.event.ISignal<WindowResizedEvent>;
	// // key input
	// public final keyPressedSignal:heat.event.ISignal<KeyCode>;
	// public final keyReleasedSignal:heat.event.ISignal<KeyCode>;
}

class TempBridge {
	final space:heat.I_UsesHeatStandardPlugin;

	public function new(space:heat.I_UsesHeatStandardPlugin) {
		this.space = space;
	}
}
