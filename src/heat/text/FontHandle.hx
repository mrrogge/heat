package heat.text;

enum FontHandle {
	File(path:haxe.io.Path);
	Default;
	Other(other:Any);
	None;
}
