package heat.ecs;

/**
	Shorthand for a Map of components with EntityId keys.
**/
typedef ComMap<T> = Map<EntityId, T>;

// TODO: would be useful to make a subclass of IntMap that has built-in signals for when map changes. Would only work reliably for immutable components, e.g. only on set/remove.
