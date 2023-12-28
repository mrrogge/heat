package heat.camera;

using heat.HeatPrelude;

class CameraSys {
    function makeCameraBundle(space:heat.I_UsesHeatStandardPlugin, id:EntityId, template:heat.ecs.BundleTemplate<{x:Float, y:Float}> = DEFAULT) {
		heat.transform.TransformSys.makeTransformBundle(space, id, template);
		space.com.camera.set(id, new heat.core.Camera());
		space.com.drawOrder.set(id, 0);
	}
}