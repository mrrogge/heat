package heat.core;

using heat.core.MathTools;

final FP_ERR = 1e-10;

class Rect implements IRect {
	public var x(get, never):Float;
	final _x:Float;
	inline function get_x():Float {
		return _x;
	}
	public var y(get, never):Float;
	final _y:Float;
	inline function get_y():Float {
		return _y;
	}
	public var w(get, never):Float;
	final _w:Float;
	inline function get_w():Float {
		return _w;
	}
	public var h(get, never):Float;
	final _h:Float;
	inline function get_h():Float {
		return _h;
	}


	public function new(x = 0., y = 0., w = 1., h = 1.) {
		this._x = x;
		this._y = y;
		this._w = w;
		this._h = h;
	}

	public function isSameAs(other:IRect):Bool {
		return this.x == other.x && this.y == other.y && this.w == other.w && this.h == other.h;
	}

	public function getNearestCorner(point:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(Math.nearest(point.x, this.x, this.x + this.w), Math.nearest(point.y, this.y, this.y + this.h));
	}

	public static function diff(rect1:IRect, rect2:IRect):Rect {
		return new Rect(rect2.x - rect1.x - rect1.w, rect2.y - rect1.y - rect1.h, rect1.w + rect2.w, rect1.h + rect2.h);
	}

	public function containsPoint(point:IVector2<Float>):Bool {
		return point.x - this.x > FP_ERR && point.y - this.y > FP_ERR && this.x + this.w - point.x > FP_ERR && this.y + this.h - point.y > FP_ERR;
	}

	public static function areIntersecting(rect1:IRect, rect2:IRect):Bool {
		return rect1.x < rect2.x + rect2.w && rect2.x < rect1.x + rect1.w && rect1.y < rect2.y + rect2.h && rect2.y < rect1.y + rect1.h;
	}

	public static function squareDist(rect1:IRect, rect2:IRect):Float {
		var dx = rect1.x - rect2.x + (rect1.w - rect2.w) / 2;
		var dy = rect1.y - rect2.y + (rect1.h - rect2.h) / 2;
		return dx * dx + dy * dy;
	}
}
