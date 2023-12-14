package heat.std;

using heat.HeatPrelude;

@:build(heat.std.StandardPlugin.applyStandardPlugin())
class HeatSpaceStd extends HeatSpace implements I_UsesHeatStandardPlugin {

    public function new() {
        super();

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

    override function update(dt:Float) {
        super.update(dt);
        syncAbsPos();
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