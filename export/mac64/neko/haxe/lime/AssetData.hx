package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/images/boss.png", "assets/images/boss.png");
			type.set ("assets/images/boss.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/curse1.png", "assets/images/curse1.png");
			type.set ("assets/images/curse1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/curse2.png", "assets/images/curse2.png");
			type.set ("assets/images/curse2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/curse3.png", "assets/images/curse3.png");
			type.set ("assets/images/curse3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/curse4.png", "assets/images/curse4.png");
			type.set ("assets/images/curse4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/door.png", "assets/images/door.png");
			type.set ("assets/images/door.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy1.png", "assets/images/enemy1.png");
			type.set ("assets/images/enemy1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy2.png", "assets/images/enemy2.png");
			type.set ("assets/images/enemy2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy3.png", "assets/images/enemy3.png");
			type.set ("assets/images/enemy3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/explosion.png", "assets/images/explosion.png");
			type.set ("assets/images/explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/heart.png", "assets/images/heart.png");
			type.set ("assets/images/heart.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/icon.png", "assets/images/icon.png");
			type.set ("assets/images/icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player.png", "assets/images/player.png");
			type.set ("assets/images/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tile.png", "assets/images/tile.png");
			type.set ("assets/images/tile.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/title.png", "assets/images/title.png");
			type.set ("assets/images/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/maps/test_map.tmx", "assets/maps/test_map.tmx");
			type.set ("assets/maps/test_map.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/music/ending.wav", "assets/music/ending.wav");
			type.set ("assets/music/ending.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/stage.wav", "assets/music/stage.wav");
			type.set ("assets/music/stage.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/curse1.wav", "assets/sounds/curse1.wav");
			type.set ("assets/sounds/curse1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/curse2.wav", "assets/sounds/curse2.wav");
			type.set ("assets/sounds/curse2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/curse3.wav", "assets/sounds/curse3.wav");
			type.set ("assets/sounds/curse3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/curse4.wav", "assets/sounds/curse4.wav");
			type.set ("assets/sounds/curse4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyHurt1.wav", "assets/sounds/enemyHurt1.wav");
			type.set ("assets/sounds/enemyHurt1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyHurt2.wav", "assets/sounds/enemyHurt2.wav");
			type.set ("assets/sounds/enemyHurt2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyHurt3.wav", "assets/sounds/enemyHurt3.wav");
			type.set ("assets/sounds/enemyHurt3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyHurt4.wav", "assets/sounds/enemyHurt4.wav");
			type.set ("assets/sounds/enemyHurt4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyLoved.wav", "assets/sounds/enemyLoved.wav");
			type.set ("assets/sounds/enemyLoved.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/hitCurse.wav", "assets/sounds/hitCurse.wav");
			type.set ("assets/sounds/hitCurse.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/jump.wav", "assets/sounds/jump.wav");
			type.set ("assets/sounds/jump.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/playerHurt.wav", "assets/sounds/playerHurt.wav");
			type.set ("assets/sounds/playerHurt.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/powerup.wav", "assets/sounds/powerup.wav");
			type.set ("assets/sounds/powerup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
