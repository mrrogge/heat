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

	public var fontHandle(default, set):heat.text.FontHandle;

	function set_fontHandle(fontHandle:heat.text.FontHandle):heat.text.FontHandle {
		switch fontHandle {
			case File(path):
				{
					// TODO
					heapsText.font = hxd.res.DefaultFont.get();
				}
			case Other(other):
				{
					if (Std.isOfType(other, h2d.Font)) {
						final font = (other : h2d.Font);
						heapsText.font = font;
					}
				}
			case None:
				{
					heapsText.font = hxd.res.DefaultFont.get();
				}
		}
		return fontHandle;
	}

	public function new(heapsText:h2d.Text) {
		this.heapsText = heapsText;
	}
}
