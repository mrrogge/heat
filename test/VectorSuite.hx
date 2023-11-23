package test;

using buddy.Should;

using heat.HeatPrelude;

class VectorSuite extends buddy.BuddySuite {
    public function new() {
        describe("For vectors: ", {
            it("toMutable() copies values", {
                var immutable = new Vector2<Float>(1, 2);
                var mutable = immutable.toMutable();
                mutable.x.should.be(1);
                mutable.y.should.be(2);
            }); 
            it("fromMutable() copies values", {
                var mutable = new MVector2<Float>(1, 2);
                var immutable = Vector2.fromMutable(mutable);
                immutable.x.should.be(1);
                immutable.y.should.be(2);
            });
            it("toImmutable() copies values", {
                var mutable = new MVector2<Float>(1, 2);
                var immutable = mutable.toImmutable();
                immutable.x.should.be(1);
                immutable.y.should.be(2);
            }); 
            it("fromImmutable() copies values", {
                var immutable = new Vector2<Float>(1, 2);
                var mutable = MVector2.fromImmutable(immutable);
                mutable.x.should.be(1);
                mutable.y.should.be(2);
            });
            it("clone() copies values", {
                var immutable = new Vector2<Float>(1, 2);
                immutable.clone().x.should.be(1);
                immutable.clone().y.should.be(2);
                var mutable = new MVector2<Float>(1, 2);
                mutable.clone().x.should.be(1);
                mutable.clone().y.should.be(2);
            });
        });
        describe("For float vectors: ", {
            it("Adding mutable plus immutable returns mutable (following LHS)", {
                var mutable = new MVectorFloat2();
                var immutable = new VectorFloat2();
                (mutable + immutable).should.beType(MVector2);
            });
            it("Adding immutable plus mutable returns immutable (following LHS)", {
                var immutable = new VectorFloat2();
                var mutable = new MVectorFloat2();
                (immutable + mutable).should.beType(Vector2);
            });
            it("Subtracting immutable from mutable returns mutable (following LHS)", {
                var mutable = new MVectorFloat2();
                var immutable = new VectorFloat2();
                (mutable - immutable).should.beType(MVector2);
            });
            it("Subtracting mutable from immutable returns immutable (following LHS)", {
                var immutable = new VectorFloat2();
                var mutable = new MVectorFloat2();
                (immutable - mutable).should.beType(Vector2);
            });
        });
    }
}