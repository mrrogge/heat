package heat.std;

using heat.HeatPrelude;

@:build(heat.std.StandardPlugin.apply())
class HeatSpaceStd extends HeatSpace implements I_UsesHeatStandardPlugin {
	public function new() {
		super();
	}

	// TODO: BalancedTree might be more appropriate for parent/child relationship

	public function setParent(child:EntityId, parent:Null<EntityId>) {
		var currentParent = com.parents.get(child);
		if (currentParent == parent) {
			// already set to correct parent, nothing to do
			return;
		} else if (currentParent != null) {
			// remove this child from the old parent's list
			var currentParentChildren = com.childrenLists.get(currentParent);
			if (currentParentChildren != null) {
				currentParentChildren.remove(child);
			}
		}
		if (parent != null) {
			com.parents.set(child, parent);
			// init empty children list if this is the parent's first child
			if (!com.childrenLists.exists(parent)) {
				com.childrenLists.set(parent, []);
			}
			com.childrenLists.get(parent).push(child);
		} else {
			com.parents.remove(parent);
		}
	}

	override function update(dt:Float) {
		super.update(dt);
		syncAbsPos();
	}

	// TODO: guard against parent/child cycles somehow
	function syncAbsPos() {
		final rootQuery = comQueryPool.get().with(com.transform).with(com.absPosTransform).without(com.parents);
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
		comQueryPool.put(rootQuery);
	}

	function syncAbsPosInner(id:EntityId, parentAbsTx:MTransform) {
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
