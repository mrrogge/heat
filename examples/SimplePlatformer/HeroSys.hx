using heat.HeatPrelude;

class HeroSys {
    static final query = new ComQuery();

    public static function update(space:SimplePlatformerSpace, dt: Float) {
        static var dirVector:MVectorFloat2;
        dirVector = dirVector ?? new MVectorFloat2();
        query.clear().with(space.game.heroMoveStates).with(space.com.transform);
        query.run();
        for (id in query.result) {
            final moveState = space.game.heroMoveStates.get(id);
            final tx = space.com.transform.get(id);
            dirVector.init(0,0);
            if (moveState.leftCmd) {
                dirVector.x -= 1;
            }
            if (moveState.rightCmd) {
                dirVector.x += 1;
            }
            if (moveState.upCmd) {
                dirVector.y -= 1;
            }
            if (moveState.downCmd) {
                dirVector.y += 1;
            }
            dirVector.normalize();                            
            final accel = moveState.topSpeed / moveState.timeToTopSpeedSec;
            final dx = dirVector.x * accel * dt;  
            final dy = dirVector.y * accel * dt;
            moveState.vel.x += dx;
            moveState.vel.y += dy;
            if (dx == 0) {
                moveState.vel.x -= Math.sign(moveState.vel.x) * moveState.topSpeed / moveState.timeToStopSec * dt;
            }
            if (dy == 0) {
                moveState.vel.y -= Math.sign(moveState.vel.y) * moveState.topSpeed / moveState.timeToStopSec * dt;
            }
            final dvx = moveState.vel.x - moveState.prevVel.x; 
            final dvy = moveState.vel.y - moveState.prevVel.y;
            tx.x += moveState.vel.x*dt + dvx/2*dt*dt;
            tx.y += moveState.vel.y*dt + dvy/2*dt*dt;
            moveState.vel.applyTo(moveState.prevVel);
        }
    }

    public static function onKeyEvent(space:SimplePlatformerSpace, keyCode:KeyCode, kind:KeyEventKind) {
        query.clear().with(space.game.heroMoveStates);
        query.run();
        for (id in query.result) {
            final moveState = space.game.heroMoveStates.get(id);
            switch (keyCode) {
                case A, LEFT: {
                    switch (kind) {
                        case PRESSED: {
                            moveState.leftCmd = true;
                        }
                        case RELEASED: {
                            moveState.leftCmd = false;
                        }
                    }
                }
                case D, RIGHT: {
                    switch (kind) {
                        case PRESSED: {
                            moveState.rightCmd = true;
                        }
                        case RELEASED: {
                            moveState.rightCmd = false;
                        }
                    }
                }
            case W, UP: {
                    switch (kind) {
                        case PRESSED: {
                          moveState.upCmd = true;
                        }
                        case RELEASED: {
                            moveState.upCmd = false;
                        }
                    }
                }
                case S, DOWN: {
                    switch (kind) {
                        case PRESSED: {
                            moveState.downCmd = true;
                        }
                        case RELEASED: {
                            moveState.downCmd = false;
                        }
                    }
                }
                default: {}
            }
        }
    }
}