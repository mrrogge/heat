package heat.texture;

class TextureRegion<T> {
    public var handle:TextureHandle<T>;

    public var x:Float;
    public var y:Float;
    public var w:Float;
    public var h:Float;

    public function new(handle: TextureHandle<T>, x=0., y=0., w=1., h=1.) {
        this.handle = handle;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    /**
        Create a sub-region of this Tile with specified size and offset.
        @param x The offset on top of the current Tile offset along the X axis.
        @param y The offset on top of the current Tile offset along the Y axis.
        @param w The width of the new Tile region. Can exceed current tile size.
        @param h The height of the new Tile region. Can exceed the current tile size.
        @param dx An optional visual offset of the new Tile along the X axis.
        @param dy An optional visual offset of the new Tile along the Y axis.
    **/
    public function sub( x : Float, y : Float, w : Float, h : Float) : TextureRegion<T> {
        return new TextureRegion(handle, this.x + x, this.y + y, w, h);
    }

    /**
        Create a copy of this Tile instance.
    **/
    public function clone() : TextureRegion<T> {
        final newHandle = switch (handle) {
            case Color(color): TextureHandle.Color(color.clone());
            // TODO: no built-in Path cloning? boo. do this later
            case File(path): throw new haxe.exceptions.NotImplementedException();
            case Other(other): throw new haxe.exceptions.NotImplementedException();
        }
        return new TextureRegion(newHandle, x, y, w, h);
    }

    /**
        Create a solid color Tile with specified width, height, color and alpha.
        @param color The RGB color of the Tile.
        @param width The width of the Tile in pixels.
        @param height The height of the Tile in pixels.
        @param alpha The transparency of the Tile.
    **/
    public static function fromColor( color : heat.core.Color, w = 1., h = 1.) : TextureRegion<Any> {
        return new TextureRegion(TextureHandle.Color(color), 0, 0, w, h);
    }    
}