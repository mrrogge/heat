package heat.key;

class KeyEvent {
	public final code:KeyCode;
	public final kind:KeyEventKind;
	public var consumed = false;

	public function new(code:KeyCode, kind:KeyEventKind) {
		this.code = code;
		this.kind = kind;
	}
}
