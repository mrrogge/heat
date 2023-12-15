using heat.HeatPrelude;

@:build(SimplePlatformerPlugin.apply())
class SimplePlatformerSpace extends heat.std.HeatSpaceStd {
	final cameraQuery = new ComQuery();
	final transformQuery = new ComQuery();
	final heroQuery = new ComQuery();

	public function new() {
		super();

		cameraQuery.with(com.camera).with(com.absPosTransform);
		transformQuery.with(com.transform);
		heroQuery.with(game.heroMap);

		final camId = getNextID();
		final camTX = new heat.core.MTransform();
		camTX.initTranslate(0, 0);
		com.camera.set(camId, new heat.core.Camera());
		com.drawOrder.set(camId, 0);
		com.transform.set(camId, camTX);
		com.absPosTransform.set(camId, camTX.clone());

		final heroID = getNextID();
		final tx1 = new heat.core.MTransform();
		tx1.initTranslate(10, 10);
		com.transform.set(heroID, tx1);
		com.absPosTransform.set(heroID, tx1.clone());
		com.drawOrder.set(heroID, 0);
		com.textureRegions.set(heroID, new heat.texture.TextureRegion(heat.texture.TextureHandle.Other(hxd.Res.girl_png), 0, 0, 32, 48));
		game.heroMap.set(heroID, Noise);
		game.heroMoveStates.set(heroID, new HeroMoveState());
	}

	override function update(dt:Float) {
		HeroSys.update(this, dt);
		syncAbsPos();
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
