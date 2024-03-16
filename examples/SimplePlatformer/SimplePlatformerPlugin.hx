#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
import heat.plugin.PluginTools;
import heat.plugin.std.StandardPlugin;

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
		PluginTools.makeInitMacro("I_UsesSimplePlatformerPlugin", (td:TypeDefinition) -> {
			heat.plugin.std.StandardPlugin.addFieldsToInterfaceTD(td);
			switch (PluginTools.addGroupFieldToTypeDef(td, "game", comMapExprs)) {
				case Err(err): Context.error(err, Context.currentPos());
				case Ok(_): {}
			}
		});
	}

	static final comMapExprs = macro [
		heroMap is heat.core.Noise,
		colliders is heat.core.Circle,
		heroMoveStates is HeroMoveState,
		uiObjects is heat.core.Noise,
		worldObjects is heat.core.Noise,
		tileMaps is tilemap.TileMap,
	];
}
#end
