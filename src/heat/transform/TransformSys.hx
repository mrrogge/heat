package heat.transform;

import heat.ecs.EntityId;
import heat.core.MTransform;
import heat.ecs.ComQueryPool;

class TransformSys {
	static final comQueryPool = new ComQueryPool();

	public static function makeTransformBundle(space:heat.I_UsesHeatStandardPlugin, id:EntityId,
			template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		final tx = new MTransform();
		space.com.transform.set(id, tx);
		switch (template) {
			case DEFAULT:
				{}
			case CUSTOM(template):
				{
					tx.x = template.x;
					tx.y = template.y;
				}
		}
		space.com.absPosTransform.set(id, tx.clone());
	}

	// TODO: BalancedTree might be more appropriate for parent/child relationship

	public static function setParent(space:I_UsesHeatStandardPlugin, child:EntityId, parent:Null<EntityId>) {
		var currentParent = space.com.parents.get(child);
		if (currentParent == parent) {
			// already set to correct parent, nothing to do
			return;
		} else if (currentParent != null) {
			// remove this child from the old parent's list
			var currentParentChildren = space.com.childrenLists.get(currentParent);
			if (currentParentChildren != null) {
				currentParentChildren.remove(child);
			}
		}
		if (parent != null) {
			space.com.parents.set(child, parent);
			// init empty children list if this is the parent's first child
			if (!space.com.childrenLists.exists(parent)) {
				space.com.childrenLists.set(parent, []);
			}
			space.com.childrenLists.get(parent).push(child);
		} else {
			space.com.parents.remove(parent);
		}
		syncAbsPos(space, child);
	}

	// TODO: guard against parent/child cycles somehow
	public static function syncAbsPositions(space:I_UsesHeatStandardPlugin) {
		final rootQuery = comQueryPool.get()
			.with(space.com.transform)
			.with(space.com.absPosTransform)
			.without(space.com.parents);
		rootQuery.run();
		for (id in rootQuery.result) {
			final rootTx = space.com.transform.get(id);
			final rootAbsTx = space.com.absPosTransform.get(id);
			rootTx?.applyTo(rootAbsTx);
			final children = space.com.childrenLists.get(id);
			if (children == null) {
				continue;
			}
			for (childId in children) {
				syncAbsPositionsInner(space, childId, rootAbsTx);
			}
		}
		comQueryPool.put(rootQuery);
	}

	static function syncAbsPositionsInner(space:I_UsesHeatStandardPlugin, id:EntityId, parentAbsTx:MTransform) {
		final tx = space.com.transform.get(id);
		final absTX = space.com.absPosTransform.get(id);
		if (tx == null || absTX == null) {
			return;
		}
		absTX.multiply(parentAbsTx, tx);
		final children = space.com.childrenLists.get(id);
		if (children == null) {
			return;
		}
		for (childId in children) {
			syncAbsPositionsInner(space, childId, absTX);
		}
	}

	// Syncs the absolute position of a single entity based on its ancestors' positions, if any.
	public static function syncAbsPos(space:I_UsesHeatStandardPlugin, id:EntityId) {
		final tx = space.com.transform.get(id);
		final absTX = space.com.absPosTransform.get(id);
		if (tx == null || absTX == null) {
			return;
		}
		tx.applyTo(absTX);
		final parentId = space.com.parents.get(id);
		if (parentId == null) {
			return;
		}
		syncAbsPos(space, parentId);
		final parentAbsTX = space.com.absPosTransform.get(parentId);
		absTX.multiply(parentAbsTX, tx);
	}
}
