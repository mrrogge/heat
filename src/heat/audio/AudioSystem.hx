package heat.audio;

import heat.ecs.EntityId;
import heat.I_UsesHeatStandardPlugin;

class AudioSystem {
	public static function cleanupFinishedAudioInstances(space:I_UsesHeatStandardPlugin) {
		for (id => instance in space.com.audioInstances) {
			if (instance.isFinished()) {
				space.com.audioInstances.remove(id);
			}
		}
	}
}
