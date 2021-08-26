package heat.vector;

@:forward
abstract Vector3<T>(haxe.ds.Vector<T>) {
    public var x(get, set):T;
    public var y(get, set):T;
    public var z(get, set):T;

    public inline function new() {
        this = new haxe.ds.Vector(3);
    }

    public inline function get_x():T {
        return this[0];
    }

    public inline function get_y():T {
        return this[1];
    }
    
    public inline function get_z():T {
        return this[2];
    }
    
    public inline function set_x(x:T):T {
        this[0] = x;
        return x;
    }

    public inline function set_y(y:T):T {
        this[1] = y;
        return y;
    }

    public inline function set_z(z:T):T {
        this[2] = z;
        return z;
    }
}