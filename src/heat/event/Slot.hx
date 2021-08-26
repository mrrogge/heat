package heat.event;

/**
    A slot object, part of the signal/slot mechanism.

    Slots can be connected to `ISignal`s with corresponding type parameters. Anytime a connected signal is emitted, the slot will invoke its `update()` method.
**/
class Slot<T> implements ISlot<T> {
    /**
        The method that is invoked when a connected signal is emitted.
    **/
    public var update:(arg:T) -> Void;

    /**
        constructs a new slot.

        @param update the method to be invoked when a connected signal is emitted.
    **/
    public function new(update:(arg:T) -> Void) {
        this.update = update;
    }

    /**
        Connects to the passed signal instance.

        @param signal the signal to connect to.
    **/
    public inline function connect(signal:ISignal<T>) {
        signal.connect(this);
    }

    /**
        Disconnects from the passed signal if previously connected, otherwise does nothing.

        @param signal the signal to disconnect from.
    **/
    public inline function disconnect(signal:ISignal<T>) {
        signal.disconnect(this);
    }
}