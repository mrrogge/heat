package heat.transform;

using heat.HeatPrelude;

class TransformSys {
	public static function makeTransformBundle(space:heat.I_UsesHeatStandardPlugin, id:EntityId,
			template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		final tx = new MTransform();
		space.com.transform.set(id, tx);
		space.com.absPosTransform.set(id, tx.clone());
		switch (template) {
			case DEFAULT:
				{}
			case CUSTOM(template):
				{
					tx.x = template.x;
					tx.y = template.y;
				}
		}
	}
}
