package heat.core;

using heat.HeatPrelude;

class HeatSpace {
    public var onKeyPressedSlot: Slot<KeyCode>;
    public var onKeyReleasedSlot: Slot<KeyCode>;

    public function new() {
        this.onKeyPressedSlot = new Slot(onKeyPressed);
        this.onKeyReleasedSlot = new Slot(onKeyReleased);
    }

    public function update(dt:Float) {

    }

    function onKeyPressed(keyCode: KeyCode) {

    }

    function onKeyReleased(keyCode: KeyCode) {

    }
}