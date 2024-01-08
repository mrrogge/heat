package heat.camera;

import heat.ecs.EntityId;

class Camera {
	public var scale = 1.;
	public var viewWidth = 800;
	public var viewHeight = 600;

	public function new() {}

	public dynamic function idFilter(id:EntityId):Bool {
		return true;
	}
}
