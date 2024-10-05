package heat.key;

interface IKeyInputBridge {
	public final keyPressedSignal:heat.event.ISignal<KeyEvent>;
	public final keyReleasedSignal:heat.event.ISignal<KeyEvent>;
}
