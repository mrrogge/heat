package heat.key;

interface IKeyInputBridge {
	public final keyPressedSignal:heat.event.ISignal<KeyCode>;
	public final keyReleasedSignal:heat.event.ISignal<KeyCode>;
}
