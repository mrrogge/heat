package heat.core;

using heat.HeatPrelude;

class HeatSpace implements heat.core.IUsesSTD {
    public var onKeyPressedSlot: Slot<KeyCode>;
    public var onKeyReleasedSlot: Slot<KeyCode>;

    var onWindowResizeRequestEmitter = new SignalEmitter<heat.core.window.Window.WindowResizeRequest>();
    public var onWindowResizeRequestSignal: ISignal<heat.core.window.Window.WindowResizeRequest>;

    public var lastID(default, null): Null<EntityId> = null;

    // TODO: use macros for adding ComMaps to a HeatSpace, a-la rust derive API.
    public final com = {
        parents: new ComMap<EntityId>(),
        childrenLists: new ComMap<Array<EntityId>>(),
        transform: new ComMap<MTransform>(),
        absPosTransform: new ComMap<MTransform>(),
        camera: new ComMap<Camera>(),
        drawOrder: new ComMap<Int>(),
    }

    public function new() {
        this.onKeyPressedSlot = new Slot(onKeyPressed);
        this.onKeyReleasedSlot = new Slot(onKeyReleased);
        this.onWindowResizeRequestSignal = onWindowResizeRequestEmitter.signal;
    }

    public function getNextID(): EntityId {
        lastID = lastID == null ? 0 : lastID + 1;
        return lastID;
    }

    // TODO: BalancedTree might be more appropriate for parent/child relationship

    public function setParent(child: EntityId, parent: EntityId) {
        var currentParent = com.parents.get(child);
        if (currentParent == parent) {
            return;
        }
        else if (currentParent != null) {
            var currentParentChildren = com.childrenLists.get(currentParent);
            if (currentParentChildren != null) {
                currentParentChildren.remove(child);
            }
        }
        com.parents.set(child, parent);
        if (!com.childrenLists.exists(parent)) {
            com.childrenLists.set(parent, []);
        }
        com.childrenLists.get(parent).push(child);        
    }

    public function update(dt:Float) {

    }

    function onKeyPressed(keyCode: KeyCode) {

    }

    function onKeyReleased(keyCode: KeyCode) {

    }
}