package heat.core;

using heat.HeatPrelude;

class Camera {
    public var scale = 1.;

    public function new() {}

    public dynamic function idFilter(id: EntityId):Bool {
        return true;
    }
}