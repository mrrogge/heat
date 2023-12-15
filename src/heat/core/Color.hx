package heat.core;

using heat.core.MathTools;

private class _Color {
	public var r(get, never):Float;

	inline function get_r():Float
		return _r;

	public var g(get, never):Float;

	inline function get_g():Float
		return _g;

	public var b(get, never):Float;

	inline function get_b():Float
		return _b;

	public var a(get, never):Float;

	inline function get_a():Float
		return _a;

	final _r:Float;
	final _g:Float;
	final _b:Float;
	final _a:Float;

	public function new(r = 0., g = 0., b = 0., a = 0.) {
		_r = Math.limit(r, 0., 1.);
		_g = Math.limit(g, 0., 1.);
		_b = Math.limit(b, 0., 1.);
		_a = Math.limit(a, 0., 1.);
	}
}

@:forward
@:forwardStatics
abstract Color(_Color) from _Color to _Color {
	public static inline function RGBA(r = 0., g = 0., b = 0., a = 0.):Color {
		return new _Color(r, g, b, a);
	}

	public static inline function RGB(r = 0., g = 0., b = 0.,):Color {
		return new _Color(r, g, b, 1.);
	}

	public inline function asRGBA():Int {
		return Std.int((this.a * 255))
			+ (Std.int((this.b * 255)) << 8)
			+ (Std.int((this.g * 255)) << 16)
			+ (Std.int((this.r * 255)) << 24);
	}

	public inline function asRGB():Int {
		return (Std.int((this.b * 255))) + (Std.int((this.g * 255)) << 8) + (Std.int((this.r * 255)) << 16);
	}

	public inline function clone():Color {
		return Color.RGBA(this.r, this.g, this.b, this.a);
	}
}
