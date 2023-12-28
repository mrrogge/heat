package heat.core;

class OrderedMap<K, V> {
	final map:Map<K, Int> = [];
	final list:Array<V> = [];

	public function new() {}

	public function get(k:K):Null<V> {
		return map[k] == null ? null : list[map[k]];
	}

	public function set(k:K, v:V):Void {
		// TODO
	}

	function exists(k:K):Bool {
		// TODO
		return false;
	};

	function remove(k:K):Bool {
		// TODO
		return false;
	}

	function keys():Iterator<K> {
		// TODO
		return null;
	}

	function iterator():Iterator<V> {
		// TODO
		return null;
	}

	function keyValueIterator():KeyValueIterator<K, V> {
		// TODO
		return null;
	}

	function copy():haxe.Constraints.IMap<K, V> {
		// TODO
		return null;
	}

	function toString():String {
		// TODO
		return "";
	}

	function clear():Void {
		// TODO
	}
}
