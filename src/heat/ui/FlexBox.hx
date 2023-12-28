package heat.ui;

class FlexBox {
	public var dir:FlexDirection = ROW;
	public var gap = 0.;

	public function new() {}
}

enum FlexDirection {
	ROW;
	ROW_REVERSE;
	COL;
	COL_REVERSE;
}
