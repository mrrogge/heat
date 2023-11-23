package heat.ecs;

class ComQuery {
    public final result = new Array<EntityId>();

    final condArray = new Array<Condition>();

    public function new() {

    }

    public function with(comMap:Map<EntityId, Any>):ComQuery {
        condArray.push(new WithCondition(comMap));
        return this;
    }

    public function without(comMap:Map<EntityId, Any>):ComQuery {
        condArray.push(new WithoutCondition(comMap));
        return this;
    }

    @:generic
    public function whereEqualTo<T>(comMap:Map<EntityId, T>, value:T):ComQuery {
        condArray.push(new WhereEqualToCondition<T>(comMap, value));
        return this;
    }

    @:generic
    public function whereNotEqualTo<T>(comMap:Map<EntityId, T>, value:T):ComQuery {
        condArray.push(new WhereNotEqualToCondition<T>(comMap, value));
        return this;
    }

    public function run():ComQuery {
        while (result.length > 0) result.pop();
        if (condArray.length <= 0) return this;

        var firstMap:Null<ComMap<Any>> = null;
        for (cond in condArray) {
            var whereEqualToCond:WhereEqualToCondition<Any> = Std.downcast(cond, WhereEqualToCondition);
            if (whereEqualToCond != null) {
                firstMap = whereEqualToCond.comMap;
                break;
            }
            var withCond = Std.downcast(cond, WithCondition);
            if (withCond != null) {
                firstMap = withCond.comMap;
                break;
            }
        }
        if (firstMap == null) return this;
        
        for (id => _ in firstMap) {
            var satisfiesAllConds = true;
            for (cond in condArray) {
                satisfiesAllConds = satisfiesAllConds && cond.check(id);
                if (!satisfiesAllConds) break;
            }
            if (!satisfiesAllConds) continue;
            result.push(id);
        }

        return this;
    }

    public inline function iter():Iterator<EntityId> {
        run();
        return result.iterator();
    }

    public function checkId(id:EntityId):Bool {
        for (cond in condArray) {
            if (!cond.check(id)) return false;
        }
        return true;
    }
}

private abstract class Condition {
    public abstract function check(id:EntityId):Bool;
}

private class WithCondition extends Condition {
    public var comMap:Map<EntityId, Any>;
    
    public function new(comMap:Map<EntityId, Any>) {
        this.comMap = comMap;
    }

    public function check(id:EntityId):Bool {
        return comMap.exists(id);
    }
}

private class WithoutCondition extends Condition {
    public var comMap:Map<EntityId, Any>;
    
    public function new(comMap:Map<EntityId, Any>) {
        this.comMap = comMap;
    }

    public function check(id:EntityId):Bool {
        return !comMap.exists(id);
    }
}

private class WhereEqualToCondition<T> extends Condition {
    public var comMap:Map<EntityId, T>;
    public var value:T;

    public function new(comMap:Map<EntityId, T>, value:T) {
        this.comMap = comMap;
        this.value = value;
    }

    public function check(id:EntityId):Bool {
        return comMap.exists(id) && comMap[id] == value;
    }
}

private class WhereNotEqualToCondition<T> extends Condition {
    public final comMap:Map<EntityId, T>;
    public final value:T;

    public function new(comMap:Map<EntityId, T>, value:T) {
        this.comMap = comMap;
        this.value = value;
    }

    public function check(id:EntityId):Bool {
        return !comMap.exists(id) || comMap[id] != value;
    }
}