package heat.key;

class KeySys {
	static final keyCodeToStringMap:Map<KeyCode, String> = [];
	static var setupComplete = false;

	static function setupKeyCodeMap() {
		if (setupComplete) {
			return;
		}
		keyCodeToStringMap[KeyCode.A] = "a";
		keyCodeToStringMap[KeyCode.B] = "b";
		keyCodeToStringMap[KeyCode.C] = "c";
		keyCodeToStringMap[KeyCode.D] = "d";
		keyCodeToStringMap[KeyCode.E] = "e";
		keyCodeToStringMap[KeyCode.F] = "f";
		keyCodeToStringMap[KeyCode.G] = "g";
		keyCodeToStringMap[KeyCode.H] = "h";
		keyCodeToStringMap[KeyCode.I] = "i";
		keyCodeToStringMap[KeyCode.J] = "j";
		keyCodeToStringMap[KeyCode.K] = "k";
		keyCodeToStringMap[KeyCode.L] = "l";
		keyCodeToStringMap[KeyCode.M] = "m";
		keyCodeToStringMap[KeyCode.N] = "n";
		keyCodeToStringMap[KeyCode.O] = "o";
		keyCodeToStringMap[KeyCode.P] = "p";
		keyCodeToStringMap[KeyCode.Q] = "q";
		keyCodeToStringMap[KeyCode.R] = "r";
		keyCodeToStringMap[KeyCode.S] = "s";
		keyCodeToStringMap[KeyCode.T] = "t";
		keyCodeToStringMap[KeyCode.U] = "u";
		keyCodeToStringMap[KeyCode.V] = "v";
		keyCodeToStringMap[KeyCode.W] = "w";
		keyCodeToStringMap[KeyCode.X] = "x";
		keyCodeToStringMap[KeyCode.Y] = "y";
		keyCodeToStringMap[KeyCode.Z] = "z";
		keyCodeToStringMap[KeyCode.SPACE] = " ";
		keyCodeToStringMap[KeyCode.NUMBER_0] = "0";
		keyCodeToStringMap[KeyCode.NUMBER_1] = "1";
		keyCodeToStringMap[KeyCode.NUMBER_2] = "2";
		keyCodeToStringMap[KeyCode.NUMBER_3] = "3";
		keyCodeToStringMap[KeyCode.NUMBER_4] = "4";
		keyCodeToStringMap[KeyCode.NUMBER_5] = "5";
		keyCodeToStringMap[KeyCode.NUMBER_6] = "6";
		keyCodeToStringMap[KeyCode.NUMBER_7] = "7";
		keyCodeToStringMap[KeyCode.NUMBER_8] = "8";
		keyCodeToStringMap[KeyCode.NUMBER_9] = "9";

		setupComplete = true;
	}

	public static function keyCodeToString(keyCode:KeyCode):haxe.ds.Option<String> {
		setupKeyCodeMap();
		final result = keyCodeToStringMap.get(keyCode);
		if (result == null) {
			return None;
		}
		return Some(result);
	}
}
