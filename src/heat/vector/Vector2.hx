package heat.vector;

@:forward
abstract Vector2<T>(haxe.ds.Vector<T>) {
    public var x(get, set):T;
    public var y(get, set):T;

    public inline function new() {
        this = new haxe.ds.Vector(2);
    }

    public inline function get_x():T {
        return this[0];
    }

    public inline function get_y():T {
        return this[1];
    }

    public inline function set_x(x:T):T {
        this[0] = x;
        return x;
    }

    public inline function set_y(y:T):T {
        this[1] = y;
        return y;
    }
}