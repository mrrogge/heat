package heat.bridges.dummy;

class DummyTextGraphic implements heat.text.ITextGraphic {
	public var text(get, set):String;

	var _text:String = "";

	public function set_text(value:String):String {
		_text = value;
		return _text;
	}

	public function get_text():String {
		return _text;
	}

	public var fontHandle(default, set):heat.text.FontHandle;

	public function set_fontHandle(value:heat.text.FontHandle):heat.text.FontHandle {
		fontHandle = value;
		return fontHandle;
	}

	public function new() {}
}
