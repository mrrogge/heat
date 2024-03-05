package heat.bridges.heaps;

class HeapsTextGraphic implements heat.text.ITextGraphic {
	public final heapsText:h2d.Text;

	public var text(get, set):String;

	function get_text():String {
		return heapsText.text;
	}

	function set_text(text:String):String {
		heapsText.text = text;
		return this.text;
	}

	public function new(heapsText:h2d.Text) {
		this.heapsText = heapsText;
	}
}
