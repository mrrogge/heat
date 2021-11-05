package heat.vector;

private typedef MutVector2Impl<T> = {
    var x:T;
    var y:T;
};

abstract MutVector2<T>(MutVector2Impl<T>) {
    public inline function new(x:T, y:T) {
        this = {x: x, y: y};
    }
}