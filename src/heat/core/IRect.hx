package heat.core;

interface IRect {
    public var x(get, never):Float;
    public var y(get, never):Float;
    public var w(get, never):Float;
    public var h(get, never):Float;
    public function isSameAs(other:IRect):Bool;
}