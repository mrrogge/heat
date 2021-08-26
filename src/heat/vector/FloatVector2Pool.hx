package heat.vector;

class FloatVector2Pool extends Pool<heat.vector.FloatVector2, heat.vector.FloatVector2Data> {
    static function constructor(?data:{}):heat.vector.FloatVector2 {
        return new heat.vector.FloatVector2();
    }

    public function new() {
        super(constructor, heat.vector.FloatVector2.init);
    }

    
}