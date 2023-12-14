using buddy.Should;
using heat.HeatPrelude;

class EventSuite extends buddy.BuddySuite {
    public function new() {
        describe("Signals call connected slots: ", {
            describe("given a signal", {
                var signal = new heat.event.Signal<Bool>();

                describe("and a slot that writes to an external var", {
                    var updatedFromSlot = false;
                    var slot = new heat.event.Slot<Bool>(
                        (arg)->updatedFromSlot = true);
                    
                    describe("and the slot and signal are connected", {
                        slot.connect(signal);

                        it("emitting the signal should update the slot", {
                            signal.emit(true);
                            updatedFromSlot.should.be(true);
                        });
                    });
                });
            });
        });

        describe("Slots can be disconnected from signals", {
            describe("given a signal", {
                var signal = new heat.event.Signal<Bool>();

                describe("and a slot that writes to an external var", {
                    var updatedFromSlot = false;
                    var slot = new heat.event.Slot<Bool>(
                        (arg)->updatedFromSlot = true);

                    describe("and the slot has been connected and disconnected from the signal", {
                        slot.connect(signal);
                        slot.disconnect(signal);

                        it("emitting the signal should not update the slot", {
                            signal.emit(true);
                            updatedFromSlot.should.not.be(true);
                        });
                    });
                });
            });
        });

        describe("Signal emitters emit their signals", {
            describe("given a signal emitter", {
                var signalEmitter = new heat.event.SignalEmitter<Bool>();

                describe("and a slot that writes to an external var", {
                    var updatedFromSlot = false;
                    var slot = new heat.event.Slot<Bool>(
                        (arg)->updatedFromSlot = true);

                    describe("and the slot is connected to the signal", {
                        slot.connect(signalEmitter.signal);

                        it("emitting the emitter should update the slot", {
                            signalEmitter.emit(true);
                            updatedFromSlot.should.be(true);
                        });
                    });
                });
            });
        });
    };
}