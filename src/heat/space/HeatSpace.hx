package heat.space;

class HeatSpace implements heat.I_MinimalHeatSpace {
	public var lastID(default, null):Null<heat.ecs.EntityId> = null;
	public final onKeyPressedSlot:heat.event.Slot<heat.key.KeyCode>;
	public final onKeyReleasedSlot:heat.event.Slot<heat.key.KeyCode>;
	public final windowResizeRequestedSignal:heat.event.ISignal<heat.core.window.Window.WindowResizeRequest>;

	final windowResizeRequestedEmitter = new heat.event.SignalEmitter<heat.core.window.Window.WindowResizeRequest>();

	public function new() {
		onKeyPressedSlot = new heat.HeatPrelude.Slot(onKeyPressed);
		onKeyReleasedSlot = new heat.HeatPrelude.Slot(onKeyReleased);
		windowResizeRequestedSignal = windowResizeRequestedEmitter.signal;
	}

	// basics

	public function getNextID():heat.ecs.EntityId {
		lastID = lastID == null ? 0 : lastID + 1;
		return lastID;
	}

	public function update(dt:Float) {}

	// key input

	function onKeyPressed(keyCode:heat.HeatPrelude.KeyCode) {}

	function onKeyReleased(keyCode:heat.HeatPrelude.KeyCode) {}

	// graphics

	public dynamic function makeTextGraphic():heat.text.ITextGraphic {
		return new heat.bridges.dummy.DummyTextGraphic();
	}

	public dynamic function getDrawCallCount():Int {
		return 0;
	}

	public dynamic function getFPS():Float {
		return 0;
	}

	public dynamic function makeWindow():heat.core.Result<heat.core.Tuple2<heat.graphics.IWindow, heat.graphics.WindowIndex>, String> {
		return Err("Not implemented");
	}

	public dynamic function destroyWindow(index:heat.graphics.WindowIndex):heat.core.Result<heat.core.Noise, String> {
		return Ok(Noise);
	}

	// audio
	public dynamic function playAudio(source:heat.audio.AudioSource):heat.core.Result<heat.audio.IAudioInstance, String> {
		return Err("Not implemented");
	}
}
