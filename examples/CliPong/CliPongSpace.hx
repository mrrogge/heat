using heat.HeatPrelude;

@:build(heat.ecs.EcsMacros.addComMaps([ball is Ball, cliPos is heat.core.MVectorInt2,]))
@:build(heat.plugin.std.StandardPlugin.apply())
class CliPongSpace extends heat.space.HeatSpace implements heat.I_UsesHeatStandardPlugin {
	final stdout:haxe.io.Output;
	final ballQuery = new ComQuery();

	public function new() {
		super();
		stdout = Sys.stdout();
		initScreen();
		final ballId = getNextID();
		cliPos.set(ballId, new MVectorInt2(1, 0));
		ball.set(ballId, new Ball());

		ballQuery.with(ball).with(cliPos);

		moveCursor(0, 0);
		stdout.writeString("]");
		moveCursor(40, 0);
		stdout.writeString("[");
	}

	public function initScreen() {
		clearScreen();
		moveCursor(0, 0);
		hideCursor();
	}

	public function clearScreen() {
		stdout.writeByte(0x1B);
		stdout.writeString("[2J");
	}

	public function moveCursor(x:Int, y:Int) {
		stdout.writeByte(0x1B);
		stdout.writeString('[${y};${x}H');
	}

	public function render() {
		ballQuery.run();
		for (id in ballQuery.result) {
			final pos = cliPos.get(id);
			moveCursor(pos.x, pos.y);
			stdout.writeString("o");
		}
	}

	override function update(dt:Float) {
		super.update(dt);
		try {
			updateBall();
		} catch (e:haxe.io.Eof) {}
	}

	function eraseChars(n:Int) {
		stdout.writeByte(0x1B);
		stdout.writeString('[${n}X');
	}

	function updateBall() {
		ballQuery.run();
		for (id in ballQuery.result) {
			final pos = cliPos.get(id);
			final state = ball.get(id);
			moveCursor(pos.x, pos.y);
			eraseChars(1);
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
			moveCursor(pos.x, pos.y);
			stdout.writeString("o");
			moveCursor(0, 0);
		}
	}

	function hideCursor() {
		stdout.writeByte(0x1B);
		stdout.writeString("[?25l");
	}
}

class Ball {
	public var dir:Int = 1;

	public function new() {}
}
