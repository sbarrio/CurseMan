package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.ui.FlxBar;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class PlayState extends FlxState
{

    public var isGameOver:Bool = false;
    public var isWinGame:Bool = false;
    public var isLoveGame:Bool = false;
    public var player:Player;
    public var boss:Enemy;
    public var playerCurses:FlxTypedGroup<Curse>;
    public var enemyCurses:FlxTypedGroup<Curse>;
    public var enemies:FlxTypedGroup<Enemy>;
    public var doors:FlxTypedGroup<Door>;

    public var playingUpgrade:Bool = false;
    public var currentDoor:Door = null;

    private var hud:Hud;
    private var hudCam:FlxCamera;
    private var cam: FlxCamera;
    
    var levelName:String = "test_map";
    var level:TiledStage;

    //HUD
    var healthBar:FlxBar;


    override public function create():Void
    {
        super.create();
        this.bgColor = 0xFF39B5FF;

        //loads level
        level = new TiledStage("assets/maps/" + levelName + ".tmx");

        //adds level tiles
        add(level.backgroundTiles);
        add(level.platformTiles);

        //loads level objects
        level.loadObjects(this);

        enemyCurses = new FlxTypedGroup<Curse>();
        playerCurses = new FlxTypedGroup<Curse>();
        add(enemyCurses);
        add(playerCurses);
        
        //adds foreground tiles
        add(level.foregroundTiles);

        //camera leads player movement
        cam = FlxG.camera;
        cam.follow(player, flixel.FlxCamera.STYLE_PLATFORMER, null, 0);

        hud = new Hud(this);
        add(hud);
        
        hudCam = new FlxCamera(100, 0, 1000, 1000);
        hudCam.zoom = 1;
        hudCam.follow(hud.background);
        hudCam.bgColor = 0x00FFFFFF;
        FlxG.cameras.add(hudCam);

        FlxG.sound.playMusic(Reg.MUS_STAGE,0.2,true);

        //DEBUG (NOTE: renember to uncomment FLX_NO_DEBUG on project.xml on release)
        FlxG.debugger.visible = false;    
    }

    public function setCameraLead():Void{
        if (cam.followLead.x != 10){
            cam.followLead.x = 10;
            cam.followLead.y = 10;
            cam.followLerp = 7;
        }
    }

    private function goToTitle(timer:FlxTimer):Void{
        FlxG.switchState(new TitleState());
    }

    private function goToWinEnding(timer:FlxTimer):Void{
        FlxG.switchState(new WinEndingState());
    }

    private function goToLoveEnding(timer:FlxTimer):Void{
        FlxG.switchState(new LoveEndingState());
    }
    
    override public function update():Void
    {

        if (boss!= null && boss.isOnScreen() && !isWinGame && !isLoveGame){
            hud.showBossBars();
            if (boss.isDead()){
                isWinGame = true;
                var timer = new FlxTimer(1.5, goToWinEnding);

            }
            if (boss.love >= 100){
                isLoveGame = true;
                boss.animation.play("loved");
                var timer = new FlxTimer(1.5, goToLoveEnding);
            }
        }else{
            hud.hideBossBars();
        }

        if (isWinGame){
            hud.update();
            return;
        }

        if (isLoveGame){
            hud.update();
            return;
        }

        if (isGameOver){
            hud.update();
            hud.gameOverText.alpha = 1;
            hud.gameOverPressButtonText.alpha = 1;
            if (FlxG.keys.justPressed.SPACE){
                var timer = new FlxTimer(1, goToTitle);
            }
            return;
        }

        super.update();

        if (playingUpgrade){
            return;
        }

    //OBJECT UPDATE

        //curses out of bounds?
        for (c in playerCurses){
            if (!c.isOnScreen()){
                playerCurses.remove(c);
                c.destroy();
            }
        }

        for (c in enemyCurses){
            if (!c.isOnScreen()){
                enemyCurses.remove(c);
                c.destroy();
            }
        }

        //enemies active?
        for (e in enemies){
            if (e.isOnScreen()){
                e.active = true;
            }else{
                e.active = false;
            }
        }


    //COLLISIONS

        //Player collision with map
        if (player!=null){
            level.collideWithLevel(player); 
            //with map limits
            if (player.x < 0){
                player.x = 0;
            }

            if (player.x > level.fullWidth){
                player.x = level.fullWidth - 10;
            }
        }

        //Player collision with enemies
        FlxG.overlap(enemies, player, null, overlapped);

        //Player collision with enemiy Curses
        FlxG.overlap(enemyCurses, player, null, overlapped);

        //Enemy collisions with map
        for (e in enemies){
            level.collideWithLevel(e); 
            //with map limits
            if (e.x < 0){
                e.x = 0;
            }

            if (e.x > level.fullWidth){
                e.x = level.fullWidth - 10;
            }
        }

        //playerCurses with enemies
        FlxG.overlap(playerCurses, enemies, null, overlapped);

        //curses and curses
        FlxG.overlap(playerCurses, enemyCurses, null, overlapped);

        //Player with doors
        FlxG.overlap(doors,player,null,overlapped);

        if (currentDoor== null){
            hud.hidePressUp();
        }

        if (FlxG.keys.pressed.UP && currentDoor != null){
            //obtain upgrade
            playUpgrade(currentDoor.curseToLearn);
            currentDoor.active = false;
        }

        currentDoor = null;

    }   

    private function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Bool
    {
        var sprite1ClassName:String = Type.getClassName(Type.getClass(Sprite1));
        var sprite2ClassName:String = Type.getClassName(Type.getClass(Sprite2));

        //Player and Enemy
        if ((sprite1ClassName == "Enemy") && (sprite2ClassName == "Player")){

            FlxObject.separateY(Sprite1,Sprite2);
            if (Sprite1.velocity.x > 0){
                //enemy going right
                Sprite2.velocity.x += 100;
            }else{
                //enemy going left
                Sprite2.velocity.x -= 100;
            }

            return true;
        }

        //Curse and Player
        if ((sprite1ClassName == "Curse") && (sprite2ClassName == "Player")){
            var c: Dynamic = cast(Sprite1,Curse);
            var p: Dynamic = cast(Sprite2,Player);

            p.hurt(c.damage);
            FlxG.sound.play(Reg.SND_PLAYER_HURT);
            if (p.isDead()){
                p.kill();
                isGameOver = true;
            }

            var exp = new Explosion(p.x, p.y);
            add(exp);
            
            enemyCurses.remove(c);
            c.destroy();

            return true;
        }

        //Curse and Enemy
        if ((sprite1ClassName == "Curse") && (sprite2ClassName == "Enemy")){
            var c: Dynamic = cast(Sprite1,Curse);
            var e: Dynamic = cast(Sprite2,Enemy);
            e.hurt(c.damage);
            if (e.isDead()){
                e.kill();
                enemies.remove(e);
                e.destroy();
            }

            var exp = new Explosion(e.x, e.y);
            add(exp);
            
            playerCurses.remove(c);
            c.destroy();

            return true;
        }

        //Curses and curses
        if ((sprite1ClassName == "Curse") && (sprite2ClassName == "Curse")){
            var cp: Dynamic = cast(Sprite1,Curse);
            var ce: Dynamic = cast(Sprite2,Curse);

            if (cp.x < ce.x){
                var exp = new Explosion(cp.x+cp.width, cp.y);
                add(exp);
            }else{
                var exp = new Explosion(ce.x+ce.width, ce.y);
                add(exp);
            }

            FlxG.sound.play(Reg.SND_HIT_CURSE);

            if (cp.level > ce.level){
                enemyCurses.remove(ce);
                ce.destroy();
            }

            if (cp.level < ce.level){
                playerCurses.remove(cp);
                cp.destroy();
            }

            if (cp.level == ce.level){
                playerCurses.remove(cp);
                cp.destroy();
                enemyCurses.remove(ce);
                ce.destroy();
            }
        }

        //Doors
        if ((sprite1ClassName == "Door") && (sprite2ClassName == "Player")){
            var d: Dynamic = cast(Sprite1,Door);
            if (d.active){
                currentDoor = d;       
                hud.showPressUp();         
            }
        }

        return true;
    }

    public function playUpgrade(level:Int):Void{
        FlxG.sound.play(Reg.SND_POWERUP);
        var timer = new FlxTimer(3, finishedPlayUpgrade);
        player.level = level;
        playingUpgrade = true;
        hud.showGotInsult(level);
    }

    public function finishedPlayUpgrade(timer:FlxTimer):Void{
        playingUpgrade = false;
        hud.hideGotInsult();
    }

    override public function destroy():Void
    {
        super.destroy();
        player.destroy();
        player = null;
        level = null;
    }
}