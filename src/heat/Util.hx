package heat;

import haxe.ds.Either;

class Util {
    /**
        Checks if a subject value is null, and if so, returns another specified value; otherwise, returns the subject.
        This can be useful as a way to handle potential nulls, e.g. from optional parameters.
    **/
    public static inline function ifnull<T>(subject:T, isnull:T):T {
        return (subject == null) ? isnull : subject;
    }
}

abstract StringOrInt(Either<String, Int>) from Either<String, Int> 
to Either<String, Int> {
    @:from
    inline public static function fromString(s:String):StringOrInt {
        return Left(s);
    }

    @:from
    inline public static function fromInt(i:Int):StringOrInt {
        return Right(i);
    }

    @:to
    inline public function toString():String {
        switch (this) {
            case Left(s): return s;
            case Right(i): return Std.string(i);
        }
    }

    @:to
    inline public function toInt():Null<Int> {
        switch (this) {
            case Left(s): return null;
            case Right(i): return i;
        }
    }

    @:op(a == b) public static inline function eq(a:StringOrInt, b:StringOrInt):Bool {
        return switch a {
            case Left(a): switch b {
                case Left(b): a == b;
                case Right(b): false;
            }
            case Right(a): switch b{
                case Left(b): false;
                case Right(b): a == b;
            }
        }
    }
}