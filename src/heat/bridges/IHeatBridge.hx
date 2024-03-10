package heat.bridges;

interface IHeatBridge {
	public function makeTextGraphic():heat.text.ITextGraphic;
	public function getFPS():Float;
	public function getDrawCallCount():Int;
}
