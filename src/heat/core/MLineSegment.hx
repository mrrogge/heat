package heat.core;

using heat.core.MathTools;

class MLineSegment implements ILineSegment {
	public var x1(get, set):Float;

	inline function get_x1():Float
		return p1.x;

	function set_x1(x1:Float):Float {
		p1.x = x1;
		return x1;
	}

	public var y1(get, set):Float;

	inline function get_y1():Float
		return p1.y;

	function set_y1(y1:Float):Float {
		p1.y = y1;
		return y1;
	}

	public var x2(get, set):Float;

	inline function get_x2():Float
		return p2.x;

	function set_x2(x2:Float):Float {
		p2.x = x2;
		return x2;
	}

	public var y2(get, set):Float;

	inline function get_y2():Float
		return p2.y;

	function set_y2(y2:Float):Float {
		p2.y = y2;
		return y2;
	}

	final p1:MVectorFloat2;
	final p2:MVectorFloat2;

	public function new(x1 = 0., y1 = 0., x2 = 0., y2 = 0.) {
		p1 = new MVectorFloat2(x1, y1);
		p2 = new MVectorFloat2(x2, y2);
	}

	public static inline function fromVectors(v1:IVector2<Float>, v2:IVector2<Float>):MLineSegment {
		return new MLineSegment(v1.x, v1.y, v2.x, v2.y);
	}

	public function init(x1 = 0., y1 = 0., x2 = 0., y2 = 0.):MLineSegment {
		p1.init(x1, y1);
		p2.init(x2, y2);
		return this;
	}

	public inline function clone():MLineSegment {
		return MLineSegment.fromVectors(p1, p2);
	}

	public inline function lengthSquared():Float {
		return VectorFloat2.distSquared(p1, p2);
	}

	public inline function length():Float {
		return VectorFloat2.dist(p1, p2);
	}

	public inline function sameAs(other:ILineSegment):Bool {
		return LineSegment.areSame(this, other);
	}

	public inline function closeTo(other:ILineSegment):Bool {
		return LineSegment.areClose(this, other);
	}

	public inline function translateBy(x:Float, y:Float):LineSegment {
		return new LineSegment(x1 + x, y1 + y, x2 + x, y2 + y);
	}
}
