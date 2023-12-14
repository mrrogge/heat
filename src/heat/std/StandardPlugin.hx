package heat.std;

import haxe.macro.Expr;
import haxe.macro.Context;

using heat.core.PluginTools;

#if (macro || eval)
class StandardPlugin {
	public macro static function applyStandardPlugin():Array<Field> {
		return StandardPlugin.applyWrapper(comMapExprs, "com");
	}

	public macro static function init():Void {
		StandardPlugin.initWrapper(comMapExprs, "I_UsesHeatStandardPlugin", "com");
	}

	private static final comMapExprs = macro [
		parents is heat.ecs.EntityId,
		childrenLists is Array<heat.ecs.EntityId>,
		transform is heat.core.MTransform,
		absPosTransform is heat.core.MTransform,
		camera is heat.core.Camera,
		drawOrder is Int,
		names is String,
		textureRegions is heat.texture.TextureRegion,
	];
}
#end
