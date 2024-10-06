package heat.ui;

import heat.ecs.ComQueryPool;

class FlexBoxSys {
	static final comQueryPool = new ComQueryPool();

	public static function update(space:heat.I_UsesHeatStandardPlugin, dt:Float) {
		final rootQuery = comQueryPool.get()
			.with(space.com.flexBoxes)
			.with(space.com.childrenLists)
			.with(space.com.dimensions)
			.with(space.com.transform);
		rootQuery.run();
		for (id in rootQuery.result) {
			final fb = space.com.flexBoxes.get(id);
			final fbDim = space.com.dimensions.get(id);
			final children = space.com.childrenLists.get(id);
			final childQuery = comQueryPool.get()
				.whereEqualTo(space.com.parents, id)
				.with(space.com.flexBoxItems)
				.with(space.com.dimensions)
				.with(space.com.transform);
			var flexTotal = 0;
			for (i in 0...children.length) {
				final childId = children[i];
				if (!childQuery.checkId(childId)) {
					continue;
				}
				final flex = space.com.flexBoxItems.get(childId).flex;
				if (flex != 0) {
					flexTotal += flex;
				}
			}

			var workingX = 0.;
			var workingY = 0.;
			for (i in 0...children.length) {
				final index = switch (fb.dir) {
					case ROW, COL: i;
					case ROW_REVERSE, COL_REVERSE: children.length - 1 - i;
				}
				final childId = children[index];
				if (!childQuery.checkId(childId)) {
					continue;
				}
				final childDim = space.com.dimensions.get(childId);
				final childTX = space.com.transform.get(childId);
				final flex = space.com.flexBoxItems.get(childId).flex;
				switch (fb.dir) {
					case ROW, ROW_REVERSE:
						{
							if (flex != 0) {
								childDim.w = (fbDim.w - (fb.gap * (children.length - 1))) * flex / flexTotal;
							}
							childDim.h = fbDim.h;
							childTX.x = workingX;
							childTX.y = workingY;
							workingX += (childDim.w + fb.gap);
						}
					case COL, COL_REVERSE:
						{
							childDim.w = fbDim.w;
							if (flex != 0) {
								childDim.h = (fbDim.h - (fb.gap * (children.length - 1))) * flex / flexTotal;
							}
							childTX.x = workingX;
							childTX.y = workingY;
							workingY += (childDim.h + fb.gap);
						}
				}
			}
			comQueryPool.put(childQuery);
		}
		comQueryPool.put(rootQuery);
	}
}
