package heat.graphics;

interface IGraphicsBridge {
	public function makeTextGraphic():heat.text.ITextGraphic;
	public function getDrawCallCount():Int;
	public function getFPS():Float;
	public function makeWindow():heat.core.Result<heat.core.Tuple2<IWindow, WindowIndex>, String>;
	public function destroyWindow(index:WindowIndex):heat.core.Result<heat.core.Noise, String>;
	public final windowResizedSignal:heat.event.ISignal<WindowResizedEvent>;
}
