package heat.core;

using heat.core.MathTools;

@:forward
@:forwardStatics
abstract MVectorInt2(MVector2<Int>) from MVector2<Int> to MVector2<Int> 
{
    public inline function new(x=0, y=0) {
        this = new MVector2<Int>(x, y);
    }

    public function init(x=0, y=0):MVectorInt2 {
        this.x = x;
        this.y = y;
        return this;
    }

    public inline function lengthSquared():Int {
        return this.x*this.x + this.y*this.y;
    }

    public inline function length():Float {
        return Math.sqrt(lengthSquared());
    }

    public inline function distSquaredFrom(other:IVector2<Int>):Int {
        return VectorInt2.distSquared(this, other);
    }

    public inline function distFrom(other:MVectorInt2):Float {
        return VectorInt2.dist(this, other);
    }

    /**
        Add two vectors, returning a new vector.
    **/
    @:op(A+B)
    @:commutative
    inline function op_add(other:IVector2<Int>):MVectorInt2 {
        return new MVectorInt2(this.x + other.x, this.y + other.y);
    }

    /**
        Add two vectors, returning a new vector.
    **/
    @:op(A+B)
    @:commutative
    inline function op_addVectorFloat2(other:IVector2<Float>):MVectorFloat2 {
        return new MVectorFloat2(this.x + other.x, this.y + other.y);
    }

    /**
        Add a vector to this one in place.
    **/
    public function addWith(other:IVector2<Int>):MVectorInt2 {
        this.x += other.x;
        this.y += other.y;
        return this;
    }

    /**
        Subtract a vector from this one, returning a new vector.
    **/
    @:op(A-B)
    inline function op_sub(other:IVector2<Int>):MVectorInt2 {
        return new MVectorInt2(this.x - other.x, this.y - other.y);
    }

    /**
        Subtract a vector from this one in place.
    **/
    public function subWith(other:MVectorInt2):MVectorInt2 {
        this.x -= other.x;
        this.y -= other.y;
        return this;
    }

    /**
        Multiply vector by a scalar in place.
    **/
    public function multiplyBy(scale:Int):MVectorInt2 {
        this.x *= scale;
        this.y *= scale;
        return this;
    }

    /**
        Multiply vector by a scalar, returning a new vector.
    **/
    @:op(A*B)
    @:commutative
    inline function op_multScalar(scale:Int):MVectorInt2 {
        return new MVectorInt2(this.x * scale, this.y * scale);
    }

    /**
        Multiply vector by a scalar in place.
    **/
    @:op(A*=B)
    inline function op_multAssignScalar(scale:Int):MVectorInt2 {
        return multiplyBy(scale);
    }

    /**
        Dot product of this vector with another vector.
    **/
    public inline function dotWith(other:IVector2<Int>):Int {
        return VectorInt2.dot(this, other);
    }

    /**
        Dot product of two vectors.
    **/
    @:op(A*B)
    inline function op_multVector(other:IVector2<Int>):Int {
        return dotWith(other);
    }

    /**
        Divide vector by a scalar in place.
    **/
    public function divideBy(scale:Int):MVectorInt2 {
        this.x = Std.int(this.x / scale);
        this.y = Std.int(this.y / scale);
        return this;
    }

    /**
        Divide vector by a scalar, returning a new vector.
    **/
    @:op(A/B)
    inline function op_divScalar(scale:Float):MVectorFloat2 {
        return new MVectorFloat2(this.x / scale, this.y / scale);
    }

    /**
        Divide vector by a scalar in place.
    **/
    @:op(A/=B)
    inline function op_divAssign(scale:Int):MVectorInt2 {
        return divideBy(scale);
    }

    /**
        Negate a vector, returning a new vector.
    **/
    @:op(-A)
    inline function op_negate():MVectorInt2 {
        return new MVectorInt2(-this.x, -this.y);
    }

    /**
        Negate a vector in place.
    **/
    public function negate():MVectorInt2 {
        this.x *= -1;
        this.y *= -1;
        return this;
    }

    /**
        Cross product of this vector with another vector.
    **/
    public inline function crossWith(other:IVector2<Int>):Int {
        return VectorInt2.cross(this, other);
    }

    /**
        Multiplies the matching components of the vectors together, returning a new vector.
    **/
    public static inline function multiplyByParts(v1:IVector2<Int>, v2:IVector2<Int>):MVectorInt2 {
        return new MVectorInt2(v1.x*v2.x, v1.y*v2.y);
    }

    /**
        Multiplies matching components with another vector in place.
    **/
    public function multiplyByPartsWith(other:IVector2<Int>):MVectorInt2 {
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
        Returns a new vector with the same angle as this, normalized to a length of 1.

        If the vector has a length of zero, then this method returns the same vector, i.e. without copying it.
    **/
    public function normalize():MVectorFloat2 {
        return if (this.x == 0 && this.y == 0) {
            new MVectorFloat2(this.x, this.y);
         }
         else {
            var length = length();
            new MVectorFloat2(this.x/length, this.y/length);
         };
    } 

    public inline function signs():MVectorInt2 {
        return new MVectorInt2(this.x < 0 ? -1 : (this.x == 0 ? 0 : 1),
            this.y < 0 ? -1 : (this.y == 0 ? 0 : 1));
    }

    public inline function toBools():MVectorBool2 {
        return new MVectorBool2(this.x != 0, this.y != 0);
    }

    public static inline function fromBools(source:IVector2<Bool>):MVectorInt2 {
        return new MVectorInt2(source.x ? 1 : 0, source.y ? 1 : 0);
    }
}