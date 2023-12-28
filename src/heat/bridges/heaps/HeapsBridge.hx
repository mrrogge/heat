package heat.bridges.heaps;

using heat.HeatPrelude;

class HeapsBridge {
	static var KEYCODE_MAP:Null<Map<Int, KeyCode>>;

	var space:Null<IHeatSpace>;
	var spaceStd:Null<I_UsesHeatStandardPlugin>;
	var engine:Null<h3d.Engine>;
	var engineIsReady = false;

	final onReady:() -> Void;

	final onKeyPressSignal = new Signal<KeyCode>();
	final onKeyReleaseSignal = new Signal<KeyCode>();

	var onWindowResizeRequestSlot:Slot<heat.core.window.Window.WindowResizeRequest>;

	var scene:Null<h2d.Scene>;
	var dummyDrawable:Null<h2d.Drawable>;

	var cameraQuery = new ComQuery();
	var cameraSubjectQuery = new ComQuery();

	public function new(onReady:() -> Void) {
		this.onReady = onReady;

		setupKeycodeMapData();

		// placeholder slot; gets replaced once system window resource is available
		onWindowResizeRequestSlot = new Slot(function(request:heat.core.window.Window.WindowResizeRequest) {});

		hxd.System.start(initSystem);
	}

	function initSystem() {
		engine = @:privateAccess new h3d.Engine();
		engine.onReady = onEngineReady;
		engine.init();
	}

	function onEngineReady() {
		if (engine == null)
			throw new haxe.Exception("Must initialize the system first with initSystem()");
		engine.onReady = function() {};
		// TODO: handle these later
		engine.onContextLost = function() {};
		engine.onResized = function() {};

		hxd.Key.initialize();

		final window = hxd.Window.getInstance();
		window.addEventTarget(function(event:hxd.Event) {
			switch (event.kind) {
				case EKeyDown:
					{
						if (!hxd.Key.ALLOW_KEY_REPEAT && hxd.Key.isPressed(event.keyCode)) {
							return;
						}
						onKeyPressSignal.emit(KEYCODE_MAP.get(event.keyCode));
					}
				case EKeyUp:
					{
						onKeyReleaseSignal.emit(KEYCODE_MAP.get(event.keyCode));
					}
				default:
					{}
			}
		});

		onWindowResizeRequestSlot = new Slot((request:heat.core.window.Window.WindowResizeRequest) -> {
			window.resize(request.width, request.height);
		});

		scene = new h2d.Scene();
		window.addResizeEvent(scene.checkResize);

		// sets the scene to a fixed size with space around it to fill the window. Hardcoding this for now, should eventually configurable via game UI
		scene.scaleMode = LetterBox(window.width, window.height, true, Center, Center);

		dummyDrawable = @:privateAccess new h2d.Drawable(scene);

		#if js
		hxd.Res.initEmbed();
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end

		hxd.System.setLoop(function() {
			if (space == null)
				return;

			hxd.Timer.update();
			space.update(hxd.Timer.dt);

			render();
		});

		engineIsReady = true;

		onReady();
	};

	public function attach(asSpace:IHeatSpace, asSpaceStd:I_UsesHeatStandardPlugin) {
		if (this.space != null)
			throw new haxe.Exception("can only attach to one HeatSpace at a time");
		this.space = asSpace;
		this.spaceStd = asSpaceStd;
		onAttach();
	}

	function onAttach() {
		space.onKeyPressedSlot.connect(onKeyPressSignal);
		space.onKeyReleasedSlot.connect(onKeyReleaseSignal);
		space.onWindowResizeRequestSignal.connect(onWindowResizeRequestSlot);
		cameraQuery = new ComQuery().with(spaceStd.com.camera).with(spaceStd.com.absPosTransform).with(spaceStd.com.drawOrder);
		cameraSubjectQuery = new ComQuery().with(spaceStd.com.absPosTransform).with(spaceStd.com.drawOrder).without(spaceStd.com.camera);
	}

	public function detach() {
		if (space == null)
			return;
		onDetach();
		space = null;
		spaceStd = null;
	}

	function onDetach() {
		space.onKeyPressedSlot.disconnect(onKeyPressSignal);
		space.onKeyReleasedSlot.disconnect(onKeyReleaseSignal);
		space.onWindowResizeRequestSignal.disconnect(onWindowResizeRequestSlot);
		cameraQuery = new ComQuery();
		cameraSubjectQuery = new ComQuery();
	}

	function setupKeycodeMapData() {
		if (KEYCODE_MAP != null) {
			return;
		}
		KEYCODE_MAP = [
			hxd.Key.BACKSPACE => BACKSPACE,
			hxd.Key.TAB => TAB,
			hxd.Key.ENTER => ENTER,
			hxd.Key.SHIFT => SHIFT,
			hxd.Key.CTRL => CTRL,
			hxd.Key.ALT => ALT,
			hxd.Key.ESCAPE => ESCAPE,
			hxd.Key.SPACE => SPACE,
			hxd.Key.PGUP => PGUP,
			hxd.Key.PGDOWN => PGDOWN,
			hxd.Key.END => END,
			hxd.Key.HOME => HOME,
			hxd.Key.LEFT => LEFT,
			hxd.Key.UP => UP,
			hxd.Key.RIGHT => RIGHT,
			hxd.Key.DOWN => DOWN,
			hxd.Key.INSERT => INSERT,
			hxd.Key.DELETE => DELETE,
			hxd.Key.QWERTY_EQUALS => QWERTY_EQUALS,
			hxd.Key.QWERTY_MINUS => QWERTY_MINUS,
			hxd.Key.QWERTY_TILDE => QWERTY_TILDE,
			hxd.Key.QWERTY_BRACKET_LEFT => QWERTY_BRACKET_LEFT,
			hxd.Key.QWERTY_BRACKET_RIGHT => QWERTY_BRACKET_RIGHT,
			hxd.Key.QWERTY_SEMICOLON => QWERTY_SEMICOLON,
			hxd.Key.QWERTY_QUOTE => QWERTY_QUOTE,
			hxd.Key.QWERTY_BACKSLASH => QWERTY_BACKSLASH,
			hxd.Key.QWERTY_COMMA => QWERTY_COMMA,
			hxd.Key.QWERTY_PERIOD => QWERTY_PERIOD,
			hxd.Key.QWERTY_SLASH => QWERTY_SLASH,
			hxd.Key.INTL_BACKSLASH => INTL_BACKSLASH,
			hxd.Key.LEFT_WINDOW_KEY => LEFT_WINDOW_KEY,
			hxd.Key.RIGHT_WINDOW_KEY => RIGHT_WINDOW_KEY,
			hxd.Key.CONTEXT_MENU => CONTEXT_MENU,
			hxd.Key.PAUSE_BREAK => PAUSE_BREAK,
			hxd.Key.CAPS_LOCK => CAPS_LOCK,
			hxd.Key.NUM_LOCK => NUM_LOCK,
			hxd.Key.SCROLL_LOCK => SCROLL_LOCK,
			hxd.Key.NUMBER_0 => NUMBER_0,
			hxd.Key.NUMBER_1 => NUMBER_1,
			hxd.Key.NUMBER_2 => NUMBER_2,
			hxd.Key.NUMBER_3 => NUMBER_3,
			hxd.Key.NUMBER_4 => NUMBER_4,
			hxd.Key.NUMBER_5 => NUMBER_5,
			hxd.Key.NUMBER_6 => NUMBER_6,
			hxd.Key.NUMBER_7 => NUMBER_7,
			hxd.Key.NUMBER_8 => NUMBER_8,
			hxd.Key.NUMBER_9 => NUMBER_9,
			hxd.Key.NUMPAD_0 => NUMPAD_0,
			hxd.Key.NUMPAD_1 => NUMPAD_1,
			hxd.Key.NUMPAD_2 => NUMPAD_2,
			hxd.Key.NUMPAD_3 => NUMPAD_3,
			hxd.Key.NUMPAD_4 => NUMPAD_4,
			hxd.Key.NUMPAD_5 => NUMPAD_5,
			hxd.Key.NUMPAD_6 => NUMPAD_6,
			hxd.Key.NUMPAD_7 => NUMPAD_7,
			hxd.Key.NUMPAD_8 => NUMPAD_8,
			hxd.Key.NUMPAD_9 => NUMPAD_9,
			hxd.Key.A => A,
			hxd.Key.B => B,
			hxd.Key.C => C,
			hxd.Key.D => D,
			hxd.Key.E => E,
			hxd.Key.F => F,
			hxd.Key.G => G,
			hxd.Key.H => H,
			hxd.Key.I => I,
			hxd.Key.J => J,
			hxd.Key.K => K,
			hxd.Key.L => L,
			hxd.Key.M => M,
			hxd.Key.N => N,
			hxd.Key.O => O,
			hxd.Key.P => P,
			hxd.Key.Q => Q,
			hxd.Key.R => R,
			hxd.Key.S => S,
			hxd.Key.T => T,
			hxd.Key.U => U,
			hxd.Key.V => V,
			hxd.Key.W => W,
			hxd.Key.X => X,
			hxd.Key.Y => Y,
			hxd.Key.Z => Z,
			hxd.Key.F1 => F1,
			hxd.Key.F2 => F2,
			hxd.Key.F3 => F3,
			hxd.Key.F4 => F4,
			hxd.Key.F5 => F5,
			hxd.Key.F6 => F6,
			hxd.Key.F7 => F7,
			hxd.Key.F8 => F8,
			hxd.Key.F9 => F9,
			hxd.Key.F10 => F10,
			hxd.Key.F11 => F11,
			hxd.Key.F12 => F12,
			hxd.Key.F13 => F13,
			hxd.Key.F14 => F14,
			hxd.Key.F15 => F15,
			hxd.Key.F16 => F16,
			hxd.Key.F17 => F17,
			hxd.Key.F18 => F18,
			hxd.Key.F19 => F19,
			hxd.Key.F20 => F20,
			hxd.Key.F21 => F21,
			hxd.Key.F22 => F22,
			hxd.Key.F23 => F23,
			hxd.Key.F24 => F24,
			hxd.Key.NUMPAD_MULT => NUMPAD_MULT,
			hxd.Key.NUMPAD_ADD => NUMPAD_ADD,
			hxd.Key.NUMPAD_ENTER => NUMPAD_ENTER,
			hxd.Key.NUMPAD_SUB => NUMPAD_SUB,
			hxd.Key.NUMPAD_DOT => NUMPAD_DOT,
			hxd.Key.NUMPAD_DIV => NUMPAD_DIV,
			hxd.Key.LSHIFT => LSHIFT,
			hxd.Key.RSHIFT => RSHIFT,
			hxd.Key.LCTRL => LCTRL,
			hxd.Key.RCTRL => RCTRL,
			hxd.Key.LALT => LALT,
			hxd.Key.RALT => RALT,
		];
	}

	function sortByDrawOrder(a:EntityId, b:EntityId) {
		if (space == null)
			return 0;
		final drawOrderA = spaceStd.com.drawOrder.get(a);
		final drawOrderB = spaceStd.com.drawOrder.get(b);
		if (drawOrderA < drawOrderB) {
			return -1;
		} else if (drawOrderA > drawOrderB) {
			return 1;
		} else {
			if (a < b) {
				return -1;
			} else if (a > b) {
				return 1;
			} else {
				return 0;
			}
		}
	}

	function render() {
		static final tile = @:privateAccess new h2d.Tile(null, 0, 0, 32, 32);

		engine.begin();
		scene.renderer.begin();

		// NOTE: sorting every update might be inefficient, maybe there's a better way to do this.
		cameraQuery.run();
		cameraQuery.result.sort(sortByDrawOrder);
		cameraSubjectQuery.run();
		cameraSubjectQuery.result.sort(sortByDrawOrder);

		for (cameraId in cameraQuery.result) {
			final camCom = spaceStd.com.camera.get(cameraId);
			final camTX = spaceStd.com.absPosTransform.get(cameraId);
			scene.camera.setPosition(camTX.x, camTX.y);
			scene.camera.setAnchor(0.5, 0.5);
			scene.camera.setScale(camCom.scale, camCom.scale);
			scene.camera.sync(scene.renderer);
			scene.camera.enter(scene.renderer);
			for (subjectId in cameraSubjectQuery.result) {
				if (!camCom.idFilter(subjectId))
					continue;
				final transform = spaceStd.com.absPosTransform.get(subjectId);
				final textureRegion = spaceStd.com.textureRegions.get(subjectId);
				if (textureRegion == null)
					continue;
				dummyDrawable.setPosition(transform.x, transform.y);
				@:privateAccess dummyDrawable.sync(scene.renderer);

				inline function drawTile() {
					tile.setPosition(textureRegion.x, textureRegion.y);
					tile.setSize(textureRegion.w, textureRegion.h);
					tile.dx = -textureRegion.ox;
					tile.dy = -textureRegion.oy;
					scene.renderer.drawTile(dummyDrawable, tile);
				}

				switch (textureRegion.handle) {
					case Color(color):
						{
							@:privateAccess tile.setTexture(h3d.mat.Texture.fromColor(color.asRGB(), color.a));
							drawTile();
						}
					case File(path):
						{
							@:privateAccess tile.setTexture(hxd.Res.load(path.toString()).toTexture());
							drawTile();
						}
					case Other(other):
						{
							if (Std.isOfType(other, hxd.res.Image)) {
								@:privateAccess tile.setTexture((other : hxd.res.Image).toTexture());
								drawTile();
							} else if (Std.isOfType(other, h3d.mat.Texture)) {
								@:privateAccess tile.setTexture((other : h3d.mat.Texture));
								drawTile();
							} else if (Std.isOfType(other, h2d.Graphics)) {
								final graphics = (other : h2d.Graphics);
								graphics.setPosition(transform.x - textureRegion.ox, transform.y - textureRegion.oy);
								@:privateAccess graphics.sync(scene.renderer);
								@:privateAccess graphics.draw(scene.renderer);
							} else {
								throw new haxe.Exception('unexpected texture handle type');
							}
						}
					case None:
						{}
				}
			}
			scene.camera.exit(scene.renderer);
		}
		scene.renderer.end();
		engine.end();
	}

	function updateAudio() {
		static final query = new ComQuery();
		query.clear();
		// TODO
	}
}
