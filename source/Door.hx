package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Door extends FlxSprite
{
    public var curseToLearn:Int;

    public function new(X:Float, Y:Float,curse:Int)
    {
    	super(X,Y);
        curseToLearn = curse;
        loadGraphic(Reg.DOOR);
        active = true;
    }

    override public function update():Void
    {
    	super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }

}