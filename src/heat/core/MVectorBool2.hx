package heat.core;

@:forward
@:forwardStatics
abstract MVectorBool2(MVector2<Bool>) from MVector2<Bool> to MVector2<Bool> {
    public inline function new(x=false, y=false) {
        this = new MVector2<Bool>(x, y);
    }

    /**
        AND two vectors, returning a new vector.
    **/
    @:op(A&&B)
    @:commutative
    inline function op_and(other:IVector2<Bool>):MVectorBool2 {
        return new MVectorBool2(this.x && other.x, this.y && other.y);
    }

    /**
        AND this vector with another in place.
    **/
    public function andWith(other:IVector2<Bool>):MVectorBool2 {
        this.x = this.x && other.x;
        this.y = this.y && other.y;
        return this;
    }

    /**
        OR two vectors, returning a new vector.
    **/
    @:op(A||B)
    @:commutative
    inline function op_or(other:IVector2<Bool>):MVectorBool2 {
        return new MVectorBool2(this.x || other.x, this.y || other.y);
    }

    /**
        OR this vector with another in place.
    **/
    public function orWith(other:IVector2<Bool>):MVectorBool2 {
        this.x = this.x || other.x;
        this.y = this.y || other.y;
        return this;
    }

    /**
        Negate a vector, returning a new vector.
    **/
    @:op(!A)
    inline function op_not():MVectorBool2 {
        return new MVectorBool2(!this.x, !this.y);
    }

    /**
        Negate a vector in place.
    **/
    public function not():MVectorBool2 {
        this.x = !this.x;
        this.y = !this.y;
        return this;
    }

    /**
        Check if this vector has the same part values as another vector. Returns a corresponding Bool value.
    **/
    public inline function isSameAs(other:IVector2<Bool>):Bool {
        return VectorBool2.areSame(this, other);
    }

    public inline function toFloats():MVectorFloat2 {
        return new MVectorFloat2(this.x ? 1 : 0, this.y ? 1 : 0);
    }

    public static inline function fromFloats(source:IVector2<Float>):MVectorBool2 {
        return new MVectorBool2(source.x != 0, source.y != 0);
    }
}