package heat.audio;

using heat.HeatPrelude;

class AudioSystem {
	public static function play(space:heat.std.HeatSpaceStd, id:EntityId) {
		final query = space.comQueryPool.get().with(space.com.audioSources);
		if (!query.checkId(id)) {
			return;
		}
		final source = space.com.audioSources.get(id);
		final instanceId = space.getNextID();
		space.com.audioInstances.set(instanceId, new AudioInstance(switch (source.handle) {
			case File(path): {
					File(new haxe.io.Path(path.toString()));
				}
			case Other(other): {
					Other(other);
				}
			case None: {
					None;
				}
		}));
	}
}
