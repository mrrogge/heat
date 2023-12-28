package heat.event;

/**
	A wrapper for providing protected signals.

	Typically, a `SignalEmitter` instance will be hidden from external access, while its `signal` will be exposed publicly. Unlike regular `Signal`s, this signal's `emit()` method is protected from external code and can only be invoked by the `SignalEmitter` instance.
**/
@:access(heatProtectedSignal)
class SignalEmitter<T> {
	/**
		The protected signal instance.
	**/
	public var signal(default, null):ProtectedSignal<T>;

	public function new() {
		signal = new ProtectedSignal<T>();
	}

	/**
		Invokes the protected `emit()` method on the signal instance.
	**/
	public function emit(arg:T) {
		signal.emit(arg);
	}
}

@:allow(heat.event.SignalEmitter)
private class ProtectedSignal<T> extends SignalBase<T> {
	override function new() {
		super();
	}

	override function emit(arg:T) {
		super.emit(arg);
	}
}
