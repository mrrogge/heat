package heat.core;

import haxe.ds.Option;

class OptionTools {
	public static function all<T>(cls:Enum<Option<T>>, options:Array<Option<T>>):Option<Array<T>> {
		final someArray:Array<T> = [];
		for (option in options) {
			switch (option) {
				case Some(option):
					{
						someArray.push(option);
					}
				case None:
					{
						return None;
					}
			}
		}
		return Some(someArray);
	}

	public static function sure<T>(option:Option<T>):T {
		return switch (option) {
			case None: {
					throw new haxe.Exception('Unexpected None');
				}
			case Some(option): option;
		}
	}
}
