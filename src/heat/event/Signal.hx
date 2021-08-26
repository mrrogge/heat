package heat.event;

/**
    A signal object, part of the signal/slot mechanism. 
    
    Signals can be connected to `ISlot`s with corresponding type parameters. This class has a public `emit()` method for updating its slots. If instead, you wish to expose a signal while hiding its `emit()` method, consider using `SignalEmitter`.
**/
class Signal<T> extends SignalBase<T> implements ISignal<T> {
    override public function new() {
        super();
    }
    
    /**
        Emits this signal, calling `update()` on each of its connected slots.
    **/
    override public function emit(arg:T):Void {
        super.emit(arg);
    }
}