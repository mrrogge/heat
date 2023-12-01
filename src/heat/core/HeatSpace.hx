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
        names: new ComMap<String>(),
        textureRegions: new ComMap<heat.texture.TextureRegion<Any>>(),
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
        syncAbsPos();
    }

    function onKeyPressed(keyCode: KeyCode) {

    }

    function onKeyReleased(keyCode: KeyCode) {

    }

    // TODO: guard against parent/child cycles somehow
    function syncAbsPos() {
        final rootQuery = new ComQuery()
            .with(com.transform)
            .with(com.absPosTransform)
            .without(com.parents);
        rootQuery.run();
        for (id in rootQuery.result) {
            final rootTx = com.transform.get(id);
            final rootAbsTx = com.absPosTransform.get(id);
            rootTx?.applyTo(rootAbsTx);
            final children = com.childrenLists.get(id);
            if (children == null) {
                continue;
            }
            for (childId in children) {
                syncAbsPosInner(childId, rootAbsTx);
            }
        }
    }

    function syncAbsPosInner(id: EntityId, parentAbsTx: MTransform) {
        final tx = com.transform.get(id);
        final absTX = com.absPosTransform.get(id);
        if (tx == null || absTX == null) {
            return;
        }
        absTX.multiply(parentAbsTx, tx);
        final children = com.childrenLists.get(id);
        if (children == null) {
            return;
        }
        for (childId in children) {
            syncAbsPosInner(childId, absTX);
        }
    }
}