package heat.core;

/**An immutable vector with 2 components.**/
class Vector2<T> implements IVector2<T> {
    public var x(get, never):T;
    inline function get_x():T return _x;
    
    public var y(get, never):T;
    inline function get_y():T return _y;

    final _x:T;
    final _y:T;

    public function new(x:T, y:T) {
        _x = x;
        _y = y;
    }

    public inline function toMutable():MVector2<T> {
        return new MVector2<T>(x, y);
    }

    public static inline function fromMutable<T>(mutable:MVector2<T>):Vector2<T> {
        return new Vector2<T>(mutable.x, mutable.y);
    }

    public inline function clone():Vector2<T> {
        return new Vector2(x, y);
    }

    /**
        Compare two vectors by parts, returning true if like parts are all equal (otherwise false).
    **/
    public static inline function areSame<T>(v1:IVector2<T>, v2:IVector2<T>):Bool {
        return v1.x == v2.x && v1.y == v2.y;
    }
       
    /**
        Check if this vector has the same part values as another vector. Returns a corresponding Bool value.
    **/
    public inline function isSameAs(other:IVector2<T>):Bool {
        return areSame(this, other);
    }

    /**
        Check part values between two vectors for sameness. Returns a new boolean vector corresponding to the comparison results.
    **/
    public static inline function areSameByParts<T>(v1:IVector2<T>, v2:IVector2<T>):VectorBool2 {
        return new VectorBool2(v1.x == v2.x, v1.y == v2.y);
    }

    /**
        Check part values against another vector. Returns a new boolean vector corresponding to the comparison results.
    **/
    public inline function isSameByPartsWith(other:IVector2<T>):VectorBool2 {
        return areSameByParts(this, other);
    }


}