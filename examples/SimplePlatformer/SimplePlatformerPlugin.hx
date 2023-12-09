import haxe.macro.Expr;
import haxe.macro.Context;

class SimplePlatformerPlugin {
    public static macro function build():Array<Field> {
        var fields = Context.getBuildFields();
        final comMapExprs = macro [
            heroMap is heat.core.Noise,
            colliders is heat.core.Circle,
        ];
        final newFields = switch (heat.core.macro.HeatSpaceMacro.makeComMapFields(comMapExprs, true)) {
            case Err(err): {
                return Context.error(err, Context.currentPos());
            }
            case Ok(newFields): newFields;
        }

        fields = fields.concat(newFields);

        return fields;
    }

    #if (macro || eval)
    @:keep
    public static function init():Void {
        Context.onAfterInitMacros(() -> {            
            final comMapExprs = macro [
                heroMap is heat.core.Noise,
                colliders is heat.core.Circle,
            ];

            final interfaceFields = switch (heat.core.macro.HeatSpaceMacro.makeComMapFields(comMapExprs, false)) {
                case Err(err): {
                    Context.error(err, Context.currentPos());
                    return;
                }
                case Ok(newFields): newFields;
            }
            
            var interfaceType:TypeDefinition = {
                pack: [],
                name: 'I_SimplePlatformerSpace',
                pos: Context.currentPos(),
                kind: TDClass(null, null, true, false, false),
                fields: interfaceFields,
            }
    
            Context.defineType(interfaceType);
        });
    }
    #end
}