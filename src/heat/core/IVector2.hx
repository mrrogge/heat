package heat.core;

/**
	Common interface for 2-component vectors. See Vector2 and MVector2.
**/
interface IVector2<T> {
	public var x(get, never):T;
	public var y(get, never):T;
	public function isSameAs(other:IVector2<T>):Bool;
	public function isSameByPartsWith(other:IVector2<T>):IVector2<Bool>;
}
