package heat.bridges.heaps;

using heat.HeatPrelude;

class HeapsBridge {
    static var KEYCODE_MAP: Null<Map<Int, KeyCode>>;

    public function new() {
        setupKeycodeMapData();
    }

    public function attach(space: HeatSpace) {
        final sortByDrawOrder = makeSortByDrawOrder(space);

        hxd.System.start(function() {
            final engine = @:privateAccess new h3d.Engine();
            engine.onReady = function() {
                engine.onReady = function () {};
                engine.onContextLost = function () {};
                engine.onResized = function() {};

                var onKeyPressSignal = new Signal<KeyCode>();
                space.onKeyPressedSlot.connect(onKeyPressSignal);
                var onKeyReleaseSignal = new Signal<KeyCode>();
                space.onKeyReleasedSlot.connect(onKeyReleaseSignal);

                var window = hxd.Window.getInstance();
                window.addEventTarget(function (event:hxd.Event) {
                    switch (event.kind) {
                        case EKeyUp: {
                            onKeyPressSignal.emit(KEYCODE_MAP.get(event.keyCode));
                        }
                        default: {}
                    }
                });

                space.onWindowResizeRequestSignal.connect(new Slot(function (request: heat.core.window.Window.WindowResizeRequest) {
                    window.resize(request.width, request.height);
                }));

                final scene = new h2d.Scene();
                final dummyDrawable = @:privateAccess new h2d.Drawable(scene);

                hxd.System.setLoop(function () {
                    hxd.Timer.update();
                    space.update(hxd.Timer.dt);

                    final texture = h3d.mat.Texture.fromColor(0x0000ff);
                    final tile = @:privateAccess new h2d.Tile(texture, 0, 0, 32, 32);

                    engine.begin();
                    scene.renderer.begin();

                    final cameraQuery = new ComQuery()
                        .with(space.com.camera)
                        .with(space.com.absPosTransform)
                        .with(space.com.drawOrder);
                    cameraQuery.run();
                    cameraQuery.result.sort(sortByDrawOrder);

                    final subjectQuery = new ComQuery()
                    .with(space.com.absPosTransform)
                    .with(space.com.drawOrder)
                    .without(space.com.camera);
                    subjectQuery.run();
                    subjectQuery.result.sort(sortByDrawOrder);

                    for (cameraId in cameraQuery.result) {
                        // TODO: camera filtering - how do we determine which entities are drawn from which cameras?
                        final camTX = space.com.absPosTransform.get(cameraId);
                        scene.camera.setPosition(camTX.x, camTX.y);
                        scene.camera.setAnchor(0.5, 0.5);
                        scene.camera.sync(scene.renderer);
                        scene.camera.enter(scene.renderer);
                        for (subjectId in subjectQuery.result) {
                            final transform = space.com.absPosTransform.get(subjectId);
                            dummyDrawable.setPosition(transform.x, transform.y);
                            @:privateAccess dummyDrawable.sync(scene.renderer);
                            scene.renderer.drawTile(dummyDrawable, tile);
                        }
                        scene.camera.exit(scene.renderer);
                    }
                    scene.renderer.end();
                    engine.end();
                });
            };
            engine.init();
        });
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

    function makeSortByDrawOrder(space: HeatSpace) {
        return (a, b) -> {
            final drawOrderA = space.com.drawOrder.get(a);
            final drawOrderB = space.com.drawOrder.get(b);
            if (drawOrderA < drawOrderB) {
                return -1;
            }
            else if (drawOrderA > drawOrderB) {
                return 1;
            }
            else {
                if (a < b) {
                    return -1;
                }
                else if (a > b) {
                    return  1;
                }
                else {
                    return 0;
                }
            }
        }
    }
}
