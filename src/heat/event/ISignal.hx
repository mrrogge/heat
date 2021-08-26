package heat.event;

/**
    Interface defining a signal. Signals dynamically connected/disconnected to `ISlot`s with corresponding type parameters.
**/
interface ISignal<T> {
    public function connect(slot:ISlot<T>):Void;
    public function disconnect(slot:ISlot<T>):Void;
}