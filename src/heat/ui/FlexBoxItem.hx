package heat.ui;

class FlexBoxItem {
	public var flex(default, set) = 1;

	function set_flex(x:Null<Int>):Null<Int> {
		this.flex = x;
		if (this.flex < 0) {
			this.flex = 0;
		}
		return this.flex;
	}

	public function new(flex = 0) {
		this.flex = flex;
	}
}
