package heat.core;

using heat.HeatPrelude;

class HeatSpace implements IHeatSpace {
    public var lastID(default, null): Null<EntityId> = null;

    public var onKeyPressedSlot: Slot<KeyCode>;
    public var onKeyReleasedSlot: Slot<KeyCode>;

    var onWindowResizeRequestEmitter = new SignalEmitter<heat.core.window.Window.WindowResizeRequest>();
    public var onWindowResizeRequestSignal: ISignal<heat.core.window.Window.WindowResizeRequest>;

    public function new() {
        this.onKeyPressedSlot = new Slot(onKeyPressed);
        this.onKeyReleasedSlot = new Slot(onKeyReleased);
        this.onWindowResizeRequestSignal = onWindowResizeRequestEmitter.signal;
    }

    public function getNextID(): EntityId {
        lastID = lastID == null ? 0 : lastID + 1;
        return lastID;
    }

    public function update(dt:Float) {

    }

    function onKeyPressed(keyCode: KeyCode) {

    }

    function onKeyReleased(keyCode: KeyCode) {

    }
}