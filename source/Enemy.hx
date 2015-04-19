package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxRandom;

class Enemy extends FlxSprite
{
    private var state:PlayState;
    private var ENEMY_SPEED:Float;
    private var ENEMY_VIEW_DISTANCE:Float;

    private var LV_1_ENEMY_SPEED:Float = 40;
    private var LV_2_ENEMY_SPEED:Float = 80;
    private var LV_3_ENEMY_SPEED:Float = 140;
    private var LV_4_ENEMY_SPEED:Float = 0;

    private var LV1_VIEW_DISTANCE:Float = 150;
    private var LV2_VIEW_DISTANCE:Float = 200;
    private var LV3_VIEW_DISTANCE:Float = 250;
    private var LV4_VIEW_DISTANCE:Float = 500;

    private var GRAVITY:Float = 1100;

    public var level:Int;
    private var lastTimeShot:Float = 0;
    private var shotCooldownTime = 150;
    public var isReadyToAttack:Bool = true;
    public var love:Float = 0;

    //Movement control
    private var moveTimer:Float = 0;
    private var moveCoolDown:Float = 100;

    public function new(X:Int, Y:Int,level:Int,state:PlayState)
    {
    	super(X,Y);
        this.level = level;
        active = false;
        switch(level){
            case 1: {
                    loadGraphic(Reg.ENEMY1,true,32,64,true,"enemy1");
                    health = 20;
                    width = 12;
                    height = 50;
                    offset.set(10, 14);
                    ENEMY_SPEED = LV_1_ENEMY_SPEED;
                    ENEMY_VIEW_DISTANCE = LV1_VIEW_DISTANCE;
                    //animations
                    this.animation.add("walk", [0, 1, 0, 2], 12, true);
                    this.animation.add("idle",[0],1,false);
                }
            case 2: {
                    loadGraphic(Reg.ENEMY2,true,32,64,true,"enemy2");
                    health = 100;
                    ENEMY_SPEED = LV_2_ENEMY_SPEED;
                    ENEMY_VIEW_DISTANCE = LV2_VIEW_DISTANCE;
                    //animations
                    this.animation.add("walk", [0, 1, 0, 2], 12, true);
                    this.animation.add("idle",[0],1,false);
                }
            case 3: {
                    loadGraphic(Reg.ENEMY3,true,32,64,true,"enemy3");
                    health = 200;
                    width = 12;
                    height = 50;
                    offset.set(10, 14);
                    ENEMY_SPEED = LV_3_ENEMY_SPEED;
                    ENEMY_VIEW_DISTANCE = LV3_VIEW_DISTANCE;
                    //animations
                    this.animation.add("walk", [0, 1, 0, 2], 12, true);
                    this.animation.add("idle",[0],1,false);
                }
            case 4: {
                    loadGraphic(Reg.BOSS,true,64,64,true,"boss");
                    health = 1000;
                    ENEMY_SPEED = LV_4_ENEMY_SPEED;
                    ENEMY_VIEW_DISTANCE = LV4_VIEW_DISTANCE;
                    //animations
                    this.animation.add("attack", [1], 5, false);
                    this.animation.add("dead", [2], 5, false);
                    this.animation.add("loved", [3], 5, false);
                    this.animation.add("idle",[0],1,false);

                }
            default: {
                    loadGraphic(Reg.ENEMY1,true,32,64,true,"enemy1");
                    health = 100;
                    width = 12;
                    height = 50;
                    offset.set(10, 14);
                    ENEMY_SPEED = LV_1_ENEMY_SPEED;
                    ENEMY_VIEW_DISTANCE = LV1_VIEW_DISTANCE;
                    //animations
                    this.animation.add("walk", [0, 1, 0, 2], 12, true);
                    this.animation.add("idle",[0],1,false);
                }
        }
        
        maxVelocity.set(ENEMY_SPEED, 100);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        this.state = state;
    }

    override public function update():Void
    {
        if (state.playingUpgrade){
            return;
        }

        acceleration.x = 0;
        acceleration.y = GRAVITY;

        if (!active){
            return;
        }

        if (lastTimeShot > 0){
            lastTimeShot--;    
            isReadyToAttack = false;
        }

        if (lastTimeShot <= 0){
            isReadyToAttack = true;
        }

        ai();

    	super.update();
    }

    override public function hurt(damage:Float):Void{
        if (damage < 0){
            love += -1 * damage;
            FlxG.sound.play(Reg.SND_ENEMY_LOVED);
        }else{
            health-=damage;    
            switch(level){
                case 1: FlxG.sound.play(Reg.SND_ENEMY_HURT1);
                case 2: FlxG.sound.play(Reg.SND_ENEMY_HURT2);
                case 3: FlxG.sound.play(Reg.SND_ENEMY_HURT3);
                case 4: FlxG.sound.play(Reg.SND_ENEMY_HURT4);
                default: FlxG.sound.play(Reg.SND_ENEMY_HURT1);
            }
        }
    }

    public function isDead():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }

    override public function kill():Void{
        //play kill animation
        var animDead = animation.getByName("dead");
        if (animDead != null){
            animation.play("dead");
        }
        //play sound dead
    }

    public function ai():Void{

        if (level < 4){
            if (moveTimer > 0){
                moveTimer--;
            }
            if (moveTimer <= 0){
                moveTimer = moveCoolDown;
                stop();

                //if player nearby and ready to attack -> attack
                var dist:Float = 0;
                var player = state.player;
                var direction = FlxObject.RIGHT;

                //player to the right
                if (player.x > x){
                    dist = player.x - x;
                }else{
                    dist = x - player.x;
                    direction = FlxObject.LEFT;
                }

                if (isReadyToAttack && dist <= ENEMY_VIEW_DISTANCE){
                    attack(direction);
                }else{
                     //else, move
                    if (FlxRandom.chanceRoll()){
                        moveRight();
                    }else{
                        moveLeft();
                    }
                }
            }
             //Animation
            if (velocity.x !=0){
                animation.play("walk");
            }

            if (velocity.x == 0){
                animation.play("idle");
            }
        }else{
            //BOSS AI

            //if player nearby and ready to attack -> attack
            var dist:Float = state.player.x - x;
                        
            if (isReadyToAttack && dist <= ENEMY_VIEW_DISTANCE){
                if (FlxRandom.chanceRoll()){
                    if (FlxRandom.chanceRoll()){
                        level = 3;    
                    }else{
                        level = 2;
                    }
                }else{
                    level = 1;
                }
                attack(FlxObject.LEFT); 
            }
            
            level = 4;
        }
    }

    private function attack(direction:Int):Void{
        isReadyToAttack = false;
        lastTimeShot = shotCooldownTime;
        var c:Curse;
        facing = direction;

        if (facing == FlxObject.RIGHT){
            c = new Curse(x + 10,y,level,FlxObject.RIGHT);
            c.y = y- c.height/2;
        }else{
            c = new Curse(x,y,level,FlxObject.LEFT);
            c.y = y- c.height/2;
            c.x = x - c.width;
        }
        state.enemyCurses.add(c);
        lastTimeShot = shotCooldownTime;
    }

    private function moveRight():Void{
        facing = FlxObject.RIGHT;
        velocity.x = ENEMY_SPEED;
    }

    private function moveLeft():Void{
        facing = FlxObject.LEFT;
        velocity.x = -ENEMY_SPEED;
    }

    private function stop():Void{
        velocity.x = 0;
    }

    override public function destroy():Void
    {
        super.destroy();
    }

}