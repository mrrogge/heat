package heat.core;

import haxe.ds.Vector;

/**
	A mutable vector with 2 components.
**/
class MVector2<T> implements IVector2<T> {
	public var x(get, set):T;

	inline function get_x():T {
		return _v[0];
	}

	function set_x(x:T):T {
		_v[0] = x;
		return x;
	}

	public var y(get, set):T;

	inline function get_y():T {
		return _v[1];
	}

	function set_y(y:T):T {
		_v[1] = y;
		return y;
	}

	var _v = new Vector<T>(2);

	public function new(x:T, y:T) {
		init(x, y);
	}

	public function init(x:T, y:T):MVector2<T> {
		this.x = x;
		this.y = y;
		return this;
	}

	public inline function initFrom(source:IVector2<T>):MVector2<T> {
		init(source.x, source.y);
		return this;
	}

	public inline function toImmutable():Vector2<T> {
		return new Vector2<T>(x, y);
	}

	public static inline function fromImmutable<T>(immutable:Vector2<T>):MVector2<T> {
		return new MVector2<T>(immutable.x, immutable.y);
	}

	public inline function clone():MVector2<T> {
		return new MVector2<T>(x, y);
	}

	public inline function applyTo(target:MVector2<T>):MVector2<T> {
		target.init(x, y);
		return this;
	}

	/**
		Check if this vector has the same part values as another vector. Returns a corresponding Bool value.
	**/
	public inline function isSameAs(other:IVector2<T>):Bool {
		return Vector2.areSame(this, other);
	}

	/**
		Check part values between two vectors for sameness. Returns a new boolean vector corresponding to the comparison results.
	**/
	public static inline function areSameByParts<T>(v1:IVector2<T>, v2:IVector2<T>):MVectorBool2 {
		return new MVectorBool2(v1.x == v2.x, v1.y == v2.y);
	}

	/**
		Check part values against another vector. Returns a new boolean vector corresponding to the comparison results.
	**/
	public inline function isSameByPartsWith(other:IVector2<T>):MVectorBool2 {
		return areSameByParts(this, other);
	}
}
