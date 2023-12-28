package heat.texture;

enum TextureHandle {
	Color(color:heat.core.Color);
	File(path:haxe.io.Path);
	Other(other:Any);
	None;
}
