package heat.core.macro;

import haxe.macro.Context;

#if (macro || eval)
@:keep
class TupleBuilder {
	public static function build(arity:Int):Void {
		buildTuple(arity);
		buildMTuple(arity);
	}

	public static function buildTuple(arity:Int):Void {
		if (arity < 0)
			Context.error('arity must be >= 0 but is $arity.', Context.currentPos());
		try {
			Context.getType('heat.core.Tuple$arity');
		} catch (e:String) {
			// The element fields
			var fields:Array<haxe.macro.Expr.Field> = [
				for (i in 0...arity)
					{
						name: 'e$i',
						access: [APublic],
						kind: FProp("default", "null", TPath({
							pack: [],
							name: 'T$i'
						})),
						pos: Context.currentPos()
					}
			];
			// The constructor
			fields.push({
				pos: Context.currentPos(),
				name: "new",
				access: [APublic],
				kind: FFun({
					args: [
						for (i in 0...arity)
							{
								name: 'e$i',
								type: TPath({
									pack: [],
									name: 'T$i'
								})
							}
					],
					expr: {
						pos: Context.currentPos(),
						expr: EBlock([
							for (i in 0...arity)
								{
									pos: Context.currentPos(),
									expr: EBinop(OpAssign, {
										pos: Context.currentPos(),
										expr: EField(macro $i{"this"}, 'e$i')
									}, macro $i{'e$i'})
								}
						])
					}
				})
			});

			var clsDef:haxe.macro.Expr.TypeDefinition = {
				pos: Context.currentPos(),
				name: 'Tuple$arity',
				pack: ["heat", "core"],
				kind: TDClass(),
				params: [for (i in 0...arity) {name: 'T$i'}],
				fields: fields
			};
			Context.defineModule('heat.core.Tuple$arity', [clsDef]);
		}
	}

	public static function buildMTuple(arity:Int):Void {
		if (arity < 0)
			Context.error('arity must be >= 0 but is $arity.', Context.currentPos());
		try {
			Context.getType('heat.core.MTuple$arity');
		} catch (e:String) {
			// The element fields
			var fields:Array<haxe.macro.Expr.Field> = [
				for (i in 0...arity)
					{
						name: 'e$i',
						access: [APublic],
						kind: FVar(TPath({
							pack: [],
							name: 'T$i'
						})),
						pos: Context.currentPos()
					}
			];
			// The constructor
			fields.push({
				pos: Context.currentPos(),
				name: "new",
				access: [APublic],
				kind: FFun({
					args: [
						for (i in 0...arity)
							{
								name: 'e$i',
								type: TPath({
									pack: [],
									name: 'T$i'
								})
							}
					],
					expr: {
						pos: Context.currentPos(),
						expr: EBlock([
							for (i in 0...arity)
								{
									pos: Context.currentPos(),
									expr: EBinop(OpAssign, {
										pos: Context.currentPos(),
										expr: EField(macro $i{"this"}, 'e$i')
									}, macro $i{'e$i'})
								}
						])
					}
				})
			});

			var clsDef:haxe.macro.Expr.TypeDefinition = {
				pos: Context.currentPos(),
				name: 'MTuple$arity',
				pack: ["heat", "core"],
				kind: TDClass(),
				params: [for (i in 0...arity) {name: 'T$i'}],
				fields: fields
			};
			Context.defineModule('heat.core.MTuple$arity', [clsDef]);
		}
	}

	public static function buildTuplesUpTo(arity:Int):Void {
		for (i in 1...arity + 1) {
			build(i);
		}
	}

	public static function init():Void {
		Context.onAfterInitMacros(() -> buildTuplesUpTo(5));
	}
}
#end
