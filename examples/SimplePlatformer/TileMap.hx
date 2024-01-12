using heat.HeatPrelude;
using heat.transform.TransformSys;

typedef TileData = {
	tileId:Int,
	?entityId:EntityId
}

class TileMap {
	final tileData:Map<Int, Map<Int, TileData>> = [];
	final tileSize:VectorFloat2;

	public function new(tileSize:VectorFloat2) {
		this.tileSize = tileSize;
	}

	function tileIdToTexture(id:Int):TextureHandle {
		return switch (id) {
			case 0: TextureHandle.None;
			case 1: TextureHandle.Color(heat.core.Color.GREEN);
			case 2: TextureHandle.Color(heat.core.Color.RED);
			default: TextureHandle.None;
		}
	}

	public function addTile(colIdx: Int, rowIdx: Int, tileId:Int):TileMap {
		var cols = tileData.get(colIdx);
		if (cols == null) {
			cols = [];
			tileData.set(colIdx, cols);
		}
		if (cols.exists(rowIdx)) {
			cols.get(rowIdx).tileId = tileId;
		}
		else {
			cols.set(rowIdx, {tileId: tileId});
		}
		return this;
	}

	public function build(space:SimplePlatformerSpace) {
		final rootId = space.getNextID();
		space.makeTransformBundle(rootId);
		space.game.tileMaps.set(rootId, this);
		for (colIdx => col in tileData) {
			for (rowIdx => datum in col) {
			final id = space.getNextID();
			datum.entityId = id;
			space.makeTransformBundle(id, CUSTOM({x: colIdx * tileSize.x, y: rowIdx * tileSize.y}));
			space.setParent(id, rootId);
			final texRegion = new TextureRegion(None, 0, 0, tileSize.x, tileSize.y, 0, 0);
			texRegion.handle = tileIdToTexture(datum.tileId);
			space.com.textureRegions.set(id, texRegion);
			}
		}
	}

	public function applyToTiles(f:(colIdx:Int, rowIdx:Int, datum:TileData) -> Void) {
		for (colIdx => col in tileData) {
			for (rowIdx => datum in col) {
				f(colIdx, rowIdx, datum);
			}
		}
	}
}
