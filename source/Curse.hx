package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Curse extends FlxSprite
{
    private var speed:Float;
    public var damage: Float;
    public var level:Int;

    private var SPEED_LV1:Float = 3;
    private var SPEED_LV2:Float = 3;
    private var SPEED_LV3:Float = 4;
    private var SPEED_LV4:Float = 3;

    private var DAMAGE_LV1:Float = 10;
    private var DAMAGE_LV2:Float = 50;
    private var DAMAGE_LV3:Float = 100;
    private var DAMAGE_LV4:Float = -10;

    public function new(X:Float, Y:Float,lv:Int,direction:Int)
    {
    	super(X,Y);
        facing = direction;
        level = lv;
        switch(level){
            case 1: {
                loadGraphic(Reg.CURSE1);
                speed = SPEED_LV1;
                damage = DAMAGE_LV1;
            }
            case 2:{
                 loadGraphic(Reg.CURSE2);
                 speed = SPEED_LV2;
                 damage = DAMAGE_LV2;
            }
            case 3: {
                loadGraphic(Reg.CURSE3);
                speed = SPEED_LV3;
                damage = DAMAGE_LV3;
            }
            case 4: { 
                loadGraphic(Reg.CURSE4);
                speed = SPEED_LV4;
                damage = DAMAGE_LV4;
            }
            default: {
                loadGraphic(Reg.CURSE1);
                speed = SPEED_LV1;
                damage = DAMAGE_LV1;
            }
        }
    }

    override public function update():Void
    {
    	super.update();
        if (facing == FlxObject.RIGHT){
            x +=speed;    
        }else{
            x -=speed;
        }
        
    }

    override public function destroy():Void
    {
        super.destroy();
    }

}