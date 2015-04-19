package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;

class Player extends FlxSprite
{
    public var isReadyToJump:Bool = false;
    public var isReadyToAttack:Bool = true;

    private var PLAYER_SPEED:Float = 160;
    public var PLAYER_HEALTH:Float = 200;
    private var JUMP_ACCEL:Float = 18000;
    private var GRAVITY:Float = 1100;
    private var lastTimeShot:Float = 0;
    private var shotCooldownTime = 60;
    private var state:PlayState;

    public var level:Int;

    public function new(X:Float, Y:Float,state:PlayState,lv:Int)
    {
        super(X,Y);

        health = PLAYER_HEALTH;
        level = lv;

        // init
        drag.x = PLAYER_SPEED*8;
        maxVelocity.set(PLAYER_SPEED, JUMP_ACCEL);

        loadGraphic(Reg.PLAYER, true, 32, 64, true, "player");
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        //bounding box
        width = 12;
        height = 50;
        offset.set(10, 14);

        this.state = state;

        //animations
        this.animation.add("walk", [0, 1, 0, 2], 12, true);
        this.animation.add("idle",[0],1,false);
        this.animation.add("attack",[3],1,false);
        this.animation.add("jump",[4],1,false);
        this.animation.add("dead",[5],1,true);

    }

    override public function update():Void
    {
        if (state.playingUpgrade){
            return;
        }

        acceleration.x = 0;
        acceleration.y = GRAVITY;

        if (velocity.y == 0 && !isReadyToJump){
            isReadyToJump = true;
        }

        //INPUT
        if (FlxG.keys.pressed.LEFT)
        {
            //Crappy way to avoid camera travelling fast towards player on create
            state.setCameraLead();
            moveLeft();
        }

        if (FlxG.keys.pressed.RIGHT)
        {
            //Crappy way to avoid camera travelling fast towards player on create 
            state.setCameraLead();
            moveRight();
        }

        if (FlxG.keys.justPressed.SPACE && isReadyToJump){
            FlxG.sound.play(Reg.SND_JUMP);
            jump();
        }

        if (FlxG.keys.justPressed.A && isReadyToAttack){
            FlxG.sound.play(Reg.SND_CURSE1);
            attack(1);
        }

        if (FlxG.keys.justPressed.S && isReadyToAttack && level >1){
            FlxG.sound.play(Reg.SND_CURSE2);
            attack(2);
        }

        if (FlxG.keys.justPressed.D && isReadyToAttack && level > 2){
            FlxG.sound.play(Reg.SND_CURSE3);
            attack(3);
        }

        if (FlxG.keys.justPressed.F && isReadyToAttack && level > 3){
            FlxG.sound.play(Reg.SND_CURSE4);
            attack(4);
        }

        if (lastTimeShot > 0){
            lastTimeShot--;    
            isReadyToAttack = false;
        }

        if (lastTimeShot <= 0){
            isReadyToAttack = true;
        }

        //Animation
        if (velocity.x !=0 && isReadyToJump){
            animation.play("walk");
        }

        if (velocity.x == 0 && isReadyToJump && isReadyToAttack){
            animation.play("idle");
        }

        if (velocity.y != 0)
        {
            animation.play("jump");
        }

        super.update();
    }

    private function moveRight():Void{
            facing = FlxObject.RIGHT;
            acceleration.x += drag.x;
    }

    private function moveLeft():Void{
            facing = FlxObject.LEFT;
            acceleration.x -= drag.x;
    }

    private function jump():Void{
            acceleration.y = -JUMP_ACCEL;
            isReadyToJump = false;
    }

    private function isDead():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }

    override public function kill():Void{
        animation.play("dead");
    }

    private function attack(level:Int):Void{
        isReadyToAttack = false;
        var c:Curse;
        if (facing == FlxObject.RIGHT){
            c = new Curse(x + 10,y,level,FlxObject.RIGHT);
            c.y = y- c.height/2;
        }else{
            c = new Curse(x,y,level,FlxObject.LEFT);
            c.y = y- c.height/2;
            c.x = x - c.width;
        }
        state.playerCurses.add(c);
        animation.play("attack");
        lastTimeShot = shotCooldownTime;
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}