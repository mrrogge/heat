package heat.text;

enum FontHandle {
	File(path:haxe.io.Path);
	Other(other:Any);
	None;
}
