package heat.core;

using heat.HeatPrelude;

interface IUsesSTD {
    public final com: {
        parents: ComMap<EntityId>,
        childrenLists: ComMap<Array<EntityId>>,
        transform: ComMap<MTransform>,
        absPosTransform: ComMap<MTransform>,
        camera: ComMap<Camera>,
        drawOrder: ComMap<Int>,
    }
}