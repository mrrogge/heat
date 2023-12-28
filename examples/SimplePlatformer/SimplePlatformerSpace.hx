using heat.HeatPrelude;

@:build(SimplePlatformerPlugin.apply())
class SimplePlatformerSpace extends heat.std.HeatSpaceStd {
	final cameraQuery = new ComQuery();
	final transformQuery = new ComQuery();
	final heroQuery = new ComQuery();

	function makeCameraBundle(id:EntityId, template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		makeTransformBundle(id, template);
		com.camera.set(id, new heat.core.Camera());
		com.drawOrder.set(id, 0);
	}

	function makeTransformBundle(id:EntityId, template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		final tx = new MTransform();
		com.transform.set(id, tx);
		com.absPosTransform.set(id, tx.clone());
		switch (template) {
			case DEFAULT:
				{}
			case CUSTOM(template):
				{
					tx.x = template.x;
					tx.y = template.y;
				}
		}
	}

	public function new() {
		super();

		cameraQuery.with(com.camera).with(com.absPosTransform);
		transformQuery.with(com.transform);
		heroQuery.with(game.heroMap);

		final worldCamId = getNextID();
		makeCameraBundle(worldCamId);
		final worldCamFilterQuery = new ComQuery().with(game.worldObjects);
		com.camera.get(worldCamId).idFilter = (id:EntityId) -> {
			return worldCamFilterQuery.checkId(id);
		};

		final uiCamId = getNextID();
		makeCameraBundle(uiCamId);
		final uiCamFilterQuery = new ComQuery().with(game.uiObjects);
		com.camera.get(uiCamId).idFilter = (id:EntityId) -> {
			return uiCamFilterQuery.checkId(id);
		};

		final heroID = getNextID();
		makeTransformBundle(heroID, CUSTOM({x: 10, y: 10}));
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
