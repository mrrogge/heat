using heat.HeatPrelude;

class TileMap {
	final ids:Map<VectorInt2, Int>;
	final tileSize:VectorFloat2;

	public function new(tileSize:VectorFloat2) {
		ids = [];
		this.tileSize = tileSize;
	}
}
