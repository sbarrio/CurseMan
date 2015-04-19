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

class WinEndingState extends FlxState
{

	private var pressedButton:Bool = false;
	private var pressStartText:FlxText;
	private var endText:FlxText;

	override public function create():Void
	{
		super.create();
		bgColor = FlxColor.BLACK;

		endText = new FlxText(190,180,300,"END",25);
		add(endText);

		pressStartText = new FlxText(165,240,300,"Press SPACE",15);
		add(pressStartText);

		FlxG.sound.playMusic(Reg.MUS_ENDING,1,true);

	}
	
	override public function update():Void
	{
		super.update();
		if (!pressedButton && FlxG.keys.justPressed.SPACE){
        	playStartAnim();
        }
	}	

	override public function destroy():Void
	{
		super.destroy();
	}

	public function playStartAnim():Void{
		var timer = new FlxTimer(1.5, finishedPlayingAnim);
	}

	public function finishedPlayingAnim(timer:FlxTimer):Void{

		FlxG.switchState(new TitleState());
	}

}