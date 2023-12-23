package heat.core;

using heat.core.MathTools;

class MCircle {
    public var r(default, set):Float;
    function set_r(r:Float):Float {
        this.r = Math.limit(r, 1., Math.POSITIVE_INFINITY);
        return this.r;
    }

    public function new(r=1.) {
        this.r = r;
    }
}