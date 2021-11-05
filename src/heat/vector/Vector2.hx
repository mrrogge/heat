package heat.vector;

private typedef Vector2Impl<T> = {
    final x:T;
    final y:T;
};

@:forward
abstract Vector2<T>(Vector2Impl<T>) {
    public inline function new(x:T, y:T) {
        this = {x: x, y: y};
    }
}