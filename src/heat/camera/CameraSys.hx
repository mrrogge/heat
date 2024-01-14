package heat.camera;

import heat.ecs.EntityId;

class CameraSys {
	public static function makeCameraBundle(space:heat.I_UsesHeatStandardPlugin, id:EntityId, template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		heat.transform.TransformSys.makeTransformBundle(space, id, template);
		space.com.camera.set(id, new heat.camera.Camera());
		space.com.drawOrder.set(id, 0);
	}
}
