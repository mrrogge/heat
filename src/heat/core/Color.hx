package heat.core;

using heat.core.MathTools;

abstract Color(Int) from Int to Int {
	inline public static function ARGB(color:Int):Color {
		return color;
	}

	inline public static function RGB(color:Int):Color {
		return color & 0x00FFFFFF;
	}

	public static var RED(get, never):Color;

	inline static function get_RED():Color {
		return 0xFFFF0000;
	}

	public static var GREEN(get, never):Color;

	inline static function get_GREEN():Color {
		return 0xFF00FF00;
	}

	public static var BLUE(get, never):Color;

	inline static function get_BLUE():Color {
		return 0xFF0000FF;
	}

	public static var WHITE(get, never):Color;

	inline static function get_WHITE():Color {
		return 0xFFFFFFFF;
	}

	public static var BLACK(get, never):Color;

	inline static function get_BLACK():Color {
		return 0xFF000000;
	}

	public inline function new(colorARGB:Int) {
		this = colorARGB;
	}

	public var r(get, set):Int;

	inline function get_r():Int {
		return (this >> 16) & 0xFF;
	}

	inline function set_r(r:Int):Int {
		this = (this & 0xFF00FFFF) | ((r & 0xFF) << 16);
		return r;
	}

	public var g(get, set):Int;

	inline function get_g():Int {
		return (this >> 8) & 0xFF;
	}

	inline function set_g(g:Int):Int {
		this = (this & 0xFFFF00FF) | ((g & 0xFF) << 8);
		return g;
	}

	public var b(get, set):Int;

	inline function get_b():Int {
		return this & 0xFF;
	}

	inline function set_b(b:Int):Int {
		this = (this & 0xFFFFFF00) | (b & 0xFF);
		return b;
	}

	public var a(get, set):Int;

	inline function get_a():Int {
		return (this >> 24) & 0xFF;
	}

	inline function set_a(a:Int):Int {
		this = (this & 0x00FFFFFF) | ((a & 0xFF) << 24);
		return a;
	}
}
