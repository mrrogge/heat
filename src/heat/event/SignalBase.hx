package heat.event;

/**
	Base class for signals. Not intended to be used directly; use `Signal` or `SignalEmitter` instead.
**/
class SignalBase<T> implements ISignal<T> {
	var slotMap:haxe.Constraints.IMap<ISlot<T>, Bool>;

	function new() {
		try {
			slotMap = new haxe.ds.WeakMap<ISlot<T>, Bool>();
		} catch (e:haxe.exceptions.NotImplementedException) {
			slotMap = new Map<ISlot<T>, Bool>();
		}
	}

	/**
		Connects this signal with a corresponding slot.
	**/
	public function connect(slot:ISlot<T>) {
		slotMap.set(slot, true);
	}

	/**
		Disconnects a previously-connected slot from this signal.
	**/
	public function disconnect(slot:ISlot<T>) {
		slotMap.remove(slot);
	}

	function emit(arg:T):Void {
		for (slot in slotMap.keys()) {
			slot.update(arg);
		}
	}
}
