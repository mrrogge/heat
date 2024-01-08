package heat.ecs;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.MacroStringTools;

import heat.core.Result;

using heat.core.Result.ResultTools;

import heat.ecs.ComMap;

class EcsMacros {
	macro static public function addComMaps(comMapsExpr:Expr):Array<Field> {
		final fields = Context.getBuildFields();
		switch (makeComMapFields(comMapsExpr, true)) {
			case Err(err):
				return Context.error(err, Context.currentPos());
			case Ok(newFields):
				{
					return fields.concat(newFields);
				}
		}
	}

	macro static public function addComMap(comMapExpr:Expr):Array<Field> {
		final fields = Context.getBuildFields();
		switch (makeComMapField(comMapExpr, true)) {
			case Err(err):
				{
					return Context.error(err, Context.currentPos());
				}
			case Ok(field):
				{
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
	public static function makeComMapField(comMapExpr:Expr, ?withInit:Bool):Result<Field, String> {
		switch (comMapExpr.expr) {
			case EIs(e, t):
				{
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
						kind: FVar(macro :heat.ecs.ComMap<$t>, withInit ? macro new heat.ecs.ComMap() : null),
						pos: comMapExpr.pos,
						access: accessFlags,
					};
					return Ok(field);
				}
			default:
				{
					return Err('must specify an "identifier is Type" expression');
				}
		}
	}

	public static function makeComMapFields(comMapsExpr:Expr, ?withInit:Bool):Result<Array<Field>, String> {
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

	public static function makeComMapObjectField(comMapExpr:Expr):Result<ObjectField, String> {
		switch (comMapExpr.expr) {
			case EIs(e, t):
				{
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
								params: [TPType((macro :$t))],
							}, []),
							pos: Context.currentPos(),
						}
					};
					return Ok(field);
				}
			default:
				{
					return Err('must specify an "identifier is Type" expression');
				}
		}
	}

	public static function makeComMapObjectFields(comMapsExpr:Expr):Result<Array<ObjectField>, String> {
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

	public static function makeComMapStructType(comMapsExpr:Expr):Result<ComplexType, String> {
		final comMapsExprArray = switch (comMapsExpr.expr) {
			case EArrayDecl(values): {
					values;
				}
			default: {
					return Err('Expression should be array of "identifier is type" sub-expressions.');
				}
		}

		switch (Result.all(comMapsExprArray.map((e) -> makeComMapField(e, false)))) {
			case Ok(result):
				{
					return Ok(TAnonymous(result));
				}
			case Err(err):
				{
					return Err(err);
				}
		}
	}

	public static function joinComMapsExpr(expr1:Expr, expr2:Expr):Result<Expr, String> {
		final exprArray1 = switch (expr1.expr) {
			case EArrayDecl(values): {
					values;
				}
			default: {
					return Err('Expression should be array of "identifier is type" sub-expressions.');
				}
		}
		final exprArray2 = switch (expr2.expr) {
			case EArrayDecl(values): {
					values;
				}
			default: {
					return Err('Expression should be array of "identifier is type" sub-expressions.');
				}
		}
		final joined = exprArray1.concat(exprArray2);
		return Ok({
			expr: EArrayDecl(joined),
			pos: Context.currentPos()
		});
	}
}
#end
