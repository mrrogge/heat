package heat.event;

/**
	Interface defining a slot. Slots are dynamically connected/disconnected to `ISignal`s with corresponding type parameters.
**/
interface ISlot<T> {
	public function connect(signal:ISignal<T>):Void;
	public function disconnect(signal:ISignal<T>):Void;
	public var update:(arg:T) -> Void;
}
