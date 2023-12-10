package heat.core;

import haxe.macro.Expr;
import haxe.macro.Context;

class StandardPlugin {
	public macro static function applyStandardPlugin():Array<Field> {
		var fields = Context.getBuildFields();
		final newFields = switch (heat.core.macro.HeatSpaceMacro.makeComMapObjectFields(comMapExprs)) {
			case Err(err): {
					return Context.error(err, Context.currentPos());
				}
			case Ok(newFields): newFields;
		}

		final structType = switch (heat.core.macro.HeatSpaceMacro.makeComMapStructType(comMapExprs)) {
			case Ok(result): result;
			case Err(err): {
				return Context.error(err, Context.currentPos());
			}
		}

		final stdField:Field = {
			name: "com",
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

	public macro static function init():Void {
		Context.onAfterInitMacros(() -> {
			try {
				Context.getType("I_UsesHeatStandardPlugin");
			} catch (e:String) {
				final interfaceFields = switch (heat.core.macro.HeatSpaceMacro.makeComMapFields(comMapExprs, false)) {
					case Err(err): {
							Context.error(err, Context.currentPos());
							return;
						}
					case Ok(newFields): newFields;
				}

				final structType = switch (heat.core.macro.HeatSpaceMacro.makeComMapStructType(comMapExprs)) {
					case Ok(result): {
							result;
						}
					case Err(err): {
							Context.error(err, Context.currentPos());
							return;
						}
				}

				var interfaceType:TypeDefinition = {
					pack: [],
					name: 'I_UsesHeatStandardPlugin',
					pos: Context.currentPos(),
					kind: TDClass(null, null, true, false, false),
					fields: [
						{
							name: "com",
							access: [APublic, AFinal],
							kind: FVar(structType),
							pos: Context.currentPos(),
						}
					]
				}
				Context.defineType(interfaceType);
			}
		});
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
