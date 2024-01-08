using heat.HeatPrelude;
using heat.transform.TransformSys;

@:build(SimplePlatformerPlugin.apply())
@:build(heat.std.StandardPlugin.apply())
class SimplePlatformerSpace extends HeatSpace implements heat.I_UsesHeatStandardPlugin implements heat.I_UsesSimplePlatformerPlugin {
	final cameraQuery = new ComQuery();
	final transformQuery = new ComQuery();
	final heroQuery = new ComQuery();

	public function new() {
		super();

		cameraQuery.with(com.camera).with(com.absPosTransform);
		transformQuery.with(com.transform);
		heroQuery.with(game.heroMap);

		final worldCamId = getNextID();
		CameraSys.makeCameraBundle(this, worldCamId);
		final worldCamFilterQuery = new ComQuery().with(game.worldObjects);
		com.camera.get(worldCamId).idFilter = (id:EntityId) -> {
			return worldCamFilterQuery.checkId(id);
		};

		final uiCamId = getNextID();
		CameraSys.makeCameraBundle(this, uiCamId);
		final uiCamFilterQuery = new ComQuery().with(game.uiObjects);
		com.camera.get(uiCamId).idFilter = (id:EntityId) -> {
			return uiCamFilterQuery.checkId(id);
		};

		final heroID = getNextID();
		TransformSys.makeTransformBundle(this, heroID, CUSTOM({x: 10, y: 10}));
		com.drawOrder.set(heroID, 0);
		final heroTexture = new TextureRegion(None, 0, 0, 32, 48);
		com.textureRegions.set(heroID, heroTexture);
		heroTexture.handle = TextureHandle.Other(hxd.Res.girl_png);
		heroTexture.center();
		game.heroMap.set(heroID, Noise);
		game.heroMoveStates.set(heroID, new HeroMoveState());
		game.worldObjects.set(heroID, Noise);
	}

	override function update(dt:Float) {
		HeroSys.update(this, dt);
		heat.ui.FlexBoxSys.update(this, dt);
		this.syncAbsPos();
	}

	override function onKeyPressed(keyCode:KeyCode) {
		HeroSys.onKeyEvent(this, keyCode, PRESSED);
		trace(keyCode);
	}

	override function onKeyReleased(keyCode:KeyCode) {
		HeroSys.onKeyEvent(this, keyCode, RELEASED);
		trace(keyCode);
	}

	function translateCamera(x:Float, y:Float) {
		cameraQuery.run();
		for (id in cameraQuery.result) {
			com.absPosTransform.get(id).x += x;
			com.absPosTransform.get(id).y += y;
		}
	}
}
