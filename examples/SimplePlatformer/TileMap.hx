using heat.HeatPrelude;
using heat.transform.TransformSys;

typedef TileData = {
	tileId:Int,
	entityId:EntityId
}

class TileMap {
	final tileData:Map2D<Int, Int, TileData> = new Map2D();
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

	public function build(space:heat.I_UsesHeatStandardPlugin) {
		final rootId = space.getNextID();
		space.makeTransformBundle(rootId);
		for (coords => tileDatum in tileData) {
			final id = space.getNextID();
			space.makeTransformBundle(id, CUSTOM({x: coords.e0 * tileSize.x, y: coords.e1 * tileSize.y}));
			space.setParent(id, rootId);
			final texRegion = new TextureRegion(None, 0, 0, tileSize.x, tileSize.y, 0, 0);
			texRegion.handle = tileIdToTexture(tileDatum.tileId);
			space.com.textureRegions.set(id, texRegion);
		}
	}

	public function applyToTiles(f:(coords:Tuple2<Int, Int>, datum:TileData) -> Void) {
		for (coords => datum in tileData) {
			f(coords, datum);
		}
	}
}
