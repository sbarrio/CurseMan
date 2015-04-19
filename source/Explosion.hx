package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Explosion extends FlxSprite
{
    private var ttl:Float = 40;

    public function new(X:Float, Y:Float)
    {
    	super(X,Y);
        loadGraphic(Reg.EXPLOSION);
    }

    override public function update():Void
    {
    	super.update();
        ttl--;
        if (ttl <0){
            destroy();
        }
    }

    override public function destroy():Void
    {
        super.destroy();
    }

}