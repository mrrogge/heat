package heat.std;

import heat.core.HeatSpace;
import heat.transform.TransformSys;

@:build(heat.std.StandardPlugin.apply())
class HeatSpaceStd extends HeatSpace implements I_UsesHeatStandardPlugin {
	public function new() {
		super();
	}

	override function update(dt:Float) {
		super.update(dt);
		TransformSys.syncAbsPos(this);
	}
}
