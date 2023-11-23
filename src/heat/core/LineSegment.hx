package heat.core;

using heat.core.MathTools;

class LineSegment implements ILineSegment {
    public var x1(get, never):Float;
    inline function get_x1():Float return p1.x;

    public var y1(get, never):Float;
    inline function get_y1():Float return p1.y;

    public var x2(get, never):Float;
    inline function get_x2():Float return p2.x;

    public var y2(get, never):Float;
    inline function get_y2():Float return p2.y;

    final p1:VectorFloat2;
    final p2:VectorFloat2;

    public function new(x1=0., y1=0., x2=0., y2=0.) {
        p1 = new VectorFloat2(x1, y1);
        p2 = new VectorFloat2(x2, y2);
    }

    public static inline function fromVectors(v1:IVector2<Float>, v2:IVector2<Float>):LineSegment {
        return new LineSegment(v1.x, v1.y, v2.x, v2.y);
    }

    public inline function clone():LineSegment {
        return LineSegment.fromVectors(p1, p2);
    }

    public inline function lengthSquared():Float {
        return VectorFloat2.distSquared(p1, p2);
    }

    public inline function length():Float {
        return VectorFloat2.dist(p1, p2);
    }

    public static inline function areSame(s1:ILineSegment, s2:ILineSegment):Bool {
        return s1.x1 == s2.x1 && s1.y1 == s2.y1 && s1.x2 == s2.x2 && s1.y2 == s2.y2;
    }

    public inline function sameAs(other:ILineSegment):Bool {
        return areSame(this, other);
    }

    public static inline function areClose(s1:ILineSegment, s2:ILineSegment):Bool {
        return s1.x1 - s2.x1 <= Math.FP_ERR()
            && s1.y1 - s2.y1 <= Math.FP_ERR()
            && s1.x2 - s2.x2 <= Math.FP_ERR()
            && s1.y2 - s2.y2 <= Math.FP_ERR();
    }

    public inline function closeTo(other:ILineSegment):Bool {
        return areClose(this, other);
    }

    public inline function translateBy(x:Float, y:Float):LineSegment {
        return new LineSegment(x1+x, y1+y, x2+x, y2+y);
    }

    public inline function toMutable():MLineSegment {
        return MLineSegment.fromVectors(p1, p2);
    }

    public static inline function fromMutable(mutable:MLineSegment):LineSegment {
        return new LineSegment(mutable.x1, mutable.y1, mutable.x2, mutable.y2);
    }
}