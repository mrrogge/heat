package tilemap;

using heat.HeatPrelude;
using heat.transform.TransformSys;

class TileMapSource {
	public final tileData:Map<Int, Map<Int, TileData>> = [];

	public final tileSize:VectorFloat2;

	public function new(tileSize:VectorFloat2) {
		this.tileSize = tileSize;
	}

	public function addTile(colIdx:Int, rowIdx:Int, kind:TileKind, isWall:Bool):TileMapSource {
		var cols = tileData.get(colIdx);
		if (cols == null) {
			cols = [];
			tileData.set(colIdx, cols);
		}
		cols.set(rowIdx, {kind: kind, isWall: isWall});
		return this;
	}

	public function applyToTiles(f:(colIdx:Int, rowIdx:Int, datum:TileData) -> Void) {
		for (colIdx => col in tileData) {
			for (rowIdx => datum in col) {
				f(colIdx, rowIdx, datum);
			}
		}
	}
}
