package heat.core;

using heat.core.MathTools;

final FP_ERR = 1e-10;

class MRect {
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;

	public function new(x = 0., y = 0., w = 1., h = 1.) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}

	public function getNearestCorner(point:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(Math.nearest(point.x, this.x, this.x + this.w), Math.nearest(point.y, this.y, this.y + this.h));
	}

	public static function diff(rect1:MRect, rect2:MRect):MRect {
		return new MRect(rect2.x - rect1.x - rect1.w, rect2.y - rect1.y - rect1.h, rect1.w + rect2.w, rect1.h + rect2.h);
	}

	public function containsPoint(point:IVector2<Float>):Bool {
		return point.x - this.x > FP_ERR && point.y - this.y > FP_ERR && this.x + this.w - point.x > FP_ERR && this.y + this.h - point.y > FP_ERR;
	}

	public static function areIntersecting(rect1:MRect, rect2:MRect):Bool {
		return rect1.x < rect2.x + rect2.w && rect2.x < rect1.x + rect1.w && rect1.y < rect2.y + rect2.h && rect2.y < rect1.y + rect1.h;
	}

	public static function squareDist(rect1:MRect, rect2:MRect):Float {
		var dx = rect1.x - rect2.x + (rect1.w - rect2.w) / 2;
		var dy = rect1.y - rect2.y + (rect1.h - rect2.h) / 2;
		return dx * dx + dy * dy;
	}

    public function clone():MRect {
        return new MRect(x, y, w, h);
    }
}
