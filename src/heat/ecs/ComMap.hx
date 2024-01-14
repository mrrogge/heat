package heat.ecs;

/**
	Shorthand for a Map of components with EntityId keys.
**/
typedef ComMap<T> = Map<EntityId, T>;

// TODO: would be useful to make a subclass of IntMap that has built-in signals for when map changes. Would only work reliably for immutable components, e.g. only on set/remove.
// TODO: build these via macro to make it easy for user to expand if needed.
#if !macro
typedef ComMapTuple2<T0, T1> = heat.core.Tuple2<ComMap<T0>, ComMap<T1>>;
typedef ComMapTuple3<T0, T1, T2> = heat.core.Tuple3<ComMap<T0>, ComMap<T1>, ComMap<T2>>;
typedef ComMapTuple4<T0, T1, T2, T3> = heat.core.Tuple4<ComMap<T0>, ComMap<T1>, ComMap<T2>, ComMap<T3>>;
typedef ComMapTuple5<T0, T1, T2, T3, T4> = heat.core.Tuple5<ComMap<T0>, ComMap<T1>, ComMap<T2>, ComMap<T3>, ComMap<T4>>;
#end
