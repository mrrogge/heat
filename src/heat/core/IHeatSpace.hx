package heat.core;

using heat.HeatPrelude;

interface IHeatSpace {
    public var lastID(default, null): Null<EntityId>;

    public var onKeyPressedSlot: Slot<KeyCode>;
    public var onKeyReleasedSlot: Slot<KeyCode>;
    public var onWindowResizeRequestSignal: ISignal<heat.core.window.Window.WindowResizeRequest>;

    public function getNextID(): EntityId;

    public function update(dt:Float): Void;
}