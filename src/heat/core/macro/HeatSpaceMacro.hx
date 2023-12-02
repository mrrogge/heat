package heat.core.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.MacroStringTools;

@:keep
class HeatSpaceMacro {
    macro static public function applyGamePlugin():Array<Field> {
        final fields = Context.getBuildFields();
        final comMapExprs:Array<Expr> = [
            macro colliders is heat.core.Circle,
            macro heroMap is heat.core.Noise,
        ];
        for (comMapExpr in comMapExprs) {
            switch (_addComMap(fields, comMapExpr)) {
                case Err(err): {
                    return Context.error(err, Context.currentPos());
                }
                case Ok(_): {}
            }
        }
        return fields;
    }

    macro static public function addComMap(comMapExpr:Expr):Array<Field> {
        final fields = Context.getBuildFields();
        switch (_addComMap(fields, comMapExpr)) {
            case Err(err): {
                return Context.error(err, Context.currentPos()); 
            }
            case Ok(_): {}
        };
        return fields;
    }

    static function _addComMap(buildFields:Array<Field>, comMapExpr:Expr):heat.core.Result<Noise, String> {
        switch (comMapExpr.expr) {
            case EIs(e, t): {
                var fieldName = switch (e.expr) {
                    case EConst(CIdent(fieldName)): {
                        fieldName;
                    }
                    default: {
                        return Err("must specify a valid identifier");
                    }
                }
                var newField:Field = {
                    name: fieldName,
                    kind: FVar(macro : heat.ecs.ComMap<$t>, macro new heat.ecs.ComMap()),
                    pos: comMapExpr.pos,
                };
                buildFields.push(newField);
                return Ok(Noise);
            }
            default: {
                return Err('must specify an "identifier is Type" expression');
            }
        }
    }
}