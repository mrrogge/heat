#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
import heat.core.PluginTools;
import heat.std.StandardPlugin;

class SimplePlatformerPlugin {
	public static macro function apply():Array<Field> {
		final fields = Context.getBuildFields();
		switch (PluginTools.addGroupFieldToBuildFields(fields, "game", comMapExprs)) {
			case Err(err):
				return Context.error(err, Context.currentPos());
			case Ok(_):
				{}
		}
		return fields;
	}

	public static function init():Void {
		PluginTools.initWrapper("I_UsesSimplePlatformerPlugin", (name:String) -> {
			final td = PluginTools.makeInterface(name);
			switch (PluginTools.addGroupFieldToTypeDef(td, "com", StandardPlugin.comMapExprs)) {
				case Err(err): return Context.error(err, Context.currentPos());
				case Ok(_): {}
			}
			switch (PluginTools.addGroupFieldToTypeDef(td, "game", comMapExprs)) {
				case Err(err): return Context.error(err, Context.currentPos());
				case Ok(_): {}
			}
			return td;
		});
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
