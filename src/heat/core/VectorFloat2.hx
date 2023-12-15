package heat.core;

using Math;
using heat.core.MathTools;

@:forward
@:forwardStatics
abstract VectorFloat2(Vector2<Float>) from Vector2<Float> to Vector2<Float> {
	public static final ORIGIN = new VectorFloat2(0, 0);

	public inline function new(x = 0., y = 0.) {
		this = new Vector2<Float>(x, y);
	}

	public inline function lengthSquared():Float {
		return this.x * this.x + this.y * this.y;
	}

	public inline function length():Float {
		return Math.sqrt(lengthSquared());
	}

	public static inline function distSquared(v1:IVector2<Float>, v2:IVector2<Float>):Float {
		return (v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y);
	}

	public inline function distSquaredFrom(other:IVector2<Float>):Float {
		return distSquared(this, other);
	}

	public static inline function dist(v1:IVector2<Float>, v2:IVector2<Float>):Float {
		return Math.sqrt(distSquared(v1, v2));
	}

	public inline function distFrom(other:IVector2<Float>):Float {
		return dist(this, other);
	}

	/**
		Add two vectors, returning a new vector.
	**/
	@:op(A + B)
	@:commutative
	inline function op_add(other:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(this.x + other.x, this.y + other.y);
	}

	/**
		Subtract two vectors, returning a new vector.
	**/
	@:op(A - B)
	inline function op_sub(other:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(this.x - other.x, this.y - other.y);
	}

	/**
		Multiply vector by a scalar, returning a new vector.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multScalar(scale:Float):VectorFloat2 {
		return new VectorFloat2(this.x * scale, this.y * scale);
	}

	public static inline function dot(v1:IVector2<Float>, v2:IVector2<Float>):Float {
		return v1.x * v2.x + v1.y * v2.y;
	}

	/**
		Dot product of this vector with another vector.
	**/
	public inline function dotWith(other:IVector2<Float>):Float {
		return dot(this, other);
	}

	/**
		Dot product of two vectors.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multVector(other:IVector2<Float>):Float {
		return dotWith(other);
	}

	/**
		Divide vector by a scalar, returning a new vector.
	**/
	@:op(A / B)
	inline function op_divScalar(scale:Float):VectorFloat2 {
		return new VectorFloat2(this.x / scale, this.y / scale);
	}

	/**
		Negate a vector, returning a new vector.
	**/
	@:op(-A)
	inline function op_negate():VectorFloat2 {
		return new VectorFloat2(-this.x, -this.y);
	}

	/**
		Cross product of two vectors.

		Returns a Float corresponding to the 3rd dimensional component of the cross product. The sign follows right-hand rule convention.

		(TODO: maybe consider changing this to return a VectorFloat3?)
	**/
	public static inline function cross(v1:IVector2<Float>, v2:IVector2<Float>):Float {
		return v1.x * v2.y - v1.y * v2.x;
	}

	/**
		Cross product of this vector with another vector.
	**/
	public inline function crossWith(other:IVector2<Float>):Float {
		return cross(this, other);
	}

	/**
		Multiplies the matching components of the vectors together, returning a new vector.
	**/
	public static inline function multiplyByParts(v1:IVector2<Float>, v2:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(v1.x * v2.x, v1.y * v2.y);
	}

	/**
		Returns the angle (in radians) corresponding to the vector's parts (i.e. Cartesian to polar conversion).
	**/
	public inline function angle():Float {
		return Math.atan2(this.y, this.x);
	}

	/**
		Returns a new vector with the same angle as this, normalized to a length of 1.

		If the vector has a length of zero, then this method returns the same vector, i.e. without copying it.
	**/
	public function normalize():VectorFloat2 {
		return if (this.x == 0 && this.y == 0) {
			this;
		} else {
			var length = length();
			new VectorFloat2(this.x / length, this.y / length);
		};
	}

	public inline function signs():VectorInt2 {
		return new VectorInt2(Math.sign(this.x), Math.sign(this.y));
	}

	public inline function toBools():VectorBool2 {
		return new VectorBool2(this.x != 0, this.y != 0);
	}

	public static inline function fromBools(source:IVector2<Bool>):VectorFloat2 {
		return new VectorFloat2(source.x ? 1 : 0, source.y ? 1 : 0);
	}

	public static inline function areClose(v1:IVector2<Float>, v2:IVector2<Float>):Bool {
		return v1.x - v2.x <= Math.FP_ERR() && v1.y - v2.y <= Math.FP_ERR();
	}

	public inline function isCloseTo(other:IVector2<Float>):Bool {
		return areClose(this, other);
	}

	public inline function isCloseByPartsWith(other:IVector2<Float>):VectorBool2 {
		return new VectorBool2(this.x - other.x <= Math.FP_ERR() && this.y - other.y <= Math.FP_ERR());
	}

	public static inline function fromVectorInt2(source:VectorInt2):VectorFloat2 {
		return new VectorFloat2(source.x, source.y);
	}

	public inline function toVectorInt2():VectorInt2 {
		return new VectorInt2(Std.int(this.x), Std.int(this.y));
	}

	public inline function round():VectorInt2 {
		return new VectorInt2(this.x.round(), this.y.round());
	}
}
