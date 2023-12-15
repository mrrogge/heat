package heat.core;

using heat.core.MathTools;

@:forward
@:forwardStatics
abstract VectorInt2(Vector2<Int>) from Vector2<Int> to Vector2<Int> {
	public inline function new(x = 0, y = 0) {
		this = new Vector2<Int>(x, y);
	}

	public inline function lengthSquared():Int {
		return this.x * this.x + this.y * this.y;
	}

	public inline function length():Float {
		return Math.sqrt(lengthSquared());
	}

	public static inline function distSquared(v1:IVector2<Int>, v2:IVector2<Int>):Int {
		return (v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y);
	}

	public inline function distSquaredFrom(other:IVector2<Int>):Int {
		return distSquared(this, other);
	}

	public static inline function dist(v1:IVector2<Int>, v2:IVector2<Int>):Float {
		return Math.sqrt(distSquared(v1, v2));
	}

	public inline function distFrom(other:IVector2<Int>):Float {
		return dist(this, other);
	}

	/**
		Add two vectors, returning a new vector.
	**/
	@:op(A + B)
	@:commutative
	inline function op_addVectorInt2(other:IVector2<Int>):VectorInt2 {
		return new VectorInt2(this.x + other.x, this.y + other.y);
	}

	/**
		Add two vectors, returning a new vector.
	**/
	@:op(A + B)
	@:commutative
	inline function op_addVectorFloat2(other:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(this.x + other.x, this.y + other.y);
	}

	/**
		Subtract two vectors, returning a new vector.
	**/
	@:op(A - B)
	inline function op_subVectorInt2(other:IVector2<Int>):VectorInt2 {
		return new VectorInt2(this.x - other.x, this.y - other.y);
	}

	/**
		Subtract two vectors, returning a new vector.
	**/
	@:op(A - B)
	inline function op_subVectorFloat2(other:IVector2<Float>):VectorFloat2 {
		return new VectorFloat2(this.x - other.x, this.y - other.y);
	}

	/**
		Multiply vector by a scalar, returning a new vector.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multScalarInt(scale:Int):VectorInt2 {
		return new VectorInt2(this.x * scale, this.y * scale);
	}

	/**
		Multiply vector by a scalar, returning a new vector.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multScalarFloat(scale:Float):VectorFloat2 {
		return new VectorFloat2(this.x * scale, this.y * scale);
	}

	public static inline function dot(v1:IVector2<Int>, v2:IVector2<Int>):Int {
		return v1.x * v2.x + v1.y * v2.y;
	}

	/**
		Dot product of this vector with another vector.
	**/
	public inline function dotWith(other:IVector2<Int>):Int {
		return dot(this, other);
	}

	/**
		Dot product of two vectors.
	**/
	@:op(A * B)
	@:commutative
	inline function op_multVector(other:IVector2<Int>):Int {
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
	inline function op_negate():VectorInt2 {
		return new VectorInt2(-this.x, -this.y);
	}

	/**
		Cross product of two vectors.

		Returns an Int corresponding to the 3rd dimensional component of the cross product. The sign follows right-hand rule convention.

		(TODO: maybe consider changing this to return a VectorFloat3?)
	**/
	public static inline function cross(v1:IVector2<Int>, v2:IVector2<Int>):Int {
		return v1.x * v2.y - v1.y * v2.x;
	}

	/**
		Cross product of this vector with another vector.
	**/
	public inline function crossWith(other:IVector2<Int>):Int {
		return cross(this, other);
	}

	/**
		Multiplies the matching components of the vectors together, returning a new vector.
	**/
	public static inline function multiplyByParts(v1:IVector2<Int>, v2:IVector2<Int>):VectorInt2 {
		return new VectorInt2(v1.x * v2.x, v1.y * v2.y);
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
			new VectorFloat2(this.x, this.y);
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

	public static inline function fromBools(source:IVector2<Bool>):VectorInt2 {
		return new VectorInt2(source.x ? 1 : 0, source.y ? 1 : 0);
	}

	public static inline function fromVectorFloat2(source:VectorFloat2):VectorInt2 {
		return new VectorInt2(Std.int(source.x), Std.int(source.y));
	}

	public inline function toVectorFloat2():VectorFloat2 {
		return new VectorFloat2(this.x, this.y);
	}
}
