using buddy.Should;
using Lambda;

class Main extends buddy.SingleSuite {
    public function new() {
        describe("Pool items get reused: ", {
            describe("given a non-empty pool", {
                var pool = new heat.Pool((?data:{}) -> return {});
                var existingObject = {};
                pool.put(existingObject);

                it("the pool should provide an existing object", {
                    pool.get().should.be(existingObject);
                });
            });
        });

        describe("Pools can initialize their items: ", {
            describe("given a pool with an initializer", {
                var constructor = (?i:Int) -> return {value:0};
                var init = (instance:{value:Int}, ?i:Int) -> {
                    instance.value = switch i {
                        case null: 0;
                        default: i;
                    };
                }
                var pool = new heat.Pool(constructor, init);

                it("an object should be initialized when passing through the pool", {
                    var object = {value:2};
                    pool.put(object);
                    var initValue = 3;
                    object = pool.get(initValue);
                    object.value.should.be(initValue);
                });
            });
        });

        describe("Pools can be flushed: ", {
            describe("given a non-empty pool", {
                var pool = new heat.Pool((?data:{}) -> return {});
                var existingObject = {};
                pool.put(existingObject);

                it("flushing the pool should remove the existing object", {
                    pool.flush();
                    pool.get().should.not.be(existingObject);
                });
            });
        });

        describe("IdGenerators yield unique integers: ", {
            describe("given an IdGenerator", {
                var idGenerator = new heat.ecs.IdGenerator();

                it("each yieldInt() call should return an integer equal to the previous call plus 1.", {
                    var id1:Int = idGenerator.yieldInt();
                    var id2:Int = idGenerator.yieldInt();
                    id2.should.be(id1+1);
                });
            });
        });

        describe("ComQueries find all EntityIds with all components: ", {
            describe("given two ComMaps", {
                var map0 = new heat.ecs.ComMap<{}>();
                var map1 = new heat.ecs.ComMap<{}>();

                describe("and two entities with both components", {
                    var id0 = 0;
                    var id1 = 1;
                    map0[id0] = {};
                    map0[id1] = {};
                    map1[id0] = {};
                    map1[id1] = {};

                    it("a ComQuery result includes both entities.", {
                        var comQuery = new heat.ecs.ComQuery2(map0, map1);
                        comQuery.run();
                        //for some reason contain() and containAll() are not working with abstracts over enums, e.g:
                        //comQuery.result.should.containAll([id0, id1]);
                        //for now we just check item existence explicitly:
                        comQuery.result.exists(function(item) return item == id0).should.be(true);
                        comQuery.result.exists(function(item) return item == id1).should.be(true);
                    });
                });
            });
        });
            
        describe("ComQueries do not include EntityIds with missing components", {
            describe("given two ComMaps", {
                var map0 = new heat.ecs.ComMap<{}>();
                var map1 = new heat.ecs.ComMap<{}>();

                describe("and an entity with only one of the components", {
                    var id = 0;
                    map0[id] = {};

                    it("a ComQuery result should be empty", {
                        var comQuery = new heat.ecs.ComQuery2(map0, map1);
                        comQuery.run();
                        comQuery.result.exists(function(item) return item == id).should.be(false);
                    });
                });
            });
        });

        describe("ComQueries provide tuples of an entity's components: ", {
            describe("given an entity with two components", {
                var com0 = {value:0};
                var com1 = {value:1};
                var map0 = new heat.ecs.ComMap();
                var map1 = new heat.ecs.ComMap();
                var id = 0;
                map0[id] = com0;
                map1[id] = com1;
                
                it("a ComQuery should return a tuple containing both components", {
                    var comQuery = new heat.ecs.ComQuery2(map0, map1);
                    var comTuple = comQuery.getComTuple(id);
                    comTuple.e0.should.be(com0);
                    comTuple.e1.should.be(com1);
                });
            });

            describe("given an entity with only one of two components", {
                var com0 = {value:0};
                var map0 = new heat.ecs.ComMap();
                var map1 = new heat.ecs.ComMap<{}>();
                var id = 0;
                map0[id] = com0;
                
                it("a ComQuery should return a tuple containing the entity's component and a null", {
                    var comQuery = new heat.ecs.ComQuery2(map0, map1);
                    var comTuple = comQuery.getComTuple(id);
                    comTuple.e0.should.be(com0);
                    comTuple.e1.should.be(null);
                });
            });
        });

        describe("ComQueries reuse passed tuples when calling getComTuple(): ", {
            describe("given an entity with a component in a ComMap", {
                var map = new heat.ecs.ComMap();
                var id = 0;
                var com = {};
                map[id] = com;

                describe("and a ComQuery over that ComMap", {
                    var comQuery = new heat.ecs.ComQuery1(map);

                    it("the same tuple passed to getComTuple() should be returned", {
                        var comTuple = new heat.Tuple1<{}>();
                        comQuery.getComTuple(id, comTuple).should.be(comTuple);
                    });

                    it("an empty tuple passed to getComTuple() should have the component added", {
                        var comTuple = new heat.Tuple1<{}>();
                        comQuery.getComTuple(id, comTuple).e0.should.be(com);
                    });
                });
            });
        });

        describe("ComStores reuse components: ", {
            describe("given an empty ComStore", {
                var comStore = new heat.ecs.ComStore((?data:{}) -> return {});

                describe("and a component for an entity has been added and removed", {
                    var id = 1;
                    var com = comStore.add(id);
                    comStore.remove(id);

                    it("adding a component for a new entity should reuse the previous component", {
                        var otherId = 2;
                        var otherCom = comStore.add(otherId);
                        otherCom.should.be(com);
                    });
                });
            });
        });

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

        describe("some temporary vector tests", {
            var v1 = new heat.vector.FloatVector2();
            var v2 = new heat.vector.FloatVector2();
            // v1.x = 1;
            // v1.y = 2;
            // v2.x = 3;
            // v2.y = 4;
            // trace(v1+v2);
            // trace(v1-v2);
            // trace(v1*v2);
            // trace(v1*100);
            // v1.add(v2);
            // v1.sub(v2);
            // trace(v1);
            // trace(v1.dot(v2));
            // trace(v1.length);
        });
    };
}