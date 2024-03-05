package heat.core;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;

using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;

class PluginTools {
	public static function makeInterface(name:String):TypeDefinition {
		final td = macro interface $name {
			public var lastID(default, null):Null<heat.ecs.EntityId>;
			public var onKeyPressedSlot:heat.event.Slot<heat.key.KeyCode>;
			public var onKeyReleasedSlot:heat.event.Slot<heat.key.KeyCode>;
			public var onWindowResizeRequestSignal:heat.event.ISignal<heat.core.window.Window.WindowResizeRequest>;
			public final comQueryPool:heat.ecs.ComQueryPool;
			public var bridge:Null<heat.bridges.IHeatBridge>;
			public function getNextID():heat.ecs.EntityId;
			public function update(dt:Float):Void;
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

	public static function initWrapper(name:String, buildTypeDef:(name:String) -> TypeDefinition) {
		Context.onAfterInitMacros(() -> {
			try {
				Context.getType('heat.${name}');
			} catch (e:String) {
				final td = buildTypeDef(name);
				Context.defineType(td);
			}
		});
	}
}
#end
