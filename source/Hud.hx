import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;

class Hud extends FlxGroup
{
	public var background:FlxSprite;
	public var healthBar:FlxBar;
	public var gameOverText:FlxText;
	public var gameOverPressButtonText:FlxText;
	public var gotInsultBG:FlxSprite;
	public var gotInsultText1:FlxText;
	public var gotInsultText2:FlxText;
	public var insultGot:FlxSprite;
	public var pressUpText:FlxText;

	public var bossHealthBar:FlxBar;
	public var bossLoveBar:FlxBar;
	public var bossLifeText:FlxText;

	public function new(state:PlayState) 
	{
		super();
		
		background = new FlxSprite(10000 -50, -175);
		background.makeGraphic(300, 360, 0xFFFFFFFF);
		background.alpha = 0;
		add(background);
		
		var x:Int = 9990;

		var lifeText = new FlxText(x-350, -380, 300, "LIFE",35);
		lifeText.alpha = 1;
		lifeText.color = 0xFFFFFFFF;
		add(lifeText);

		healthBar = new FlxBar(x - 250,-380,FlxBar.FILL_LEFT_TO_RIGHT,150,40,state.player,"health",0,state.player.PLAYER_HEALTH,true);
        add(healthBar);

        bossHealthBar = new FlxBar(x + 450,-380,FlxBar.FILL_LEFT_TO_RIGHT,150,40,state.boss,"health",0,1000,true);
        add(bossHealthBar);

        bossLoveBar = new FlxBar(x + 450,-330,FlxBar.FILL_LEFT_TO_RIGHT,150,40,state.boss,"love",0,100,true);
        add(bossLoveBar);

        bossLifeText = new FlxText(x + 350, -380, 300, "BOSS",35);
		bossLifeText.alpha = 1;
		bossLifeText.color = 0xFFFFFFFF;
		add(bossLifeText);

        gameOverText = new FlxText(x + 135, 100,300,"GAME OVER",40);
        gameOverText.alpha = 0;
        add(gameOverText);

        gameOverPressButtonText = new FlxText(x + 150,200,300,"Press SPACE",30);
        gameOverPressButtonText.alpha = 0;
        add(gameOverPressButtonText);

        pressUpText = new FlxText(x + 125, 70,500,"Press UP to enter",40);
        pressUpText.alpha = 0;
        add(pressUpText);


        //Got insult modal
        gotInsultBG = new FlxSprite(x - 150,-300);
        gotInsultBG.makeGraphic(800,700,0xFFFFBD60,true,"gotInsultBG");
        add(gotInsultBG);

        gotInsultText1 = new FlxText(x- 100,-200,700,"YOU GOT A NEW CURSE!",45);
        gotInsultText1.color = FlxColor.BLACK;
        add(gotInsultText1);

        insultGot = new FlxSprite(x + 200,0);
        insultGot.loadGraphic(Reg.CURSE1);
        insultGot.setGraphicSize(200);
        add(insultGot);

        gotInsultText2 = new FlxText(x + 20,200,700,"Press A to use it",40);
        gotInsultText2.color = FlxColor.BLACK;
        add(gotInsultText2);

        hideGotInsult();
	}

	public function showGotInsult(level:Int):Void{
		switch(level){
			case 2:
				gotInsultText2.text = "Press S to use it!";
				insultGot.loadGraphic(Reg.CURSE2);
				insultGot.x = 10180;
			case 3:
				gotInsultText2.text = "Press D to use it!";
				insultGot.loadGraphic(Reg.CURSE3);
				insultGot.x = 10140;
			case 4:
				gotInsultText2.text = "Press F to use it!";
				insultGot.loadGraphic(Reg.CURSE4);
				insultGot.x = 10180;
		}

		gotInsultBG.alpha = 1;
		gotInsultText1.alpha = 1;
		gotInsultText2.alpha = 1;
		insultGot.alpha = 1;
	}

	public function hideGotInsult():Void{
		gotInsultBG.alpha = 0;
		gotInsultText1.alpha = 0;
		gotInsultText2.alpha = 0;
		insultGot.alpha = 0;
	}

	public function showPressUp():Void{
		pressUpText.alpha = 1;
	}

	public function hidePressUp():Void{
		pressUpText.alpha = 0;
	}

	public function showBossBars():Void{
		bossHealthBar.alpha = 1;
		bossLoveBar.alpha = 1;
		bossLifeText.alpha = 1;
	}

	public function hideBossBars():Void{
		bossHealthBar.alpha = 0;
		bossLoveBar.alpha = 0;
		bossLifeText.alpha = 0;
	}
}

