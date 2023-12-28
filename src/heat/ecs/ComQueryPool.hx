package heat.ecs;

using heat.HeatPrelude;

class ComQueryPool extends Pool<ComQuery> {
	override public function new() {
		super(ComQueryPool._constructor, ComQueryPool._init);
	}

	static function _constructor():ComQuery {
		return new ComQuery();
	}

	static function _init(el:ComQuery):ComQuery {
		return el.clear();
	}
}
