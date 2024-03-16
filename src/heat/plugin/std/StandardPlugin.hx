package heat.plugin.std;

#if (macro || eval)
import haxe.macro.Expr;
import haxe.macro.Context;
import heat.plugin.PluginTools;

class StandardPlugin {
	public macro static function apply():Array<Field> {
		final fields = Context.getBuildFields();
		switch (PluginTools.addGroupFieldToBuildFields(fields, "com", comMapExprs)) {
			case Err(err):
				return Context.error(err, Context.currentPos());
			case Ok(_):
				{}
		}
		return fields;
	}

	public static function addFieldsToInterfaceTD(td:TypeDefinition):Void {
		switch (PluginTools.addGroupFieldToTypeDef(td, "com", comMapExprs)) {
			case Err(err):
				Context.error(err, Context.currentPos());
			case Ok(_):
				{}
		}
	}

	public macro static function init():Void {
		PluginTools.makeInitMacro("I_UsesHeatStandardPlugin", (td:TypeDefinition) -> {
			addFieldsToInterfaceTD(td);
		});
	}

	public static final comMapExprs = macro [
		parents is heat.ecs.EntityId,
		childrenLists is Array<heat.ecs.EntityId>,
		transform is heat.core.MTransform,
		absPosTransform is heat.core.MTransform,
		camera is heat.camera.Camera,
		drawOrder is Int,
		names is String,
		textureRegions is heat.texture.TextureRegion,
		flexBoxes is heat.ui.FlexBox,
		flexBoxItems is heat.ui.FlexBoxItem,
		dimensions is heat.core.Dimension,
		audioSources is heat.audio.AudioSource,
		textGraphics is heat.text.ITextGraphic,
		audioInstances is heat.audio.IAudioInstance,
	];
}
#end
