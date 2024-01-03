package heat.ecs;

class Bundle {
	public static function fromComMapTuple2<T0, T1>(id:EntityId, comMaps:heat.core.Tuple2<ComMap<T0>, ComMap<T1>>):heat.core.Tuple2<Null<T0>, Null<T1>> {
		return new heat.core.Tuple2(comMaps.e0.get(id), comMaps.e1.get(id));
	}

	public static function fromComMapTuple3<T0, T1, T2>(id:EntityId,
			comMaps:heat.core.Tuple3<ComMap<T0>, ComMap<T1>, ComMap<T2>>):heat.core.Tuple3<Null<T0>, Null<T1>, Null<T2>> {
		return new heat.core.Tuple3(comMaps.e0.get(id), comMaps.e1.get(id), comMaps.e2.get(id));
	}

	public static function fromComMapTuple4<T0, T1, T2, T3>(id:EntityId,
			comMaps:heat.core.Tuple4<ComMap<T0>, ComMap<T1>, ComMap<T2>, ComMap<T3>>):heat.core.Tuple4<Null<T0>, Null<T1>, Null<T2>, Null<T3>> {
		return new heat.core.Tuple4(comMaps.e0.get(id), comMaps.e1.get(id), comMaps.e2.get(id), comMaps.e3.get(id));
	}

	public static function fromComMapTuple5<T0, T1, T2, T3, T4>(id:EntityId,
			comMaps:heat.core.Tuple5<ComMap<T0>, ComMap<T1>, ComMap<T2>, ComMap<T3>, ComMap<T4>>):heat.core.Tuple5<Null<T0>, Null<T1>, Null<T2>, Null<T3>,
			Null<T4>> {
		return new heat.core.Tuple5(comMaps.e0.get(id), comMaps.e1.get(id), comMaps.e2.get(id), comMaps.e3.get(id), comMaps.e4.get(id));
	}
}
