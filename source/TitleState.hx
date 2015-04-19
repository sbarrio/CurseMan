package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxTimer;

class TitleState extends FlxState
{

	private var pressedButton:Bool = false;
	private var insult:FlxSprite;
	private var title:FlxSprite;
	private var curseMan:FlxSprite;
	private var copy:FlxText;
	private var pressStartText:FlxText;

	override public function create():Void
	{
		super.create();
		bgColor = FlxColor.WHITE;
		title = new FlxSprite(130,50);
		title.loadGraphic(Reg.TITLE);
		add(title);

		curseMan = new FlxSprite(40,180);
		curseMan.x = 80;
		curseMan.y = 200;
		curseMan.loadGraphic(Reg.PLAYER,true,32,64,true,"titleCurse");
		curseMan.animation.add("attack",[3],1,false);
		add(curseMan);

		pressStartText = new FlxText(140,180,300,"Press SPACE",25);
		pressStartText.color = FlxColor.BLACK;
		add(pressStartText);

		copy = new FlxText(160,250,300,"sbarrio 2015",15);
		copy.color = FlxColor.BLACK;
		add(copy);

		insult = new FlxSprite(70,180);
		insult.loadGraphic(Reg.CURSE3);
		add(insult);
		insult.alpha = 0;

		FlxG.sound.destroy(true);
	}
	
	override public function update():Void
	{
		super.update();
		if (!pressedButton && FlxG.keys.justPressed.SPACE){
        	playStartAnim();
        }

        if (!insult.isOnScreen()){
        	insult.velocity.x = 0;
        }
	}	

	override public function destroy():Void
	{
		super.destroy();
		insult.destroy();
		copy.destroy();
		curseMan.destroy();
		title.destroy();
		pressStartText.destroy();
		insult = null;
		copy = null;
		curseMan = null;
		title = null;
		pressStartText = null;
	}

	public function playStartAnim():Void{
		FlxG.sound.play(Reg.SND_CURSE3);
		insult.alpha = 1;
		insult.velocity.x = 250;
		curseMan.animation.play("attack");
		var timer = new FlxTimer(2, finishedPlayingAnim);
	}

	public function finishedPlayingAnim(timer:FlxTimer):Void{

		FlxG.switchState(new PlayState());
	}

}