using heat.HeatPrelude;

class HeroMoveState {
    public var leftCmd = false;
    public var rightCmd = false;
    public var upCmd = false;
    public var downCmd = false;
    public var dragMult = 0.1;
    public final vel = new MVectorFloat2();
    public final prevVel = new MVectorFloat2();
    public var topSpeed = 100.; 
    public var timeToTopSpeedSec = 0.5;
    public var timeToStopSec = 0.2;

    public function new() {}


}