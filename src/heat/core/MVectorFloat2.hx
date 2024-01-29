package heat.core;

using heat.core.MathTools;

@:forward
@:forwardStatics
abstract MVectorFloat2(MVector2<Float>) from MVector2<Float> to MVector2<Float> {
	public inline function new(x = 0., y = 0.) {
		this = new MVector2<Float>(x, y);
	}

	public function init(x = 0., y = 0.):MVectorFloat2 {
		this.x = x;
		this.y = y;
		return this;
	}

	public function initFrom(source:IVector2<Float>):MVectorFloat2 {
		return this.initFrom(source);
	}

	public inline function lengthSquared():Float {
		return this.x * this.x + this.y * this.y;
	}

	public inline function length():Float {
		return Math.sqrt(lengthSquared());
	}

	public inline function distSquaredFrom(other:IVector2<Float>):Float {
		return VectorFloat2.distSquared(this, other);
	}

	public inline function distFrom(other:MVectorFloat2):Float {
		return VectorFloat2.dist(this, other);
	}

	/**
		Add two vectors, returning a new vector.
	**/
	@:op(A + B)
	@:commutative
	inline function op_add(other:IVector2<Float>):MVectorFloat2 {
		return new MVectorFloat2(this.x + other.x, this.y + other.y);
	}

	/**
		Add a vector to this one in place.
	**/
	public function addWith(other:IVector2<Float>):MVectorFloat2 {
		this.x += other.x;
		this.y += other.y;
		return this;
	}

	/**
		Subtract a vector from this one, returning a new vector.
	**/
	@:op(A - B)
	inline function op_sub(other:IVector2<Float>):MVectorFloat2 {
		return new MVectorFloat2(this.x - other.x, this.y - other.y);
	}

	/**
		Subtract a vector from this one in place.
	**/
	public function subWith(other:MVectorFloat2):MVectorFloat2 {
		this.x -= other.x;
		this.y -= other.y;
		return this;
	}

	/**
		Multiply vector by a scalar in place.
	**/
	public function multiplyBy(scale:Float):MVectorFloat2 {
		this.x *= scale;
		this.y *= scale;
		return this;
	}

	/**
		Multiply vector by a scalar, returning a new vector.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multScalar(scale:Float):MVectorFloat2 {
		return new MVectorFloat2(this.x * scale, this.y * scale);
	}

	/**
		Multiply vector by a scalar in place.
	**/
	@:op(A *= B)
	inline function op_multAssignScalar(scale:Float):MVectorFloat2 {
		return multiplyBy(scale);
	}

	/**
		Dot product of this vector with another vector.
	**/
	public inline function dotWith(other:IVector2<Float>):Float {
		return VectorFloat2.dot(this, other);
	}

	/**
		Dot product of two vectors.
	**/
	@:op(A * B)
	inline function op_multVector(other:IVector2<Float>):Float {
		return dotWith(other);
	}

	/**
		Divide vector by a scalar in place.
	**/
	public function divideBy(scale:Float):MVectorFloat2 {
		this.x /= scale;
		this.y /= scale;
		return this;
	}

	/**
		Divide vector by a scalar, returning a new vector.
	**/
	@:op(A / B)
	inline function op_divScalar(scale:Float):MVectorFloat2 {
		return new MVectorFloat2(this.x / scale, this.y / scale);
	}

	/**
		Divide vector by a scalar in place.
	**/
	@:op(A /= B)
	inline function op_divAssign(scale:Float):MVectorFloat2 {
		return divideBy(scale);
	}

	/**
		Negate a vector, returning a new vector.
	**/
	@:op(-A)
	inline function op_negate():MVectorFloat2 {
		return new MVectorFloat2(-this.x, -this.y);
	}

	/**
		Negate a vector in place.
	**/
	public function negate():MVectorFloat2 {
		this.x *= -1;
		this.y *= -1;
		return this;
	}

	/**
		Cross product of this vector with another vector.
	**/
	public inline function crossWith(other:IVector2<Float>):Float {
		return VectorFloat2.cross(this, other);
	}

	/**
		Multiplies the matching components of the vectors together, returning a new vector.
	**/
	public static inline function multiplyByParts(v1:IVector2<Float>, v2:IVector2<Float>):MVectorFloat2 {
		return new MVectorFloat2(v1.x * v2.x, v1.y * v2.y);
	}

	/**
		Multiplies matching components with another vector in place.
	**/
	public function multiplyByPartsWith(other:IVector2<Float>):MVectorFloat2 {
		this.x *= other.x;
		this.y *= other.y;
		return this;
	}

	/**
		Returns the angle (in radians) corresponding to the vector's parts (i.e. Cartesian to polar conversion).
	**/
	public inline function angle():Float {
		return Math.atan2(this.y, this.x);
	}

	/**
		Normalize this vector in place to a length of 1.

		Does not modify the vector if it has a length of zero.
	**/
	public function normalize():MVectorFloat2 {
		if (this.x == 0 && this.y == 0)
			return this;
		var length = length();
		this.x /= length;
		this.y /= length;
		return this;
	}

	public function signs():MVectorFloat2 {
		this.x = this.x == 0 ? 0 : this.x / Math.abs(this.x);
		this.y = this.y == 0 ? 0 : this.y / Math.abs(this.y);
		return this;
	}

	public inline function toBools():MVectorBool2 {
		return new MVectorBool2(this.x != 0, this.y != 0);
	}

	public static inline function fromBools(source:IVector2<Bool>):MVectorFloat2 {
		return new MVectorFloat2(source.x ? 1 : 0, source.y ? 1 : 0);
	}

	public inline function isCloseTo(other:IVector2<Float>):Bool {
		return VectorFloat2.areClose(this, other);
	}

	public inline function isCloseByPartsWith(other:IVector2<Float>):MVectorBool2 {
		return new MVectorBool2(this.x - other.x <= Math.FP_ERR() && this.y - other.y <= Math.FP_ERR());
	}

	public function clamp(max:Float):MVectorFloat2 {
		if (lengthSquared() > max * max) {
			normalize().multiplyBy(max);
		}
		return this;
	}

	public function rotateTo(angle:Float):MVectorFloat2 {
		final length = abstract.length();
		this.init(length * Math.cos(angle), length * Math.sin(angle));
		return this;
	}

	public function rotateBy(angleDelta:Float):MVectorFloat2 {
		final angle = abstract.angle();
		abstract.rotateTo(angle + angleDelta);
		return this;
	}
}
