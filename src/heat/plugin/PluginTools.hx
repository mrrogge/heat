package heat.plugin;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
import heat.core.Result;

using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;

class PluginTools {
	/**
		Creates a new plugin interface type definition using the minimum functionality for a HeatSpace.
	**/
	public static function makeMinimumInterfaceTD(name:String):TypeDefinition {
		final td = macro interface $name {
			// basics
			public function update(dt:Float):Void;
			public function getNextID():heat.ecs.EntityId;
			public var lastID(default, null):Null<heat.ecs.EntityId>;
			// key input
			public final onKeyPressedSlot:heat.event.Slot<heat.key.KeyCode>;
			public final onKeyReleasedSlot:heat.event.Slot<heat.key.KeyCode>;
			// graphics
			public final windowResizeRequestedSignal:heat.event.ISignal<heat.core.window.Window.WindowResizeRequest>;
			public dynamic function makeTextGraphic():heat.text.ITextGraphic;
			public dynamic function getDrawCallCount():Int;
			public dynamic function getFPS():Float;
			public dynamic function makeWindow():heat.core.Result<heat.core.Tuple2<heat.graphics.IWindow, heat.graphics.WindowIndex>, String>;
			public dynamic function destroyWindow(index:heat.graphics.WindowIndex):heat.core.Result<heat.core.Noise, String>;
			// audio
			public dynamic function playAudio(source:heat.audio.AudioSource):heat.core.Result<heat.audio.IAudioInstance, String>;
		};
		td.pack = ['heat'];
		return td;
	}

	public static function addGroupFieldToTypeDef(td:TypeDefinition, fieldName:String, comMapExprs:Expr):Result<TypeDefinition, String> {
		final fields = switch (heat.ecs.EcsMacros.makeComMapObjectFields(comMapExprs)) {
			case Ok(fields): fields;
			case Err(err): {
					return Err(err);
				}
		}

		final structType = switch (heat.ecs.EcsMacros.makeComMapStructType(comMapExprs)) {
			case Ok(result): result;
			case Err(err): {
					return Err(err);
				}
		}
		td.fields.push({
			name: fieldName,
			access: [APublic, AFinal],
			kind: FVar(structType),
			pos: Context.currentPos(),
		});
		return Ok(td);
	}

	public static function addGroupFieldToBuildFields(buildFields:Array<Field>, fieldName:String, comMapExprs:Expr):Result<Array<Field>, String> {
		final fields = switch (heat.ecs.EcsMacros.makeComMapObjectFields(comMapExprs)) {
			case Ok(fields): fields;
			case Err(err): {
					return Err(err);
				}
		}

		final structType = switch (heat.ecs.EcsMacros.makeComMapStructType(comMapExprs)) {
			case Ok(result): result;
			case Err(err): {
					return Err(err);
				}
		}
		buildFields.push({
			name: fieldName,
			access: [APublic, AFinal],
			kind: FVar(structType, {
				expr: EObjectDecl(fields),
				pos: Context.currentPos(),
			}),
			pos: Context.currentPos(),
		});
		return Ok(buildFields);
	}

	public static function applyWrapper(comMapExprs:Expr, groupFieldName:String):Array<Field> {
		var fields = Context.getBuildFields();
		final newFields = switch (heat.ecs.EcsMacros.makeComMapObjectFields(comMapExprs)) {
			case Err(err): {
					return Context.error(err, Context.currentPos());
				}
			case Ok(newFields): newFields;
		}

		final structType = switch (heat.ecs.EcsMacros.makeComMapStructType(comMapExprs)) {
			case Ok(result): result;
			case Err(err): {
					return Context.error(err, Context.currentPos());
				}
		}

		final stdField:Field = {
			name: groupFieldName,
			access: [APublic, AFinal],
			kind: FVar(structType, {
				expr: EObjectDecl(newFields),
				pos: Context.currentPos(),
			}),
			pos: Context.currentPos()
		}

		fields.push(stdField);

		return fields;
	}

	public static function makeInitMacro(interfaceName:String, modifierFunction:(td:TypeDefinition) -> Void) {
		Context.onAfterInitMacros(() -> {
			try {
				Context.getType('heat.${interfaceName}');
			} catch (e:String) {
				final td = makeMinimumInterfaceTD(interfaceName);
				modifierFunction(td);
				Context.defineType(td);
			}
		});
	}

	public macro static function makeMinimalInterface():Void {
		PluginTools.makeInitMacro("I_MinimalHeatSpace", (td:TypeDefinition) -> {});
	}
}
#end
