package heat.core;

@:forward(clear)
@:transitive
@:multiType(@:followWithAbstracts K1)
abstract Map2D<K1, K2, V>(Map<K1, Map<K2, V>>) from Map<K1, Map<K2, V>> to Map<K1, Map<K2, V>> {
	public function new();

	public inline function get(k1:K1, k2:K2):Null<V> {
		final v1 = this.get(k1);
		if (v1 == null) {
			return null;
		}
		return v1.get(k2);
	}

	public inline function set(k1:K1, k2:K2, v:V) {
		var v1 = this.get(k1);
		if (v1 == null) {
			v1 = new Map();
			this.set(k1, v1);
		}
		v1.set(k2, v);
	}

	public inline function exists(k1:K1, k2:K2):Bool {
		return this.exists(k1) && this.get(k1).exists(k2);
	}

	public inline function remove(k1:K1, k2:K2):Bool {
		final v1 = this.get(k1);
		if (v1 == null) {
			return false;
		}
		return v1.remove(k2);
	}

	public inline function keysFirstOrder():Iterator<K1> {
		return this.keys();
	}

	public inline function keysSecondOrder():Iterator<K2> {
		return new Map2DKeySecondOrderIterator(this);
	}

	public inline function keyValueIterator():KeyValueIterator<Tuple2<K1, K2>, V> {
		return new Map2DKeyValueIterator(this);
	}

	public inline function iterator():Iterator<V> {
		return new Map2DIterator(this);
	}

	// function copy():IMap<K, V>;
	// function toString():String;

	@:to static inline function toIntMap<K1:Int, K2, V>(t:Map2D<K1, K2, V>):haxe.ds.IntMap<Map<K2, V>> {
		return new haxe.ds.IntMap<Map<K2, V>>();
	}

	@:to static inline function toStringMap<K1:String, K2, V>(t:Map2D<K1, K2, V>):haxe.ds.StringMap<Map<K2, V>> {
		return new haxe.ds.StringMap<Map<K2, V>>();
	}

	@:to static inline function toEnumValueMapMap<K1:EnumValue, K2, V>(t:Map2D<K1, K2, V>):haxe.ds.EnumValueMap<K1, Map<K2, V>> {
		return new haxe.ds.EnumValueMap<K1, Map<K2, V>>();
	}

	@:to static inline function toObjectMap<K1:{}, K2, V>(t:Map2D<K1, K2, V>):haxe.ds.ObjectMap<K1, Map<K2, V>> {
		return new haxe.ds.ObjectMap<K1, Map<K2, V>>();
	}

	// @:from static inline function fromStringMap<V>(map:StringMap<V>):Map<String, V> {
	// 	return cast map;
	// }

	// @:from static inline function fromIntMap<V>(map:IntMap<V>):Map<Int, V> {
	// 	return cast map;
	// }

	// @:from static inline function fromObjectMap<K:{}, V>(map:ObjectMap<K, V>):Map<K, V> {
	// 	return cast map;
	// }
}

class Map2DKeyValueIterator<K1, K2, V> {
	final iter1:KeyValueIterator<K1, Map<K2, V>>;
	var key1:Null<K1>;
	var iter2:Null<KeyValueIterator<K2, V>>;

	public function new(map:Map<K1, Map<K2, V>>) {
		iter1 = map.keyValueIterator();
	}

	public function hasNext():Bool {
		if (key1 == null) {
			if (!iter1.hasNext()) {
				// whole map is empty
				return false;
			}
			// advance to next iter2
			final pair1 = iter1.next();
			key1 = pair1.key;
			iter2 = pair1.value.keyValueIterator();
		}
		// loop until we find an iter2 with at least one key, or until iter1 is done
		while (!iter2.hasNext()) {
			if (!iter1.hasNext()) {
				// last iter2 has no items
				return false;
			}
			final pair1 = iter1.next();

			key1 = pair1.key;
			iter2 = pair1.value.keyValueIterator();
		}
		return true;
	}

	public function next():{key:Tuple2<K1, K2>, value:V} {
		if (!hasNext()) {
			return null;
		}
		final iter2Item = iter2.next();
		return {key: new heat.HeatPrelude.Tuple2(key1, iter2Item.key), value: iter2Item.value};
	}
}

class Map2DKeySecondOrderIterator<K1, K2, V> {
	final iter1:Iterator<Map<K2, V>>;
	var iter2:Null<Iterator<K2>>;

	public function new(map:Map<K1, Map<K2, V>>) {
		iter1 = map.iterator();
	}

	public function hasNext():Bool {
		if (iter2 == null) {
			if (!iter1.hasNext()) {
				// whole map is empty
				return false;
			}
			// advance to next iter2
			iter2 = iter1.next().keys();
		}
		// loop until we find an iter2 with at least one key, or until iter1 is done
		while (!iter2.hasNext()) {
			if (!iter1.hasNext()) {
				// last iter2 has no items
				return false;
			}
			iter2 = iter1.next().keys();
		}
		return true;
	}

	public function next():K2 {
		if (!hasNext()) {
			return null;
		}
		return iter2.next();
	}
}

class Map2DIterator<K1, K2, V> {
	final iter1:Iterator<Map<K2, V>>;
	var iter2:Null<Iterator<V>>;

	public function new(map:Map<K1, Map<K2, V>>) {
		iter1 = map.iterator();
	}

	public function hasNext():Bool {
		if (iter2 == null) {
			if (!iter1.hasNext()) {
				// whole map is empty
				return false;
			}
			// advance to next iter2
			iter2 = iter1.next().iterator();
		}
		// loop until we find an iter2 with at least one key, or until iter1 is done
		while (!iter2.hasNext()) {
			if (!iter1.hasNext()) {
				// last iter2 has no items
				return false;
			}
			iter2 = iter1.next().iterator();
		}
		return true;
	}

	public function next():V {
		if (!hasNext()) {
			return null;
		}
		return iter2.next();
	}
}
