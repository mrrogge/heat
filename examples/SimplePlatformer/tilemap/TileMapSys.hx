package tilemap;

using heat.HeatPrelude;

class TileMapSys {
	public static function buildTileMapFromSource(space:SimplePlatformerSpace, source:TileMapSource, rootId:EntityId) {
		space.makeTransformBundle(rootId);
		space.game.tileMaps.set(rootId, new TileMap(source.tileSize));
		for (colIdx => col in source.tileData) {
			for (rowIdx => datum in col) {
				final id = space.getNextID();
				space.makeTransformBundle(id, CUSTOM({x: colIdx * source.tileSize.x, y: rowIdx * source.tileSize.y}));
				space.setParent(id, rootId);
				final texRegion = new TextureRegion(None, 0, 0, source.tileSize.x, source.tileSize.y, 0, 0);
				texRegion.handle = tilekindToTexture(datum.kind);
				space.com.textureRegions.set(id, texRegion);
			}
		}
	}

	static function tilekindToTexture(kind:TileKind):TextureHandle {
		return switch (kind) {
			case None: TextureHandle.None;
			case Ground: TextureHandle.Color(heat.core.Color.GREEN);
			case Wall: TextureHandle.Color(heat.core.Color.GRAY);
		}
	}
}
