package heat.audio;

enum AudioHandle {
	File(path:haxe.io.Path);
	Other(other:Any);
	None;
}
