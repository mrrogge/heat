# heat - **H**axe **E**CS **A**nd other **T**hings

`heat` is a general-purpose library focused around the ECS pattern. 

## Approach to ECS
While `heat` follows general ECS concepts, it is not what some would consider "pure ECS". Here are a few specifics regarding the "flavor" of this ECS library:
* Entities are just identifiers (i.e., there is no "Entity" class). `heat` defines `EntityIds` as _either_ `Ints` or `Strings`.
* Components are stored in maps, where each key is an `EntityId` mapping to that entity's component instance. As such, an entity can have at most one component of a given type.
* Unlike some ECS frameworks, components can be _any type_. This allows you to use external classes or structures directly without needing to define a component wrapper.
  * Because components can be any class, tbey are not required to be "pure data". This may be considered bad practice by ECS purists, but I've found in practice that having "helper" methods can make the codebase much cleaner.

* Entities can have at most one component of a given type.
* 



## Entities
In `heat`, 
