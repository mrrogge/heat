package heat.core.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.MacroStringTools;

using heat.core.Result.ResultTools;

#if (macro || eval)
class HeatSpaceMacro {
    macro static public function addComMaps(comMapsExpr:Expr):Array<Field> {
        final fields = Context.getBuildFields();
        switch (makeComMapFields(comMapsExpr, true)) {
            case Err(err): return Context.error(err, Context.currentPos());
            case Ok(newFields): {
                return fields.concat(newFields);
            }
        }
    }

    macro static public function addComMap(comMapExpr:Expr):Array<Field> {
        final fields = Context.getBuildFields();
        switch (makeComMapField(comMapExpr, true)) {
            case Err(err): {
                return Context.error(err, Context.currentPos());
            }
            case Ok(field): {
                fields.push(field);
            }
        }
        return fields;
    }

    /**
        Constructs a new field from an expression in the form of `{identifier} is {type}`. 

        The new field name will be `{identifier}` and the type of the field will be `heat.ecs.ComMap<{type}>`.

        This is intended for augmenting `HeatSpace` subclasses with user-defined components.
    **/
    public static function makeComMapField(comMapExpr:Expr, ?withInit:Bool):heat.core.Result<Field, String> {
        switch (comMapExpr.expr) {
            case EIs(e, t): {
                final fieldName = switch (e.expr) {
                    case EConst(CIdent(fieldName)): {
                        fieldName;
                    }
                    default: {
                        return Err("must specify a valid identifier");
                    }
                }
                final accessFlags = [APublic, AFinal];
                final field:Field = {
                    name: fieldName,
                    kind: FVar(macro : heat.ecs.ComMap<$t>, withInit ? macro new heat.ecs.ComMap() : null),
                    pos: comMapExpr.pos,
                    access: accessFlags,
                };
                return Ok(field);
            }
            default: {
                return Err('must specify an "identifier is Type" expression');
            }
        }
    }

    public static function makeComMapFields(comMapsExpr:Expr, ?withInit:Bool):heat.core.Result<Array<Field>, String> {
        final comMapsExprArray = switch (comMapsExpr.expr) {
            case EArrayDecl(values): {
                values;
            }
            default: {
                return Err('Expression should be array of "identifier is type" sub-expressions.');
            }
        }
        return Result.all(comMapsExprArray.map((e) -> makeComMapField(e, withInit)));
    }

    public static function makeComMapObjectField(comMapExpr:Expr):heat.core.Result<ObjectField, String> {
        switch (comMapExpr.expr) {
            case EIs(e, t): {
                final fieldName = switch (e.expr) {
                    case EConst(CIdent(fieldName)): {
                        fieldName;
                    }
                    default: {
                        return Err("must specify a valid identifier");
                    }
                }
                final field:ObjectField = {
                    field: fieldName,
                    expr: {
                        expr: ENew({
                            pack: ["heat", "ecs"],
                            name: "ComMap",
                            params: [TPType((macro : $t))],
                        }, []),
                        pos: Context.currentPos(),
                    }
                };
                return Ok(field);
            }
            default: {
                return Err('must specify an "identifier is Type" expression');
            }
        }
    }

    public static function makeComMapObjectFields(comMapsExpr:Expr):heat.core.Result<Array<ObjectField>, String> {
        final comMapsExprArray = switch (comMapsExpr.expr) {
            case EArrayDecl(values): {
                values;
            }
            default: {
                return Err('Expression should be array of "identifier is type" sub-expressions.');
            }
        }
        return Result.all(comMapsExprArray.map((e) -> makeComMapObjectField(e)));
    }

    public static function makeComMapStructType(comMapsExpr:Expr):heat.core.Result<ComplexType, String> {
        final comMapsExprArray = switch (comMapsExpr.expr) {
            case EArrayDecl(values): {
                values;
            }
            default: {
                return Err('Expression should be array of "identifier is type" sub-expressions.');
            }
        }

        switch (Result.all(comMapsExprArray.map((e) -> makeComMapField(e, false)))) {
            case Ok(result): {
                return Ok(TAnonymous(result));
            }
            case Err(err): return Err(err);
        }
    }
}

#end