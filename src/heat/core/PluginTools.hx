package heat.core;

import haxe.macro.Expr;
import haxe.macro.Context;

#if (macro || eval)
class PluginTools {
    public static function applyWrapper<T>(cls:Class<T>, comMapExprs:Expr, groupFieldName:String):Array<Field> { 
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

	public static function initWrapper<T>(cls:Class<T>, comMapExprs:Expr, interfaceName:String, groupFieldName:String) {
		Context.onAfterInitMacros(() -> {
			try {
				Context.getType('heat.${interfaceName}');
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
					pack: ['heat'],
					name: interfaceName,
					pos: Context.currentPos(),
					kind: TDClass(null, null, true, false, false),
					fields: [
						{
							name: groupFieldName,
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
}
#end