package heat.core;

/**
	A generic object pool.
**/
class Pool<T> {
	var stack = new haxe.ds.GenericStack<T>();
	var constructor:() -> T;
	var init:(el:T) -> T;

	function defaultInit(el:T):T {
		return el;
	}

	/**
		Constructs a new `Pool` instance.
	**/
	public function new(constructor:() -> T, ?init:(el:T) -> T) {
		this.constructor = constructor;
		this.init = init == null ? defaultInit : init;
	}

	public function setInit(init:(el:T) -> T):Pool<T> {
		this.init = init;
		return this;
	}

	/**
		Retrieves a `T` from the pool.

		If the pool is empty, a new `T` will be returned using the constructor function. Otherwise, an existing `T` is removed from the pool, initialized, then returned.
	**/
	public function get():T {
		if (stack.isEmpty()) {
			return constructor();
		} else {
			return init(stack.pop());
		}
	}

	/**
		Adds an element to the pool. Once an element is returned, it must no longer be referenced in code, otherwise conflicts may occur.

		@param element The element to add.
	**/
	public inline function put(element:T):Pool<T> {
		stack.add(element);
		return this;
	}

	/**
		Removes all instances from the pool.
	**/
	public function flush() {
		while (!stack.isEmpty()) {
			stack.pop();
		}
	}
}
