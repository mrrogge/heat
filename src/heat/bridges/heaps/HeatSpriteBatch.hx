package heat.bridges.heaps;

using heat.HeatPrelude;

class HeatSpriteBatch extends h2d.Drawable {
	final bridge:HeapsBridge;
	var tmpBuf:hxd.FloatBuffer;
	var buffer:h3d.Buffer;
	var state:h2d.impl.BatchDrawState;
	final ids:Array<EntityId> = [];
	var hasRotationScale = false;
	var isEmpty = false;

	override public function new(bridge:HeapsBridge) {
		super(bridge.scene);
		this.bridge = bridge;
		state = new h2d.impl.BatchDrawState();
	}

	public function addID(id:EntityId) {
		ids.push(id);
	}

	public function clearIDs() {
		while (ids.length > 0) {
			ids.pop();
		}
	}

	override function sync(ctx:h2d.RenderContext) {
		super.sync(ctx);
		flush();
	}

	function flush() {
		if (tmpBuf == null)
			tmpBuf = new hxd.FloatBuffer();
		var pos = 0;
		var tmp = tmpBuf;
		var bufferVertices = 0;
		state.clear();

		for (id in ids) {
			final transform = bridge.space.com.absPosTransform.get(id);
			final textureRegion = bridge.space.com.textureRegions.get(id);
			if (transform == null || textureRegion == null) {
				continue;
			}
			final texture = switch (textureRegion.handle) {
				case Color(color):
					{
						h3d.mat.Texture.fromColor(color.asIntRGB(), color.a);
					}
				case File(path):
					{
						hxd.Res.load(path.toString()).toTexture();
					}
				case Other(other): {
						if (Std.isOfType(other, hxd.res.Image)) {
							(other : hxd.res.Image).toTexture();
						} else if (Std.isOfType(other, h3d.mat.Texture)) {
							(other : h3d.mat.Texture);
						} else if (Std.isOfType(other, h2d.Graphics)) {
							// TODO: figure out if Graphics can be handled in batch rather than separate draw call
							continue;
						} else {
							throw new haxe.Exception('unexpected texture handle type');
						}
					}
				case None:
					{
						continue;
					}
			}
			state.setTexture(texture);
			state.add(4);
			tmp.grow(pos + 8 * 4);
			// TODO: rotation from transform hasn't been implemented yet but we're leaving the calcs here for future
			final angleRadians = 0;
			// TODO: also need to figure out how scaling works from transform
			final scale = 1.;
			final scaleX = scale;
			final scaleY = scale;
			var ca = Math.cos(angleRadians), sa = Math.sin(angleRadians);
			var hx = textureRegion.w, hy = textureRegion.h;
			final dx = -textureRegion.ox;
			final dy = -textureRegion.oy;
			var px = dx * scaleX, py = dy * scaleY;
			final x = transform.x;
			final y = transform.y;
			final u = textureRegion.x / texture.width;
			final u2 = (textureRegion.x + hx) / texture.width;
			final v = textureRegion.y / texture.height;
			final v2 = (textureRegion.y + hy) / texture.height;
			// TODO: individual textureRegion coloring/tinting
			final r = 1.;
			final g = 1.;
			final b = 1.;
			final a = 1.;
			if (hasRotationScale) {
				tmp[pos++] = px * ca - py * sa + x;
				tmp[pos++] = py * ca + px * sa + y;
				tmp[pos++] = u;
				tmp[pos++] = v;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				var px = (dx + hx) * scaleX, py = dy * scaleY;
				tmp[pos++] = px * ca - py * sa + x;
				tmp[pos++] = py * ca + px * sa + y;
				tmp[pos++] = u2;
				tmp[pos++] = v;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				var px = dx * scaleX, py = (dy + hy) * scaleY;
				tmp[pos++] = px * ca - py * sa + x;
				tmp[pos++] = py * ca + px * sa + y;
				tmp[pos++] = u;
				tmp[pos++] = v2;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				var px = (dx + hx) * scaleX, py = (dy + hy) * scaleY;
				tmp[pos++] = px * ca - py * sa + x;
				tmp[pos++] = py * ca + px * sa + y;
				tmp[pos++] = u2;
				tmp[pos++] = v2;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
			} else {
				var sx = x + dx;
				var sy = y + dy;
				tmp[pos++] = sx;
				tmp[pos++] = sy;
				tmp[pos++] = u;
				tmp[pos++] = v;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				tmp[pos++] = sx + hx + 0.1;
				tmp[pos++] = sy;
				tmp[pos++] = u2;
				tmp[pos++] = v;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				tmp[pos++] = sx;
				tmp[pos++] = sy + hy + 0.1;
				tmp[pos++] = u;
				tmp[pos++] = v2;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
				tmp[pos++] = sx + hx + 0.1;
				tmp[pos++] = sy + hy + 0.1;
				tmp[pos++] = u2;
				tmp[pos++] = v2;
				tmp[pos++] = r;
				tmp[pos++] = g;
				tmp[pos++] = b;
				tmp[pos++] = a;
			}
		}

		bufferVertices = pos >> 3;
		if (buffer != null && !buffer.isDisposed()) {
			if (buffer.vertices >= bufferVertices) {
				buffer.uploadFloats(tmpBuf, 0, bufferVertices);
				return;
			}
			buffer.dispose();
			buffer = null;
		}
		isEmpty = bufferVertices == 0;
		if (bufferVertices > 0)
			buffer = h3d.Buffer.ofSubFloats(tmpBuf, bufferVertices, hxd.BufferFormat.H2D, [Dynamic]);
	}

	override function draw(ctx:h2d.RenderContext) {
		drawWith(ctx, this);
	}

	@:allow(h2d)
	function drawWith(ctx:h2d.RenderContext, obj:h2d.Drawable) {
		if (buffer == null || buffer.isDisposed() || isEmpty)
			return;
		if (!ctx.beginDrawBatchState(obj))
			return;
		state.drawQuads(ctx, buffer);
	}
}
