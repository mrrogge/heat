using heat.HeatPrelude;

@:build(heat.ecs.EcsMacros.addComMaps([ball is Ball, cliPos is heat.core.MVectorInt2,]))
@:build(heat.plugin.std.StandardPlugin.apply())
class CliPongSpace extends heat.space.HeatSpace implements heat.I_UsesHeatStandardPlugin {
	final ballQuery = new ComQuery();
	final screen = new CliScreen();

	public function new() {
		super();
		screen.init();
		final ballId = getNextID();
		cliPos.set(ballId, new MVectorInt2(1, 0));
		ball.set(ballId, new Ball());

		ballQuery.with(ball).with(cliPos);

		screen.moveCursor(0, 0);
		screen.writeString("]");
		screen.moveCursor(40, 0);
		screen.writeString("[");
	}

	override function update(dt:Float) {
		super.update(dt);
		updateBall();
		screen.render();
	}

	function updateBall() {
		ballQuery.run();
		for (id in ballQuery.result) {
			final pos = cliPos.get(id);
			final state = ball.get(id);
			screen.moveCursor(pos.x, pos.y);
			screen.eraseCharsAtCursor(1);
			if (state.dir < 0) {
				pos.x--;
				if (pos.x < 1) {
					state.dir = 1;
					pos.x = 1;
				}
			} else if (state.dir > 0) {
				pos.x++;
				if (pos.x > 39) {
					state.dir = -1;
					pos.x = 39;
				}
			}
			screen.moveCursor(pos.x, pos.y);
			screen.writeString("o");
			screen.moveCursor(0, 0);
		}
	}
}

class Ball {
	public var dir:Int = 1;

	public function new() {}
}

class CliScreen {
	final stdout = Sys.stdout();
	var buffer = "";

	public function new() {
		init();
	}

	public function init() {
		buffer += "\x1b[?1049h";
		clearScreen();
		moveCursor(0, 0);
		hideCursor();
	}

	public function render() {
		stdout.writeString(buffer);
		buffer = "";
	}

	public function clearScreen() {
		buffer += "\x1b[2J";
	}

	public function moveCursor(x:Int, y:Int) {
		buffer += '\x1b[${y};${x}H';
	}

	public function eraseCharsAtCursor(n:Int) {
		buffer += '\x1b[${n}X';
	}

	public function hideCursor() {
		buffer += '\x1b0m\x1b[?25l';
	}

	public function writeString(s:String) {
		buffer += s;
	}
}
