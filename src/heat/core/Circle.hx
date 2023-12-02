package heat.core;

using heat.core.MathTools;

class Circle {
    final r:Float;

    public function new(r=1.) {
        this.r = Math.limit(r, 1., Math.POSITIVE_INFINITY);
    }
}