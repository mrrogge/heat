package heat.ecs;

enum BundleTemplate<T> {
	DEFAULT;
	CUSTOM(template:T);
}
