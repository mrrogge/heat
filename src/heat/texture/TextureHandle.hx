package heat.texture;

enum TextureHandle<T> {
    Color(color:heat.core.Color);
    File(path:haxe.io.Path);
    Other(other:T);
}