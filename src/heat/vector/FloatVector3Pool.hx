package heat.vector;

class FloatVector3Pool extends Pool<heat.vector.FloatVector3, {}> {
    static function constructor(?data:{}):heat.vector.FloatVector3 {
        return new heat.vector.FloatVector3();
    }

    static function init(instance:heat.vector.FloatVector3, ?data:{}):Void {
        instance.x = 0;
        instance.y = 0;
    }

    public function new() {
        super(constructor, init);
    }
}