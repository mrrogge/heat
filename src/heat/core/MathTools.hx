package heat.core;

class MathTools {
    /** 
        Acceptable floating-point error for comparison operations.
    **/
    public static inline function FP_ERR(cls:Class<Math>):Float {
        return
        #if (heat_fp_err >= 0)
        haxe.macro.Context.definedValue("heat_fp_err");
        #elseif (heat_fp_err < 0)
        0;
        #else
        1e-10;
        #end
    }

    public static inline function nearest(cls:Class<Math>, x:Float, a:Float, b:Float):Float {
        return (Math.abs(a-x) < Math.abs(b-x)) ? a : b;
    }

    public static inline function sign(cls:Class<Math>, x:Float):Int {
        return x < 0 ? -1 : (x == 0 ? 0 : 1);
    }
}