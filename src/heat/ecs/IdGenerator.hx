package heat.ecs;

import haxe.ds.Either;

/**
    A helper class for generating `EntityId`s.

    This will yield new Ids without repeats, which can be useful if you need a unique Id for an entity but don't care about the actual value. This is done by keeping track of the largest known Id value and incrementing by 1 each time a new Id is requested. Note that this doesn't do any backfilling - e.g. if `EntityId`s 1, 2, and 100 have been added, the next yielded ID will be 101, even though 3-99 are still available.

    Currently, only `Int` values are generated, but this class could be extended if more types are desired (e.g. `String` UUIDs).

    This class includes a `heatSlot` intended for an "`EntityId` added" signal - this helps keep the `IdGenerator` in sync when `EntityId`s are actually added to `ComMap`s.
**/
class IdGenerator {
    var nextInt = 1;

    /**
        A slot for "`EntityId` added" signals.
    **/
    public var idAddedSlot(default, null):heat.event.Slot<EntityId>;

    public function new() {
        idAddedSlot = new heat.event.Slot<EntityId>((?arg) -> {
            switch arg {
                case Right(int) if (int >= nextInt): {
                    this.nextInt = int+1;
                }
                default:
            }
        });
    }

    public function yieldInt():EntityId {
        return nextInt++;
    }

    public function reset() {
        nextInt = 1;
    }

}