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
			final fbTX = space.com.transform.get(id);
			final children = space.com.childrenLists.get(id);
			final childQuery = comQueryPool.get()
				.whereEqualTo(space.com.parents, id)
				.with(space.com.flexBoxItems)
				.with(space.com.dimensions)
				.with(space.com.transform);
			for (i in 0...children.length) {
				final childId = children[i];
				if (!childQuery.checkId(childId)) {
					continue;
				}
				final childDim = space.com.dimensions.get(childId);
				final childTX = space.com.transform.get(childId);
				switch (fb.dir) {
					case ROW:
						{
							childDim.w = (fbDim.w - (fb.gap * (children.length - 1))) / children.length;
							childDim.h = fbDim.h;
							childTX.x = (childDim.w + fb.gap) * i;
							childTX.y = 0;
						}
					case ROW_REVERSE:
						{
							childDim.w = (fbDim.w - (fb.gap * (children.length - 1))) / children.length;
							childDim.h = fbDim.h;
							childTX.x = fbDim.w - (childDim.w * (i + 1)) - (fb.gap * i);
							childTX.y = 0;
						}
					case COL:
						{
							childDim.h = (fbDim.h - (fb.gap * (children.length - 1))) / children.length;
							childDim.w = fbDim.w;
							childTX.y = (childDim.h + fb.gap) * i;
							childTX.x = 0;
						}
					case COL_REVERSE:
						{
							childDim.h = (fbDim.h - (fb.gap * (children.length - 1))) / children.length;
							childDim.w = fbDim.w;
							childTX.y = fbDim.h - (childDim.h * (i + 1)) - (fb.gap * i);
							childTX.x = 0;
						}
				}
			}
			comQueryPool.put(childQuery);
		}
		comQueryPool.put(rootQuery);
	}
}
