package heat.core;

class Dimension {
	public var w(get, set):Float;

	function get_w():Float {
		return v.x;
	}

	function set_w(w:Float):Float {
		v.x = w;
		return v.x;
	}

	public var h(get, set):Float;

	function get_h():Float {
		return v.y;
	}

	function set_h(h:Float):Float {
		v.y = h;
		return v.y;
	}

	public final v:MVectorFloat2;

	public function new(w = 1., h = 1.) {
		v = new MVectorFloat2(w, h);
	}
}
