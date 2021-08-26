package heat.vector;

@:forward
@:forward.new
abstract FloatVector2(Vector2<Float>) from Vector2<Float> to Vector2<Float> {
    public static inline function init(instance:FloatVector2, ?data:FloatVector2Data) {
        instance.x = (data == null) ? 0.0 : (data.x == null) ? 0.0 : data.x;
        instance.y = (data == null) ? 0.0 : (data.y == null) ? 0.0 : data.y;
    }

    public function clone():FloatVector2 {
        var result = new FloatVector2();
        result.x = this.x;
        result.y = this.y;
        return result;
    }

    public function applyTo(target:FloatVector2):FloatVector2 {
        target.x = this.x;
        target.y = this.y;
        return this;
    }

    public function applyFrom(source:FloatVector2):FloatVector2 {
        this.x = source.x;
        this.y = source.y;
        return this;
    }

    /**
        Add two vectors, returning a new vector.
    **/
    @:op(a + b)
    public function addOp(other:FloatVector2):FloatVector2 {
        var result = new FloatVector2();
        result.x = this.x + other.x;
        result.y = this.y + other.y;
        return result;
    }

    /**
        Subtract two vectors, returning a new vector.
    **/
    @:op(a - b)
    public function subOp(other:FloatVector2):FloatVector2 {
        var result = new FloatVector2();
        result.x = this.x - other.x;
        result.y = this.y - other.y;
        return result;
    }

    /**
        Multiply vector by a scalar, returning a new vector.
    **/
    @:op(a * b)
    @:commutative
    public function multScalarOp(scale:Float):FloatVector2 {
        var result = new FloatVector2();
        result.x = this.x * scale;
        result.y = this.y * scale;
        return result;
    }

    /**
        Dot product of two vectors.
    **/
    @:op(a * b)
    public function multVectorOp(other:FloatVector2):Float {
        return other.dot(this);
    }

    /**
        Divide vector by a scalar, returning a new vector.
    **/
    @:op(a / b)
    public function divScalarOp(scale:Float):FloatVector2 {
        var result = new FloatVector2();
        result.x = this.x / scale;
        result.y = this.y / scale;
        return result;
    }

    /**
        Negate a vector, returning a new vector.
    **/
    @:op(!a)
    public function notOp():FloatVector2 {
        var result = new FloatVector2();
        result.x = -this.x;
        result.y = -this.y;
        return result;
    }

    /**
        Adds a vector to this vector in place.
    **/
    public function add(other:FloatVector2):FloatVector2 {
        this.x += other.x;
        this.y += other.y;
        return this;
    }

    /**
        Subtracts a vector from this vector in place.
    **/
    public function sub(other:FloatVector2):FloatVector2 {
        this.x -= other.x;
        this.y -= other.y;
        return this;
    }

    /**
        Scalar multiplication of this vector in place.
    **/
    public function mult(scale:Float):FloatVector2 {
        this.x *= scale;
        this.y *= scale;
        return this;
    }

    /**
        Dot product of this vector with another vector.
    **/
    public function dot(other:FloatVector2):Float {
        return this.x*other.x + this.y*other.y;
    }

    /**
        Cross product of this vector with another vector.
        
        The sign follows right-hand rule convention.
    **/
    public function cross(other:FloatVector2):Float {
        return this.x*other.y - this.y*other.x;
    }

    /**
        Multiplies each part of this vector with another vector in place.
    **/
    public function multByParts(other:FloatVector2):FloatVector2 {
        this.x *= other.x;
        this.y *= other.y;
        return this;
    }

    /**
        Scalar division of this vector in place.
    **/
    public function div(scale:Float):FloatVector2 {
        this.x /= scale;
        this.y /= scale;
        return this;
    }

    /**
        Divides each part of this vector with another vector in place.
    **/
    public function divByParts(other:FloatVector2):FloatVector2 {
        this.x /= other.x;
        this.y /= other.y;
        return this;
    }

    /**
        Negate a vector in place.
    **/
    public function not():FloatVector2 {
        this.x *= -1;
        this.y *= -1;
        return this;
    }

    /**
        Check if this vector has the same part values as another vector. Returns a corresponding Bool value.
    **/
    public function isSame(other:FloatVector2):Bool {
        return this.x == other.x && this.y == other.y;
    }

    /**
        Check if this vector has the same part values as another vector. Returns a BoolVector2 with part values corresponding to the comparison results.
    **/
    public function isSameByParts(other:FloatVector2):BoolVector2 {
        var result = new BoolVector2();
        result.x = this.x == other.x;
        result.y = this.y == other.y;
        return result;
    }

    /**
        Returns the vector length corresponding to its parts (not to be confused with the length property, which is always 2).
    **/
    public var vlen(get, never):Float;

    inline function get_vlen():Float {
        return Math.sqrt(this.x*this.x + this.y*this.y);
    }

    /**
        Returns the angle corresponding to the vector's parts (i.e. Cartesian to polar conversion).
    **/
    public var angle(get, never):Float;
    
    inline function get_angle():Float {
        return Math.atan2(this.y, this.x);
    }

    /**
        Normalizes this vector in place to a vlen of 1 in the same direction.

        If vector length happens to be 0, it will remain at 0.
    **/
    public function normalize():FloatVector2 {
        if (this.x == 0 && this.y == 0) return this;
        var vlen = Math.sqrt(this.x*this.x + this.y*this.y);
        this.x /= vlen;
        this.y /= vlen;
        return this;
    }    
}