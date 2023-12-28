import haxe.macro.Expr;
import haxe.macro.Context;

using heat.core.PluginTools;

#if (macro || eval)
class SimplePlatformerPlugin {
	public static macro function apply():Array<Field> {
		return SimplePlatformerPlugin.applyWrapper(comMapExprs, "game");
	}

	public static function init():Void {
		SimplePlatformerPlugin.initWrapper(comMapExprs, "I_UsesSimplePlatformerPlugin", "game");
	}

	static final comMapExprs = macro [
		heroMap is heat.core.Noise,
		colliders is heat.core.Circle,
		heroMoveStates is HeroMoveState,
		uiObjects is heat.core.Noise,
		worldObjects is heat.core.Noise,
	];
}
#end
