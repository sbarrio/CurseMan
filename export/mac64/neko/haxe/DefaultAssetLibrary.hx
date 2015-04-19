package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl._v2.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		path.set ("assets/images/boss.png", "assets/images/boss.png");
		type.set ("assets/images/boss.png", AssetType.IMAGE);
		path.set ("assets/images/curse1.png", "assets/images/curse1.png");
		type.set ("assets/images/curse1.png", AssetType.IMAGE);
		path.set ("assets/images/curse2.png", "assets/images/curse2.png");
		type.set ("assets/images/curse2.png", AssetType.IMAGE);
		path.set ("assets/images/curse3.png", "assets/images/curse3.png");
		type.set ("assets/images/curse3.png", AssetType.IMAGE);
		path.set ("assets/images/curse4.png", "assets/images/curse4.png");
		type.set ("assets/images/curse4.png", AssetType.IMAGE);
		path.set ("assets/images/door.png", "assets/images/door.png");
		type.set ("assets/images/door.png", AssetType.IMAGE);
		path.set ("assets/images/enemy1.png", "assets/images/enemy1.png");
		type.set ("assets/images/enemy1.png", AssetType.IMAGE);
		path.set ("assets/images/enemy2.png", "assets/images/enemy2.png");
		type.set ("assets/images/enemy2.png", AssetType.IMAGE);
		path.set ("assets/images/enemy3.png", "assets/images/enemy3.png");
		type.set ("assets/images/enemy3.png", AssetType.IMAGE);
		path.set ("assets/images/explosion.png", "assets/images/explosion.png");
		type.set ("assets/images/explosion.png", AssetType.IMAGE);
		path.set ("assets/images/heart.png", "assets/images/heart.png");
		type.set ("assets/images/heart.png", AssetType.IMAGE);
		path.set ("assets/images/icon.png", "assets/images/icon.png");
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		path.set ("assets/images/player.png", "assets/images/player.png");
		type.set ("assets/images/player.png", AssetType.IMAGE);
		path.set ("assets/images/tile.png", "assets/images/tile.png");
		type.set ("assets/images/tile.png", AssetType.IMAGE);
		path.set ("assets/images/title.png", "assets/images/title.png");
		type.set ("assets/images/title.png", AssetType.IMAGE);
		path.set ("assets/maps/test_map.tmx", "assets/maps/test_map.tmx");
		type.set ("assets/maps/test_map.tmx", AssetType.TEXT);
		path.set ("assets/music/ending.wav", "assets/music/ending.wav");
		type.set ("assets/music/ending.wav", AssetType.SOUND);
		path.set ("assets/music/stage.wav", "assets/music/stage.wav");
		type.set ("assets/music/stage.wav", AssetType.SOUND);
		path.set ("assets/sounds/curse1.wav", "assets/sounds/curse1.wav");
		type.set ("assets/sounds/curse1.wav", AssetType.SOUND);
		path.set ("assets/sounds/curse2.wav", "assets/sounds/curse2.wav");
		type.set ("assets/sounds/curse2.wav", AssetType.SOUND);
		path.set ("assets/sounds/curse3.wav", "assets/sounds/curse3.wav");
		type.set ("assets/sounds/curse3.wav", AssetType.SOUND);
		path.set ("assets/sounds/curse4.wav", "assets/sounds/curse4.wav");
		type.set ("assets/sounds/curse4.wav", AssetType.SOUND);
		path.set ("assets/sounds/enemyHurt1.wav", "assets/sounds/enemyHurt1.wav");
		type.set ("assets/sounds/enemyHurt1.wav", AssetType.SOUND);
		path.set ("assets/sounds/enemyHurt2.wav", "assets/sounds/enemyHurt2.wav");
		type.set ("assets/sounds/enemyHurt2.wav", AssetType.SOUND);
		path.set ("assets/sounds/enemyHurt3.wav", "assets/sounds/enemyHurt3.wav");
		type.set ("assets/sounds/enemyHurt3.wav", AssetType.SOUND);
		path.set ("assets/sounds/enemyHurt4.wav", "assets/sounds/enemyHurt4.wav");
		type.set ("assets/sounds/enemyHurt4.wav", AssetType.SOUND);
		path.set ("assets/sounds/enemyLoved.wav", "assets/sounds/enemyLoved.wav");
		type.set ("assets/sounds/enemyLoved.wav", AssetType.SOUND);
		path.set ("assets/sounds/hitCurse.wav", "assets/sounds/hitCurse.wav");
		type.set ("assets/sounds/hitCurse.wav", AssetType.SOUND);
		path.set ("assets/sounds/jump.wav", "assets/sounds/jump.wav");
		type.set ("assets/sounds/jump.wav", AssetType.SOUND);
		path.set ("assets/sounds/playerHurt.wav", "assets/sounds/playerHurt.wav");
		type.set ("assets/sounds/playerHurt.wav", AssetType.SOUND);
		path.set ("assets/sounds/powerup.wav", "assets/sounds/powerup.wav");
		type.set ("assets/sounds/powerup.wav", AssetType.SOUND);
		path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
		type.set ("assets/sounds/beep.ogg", AssetType.SOUND);
		path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
		type.set ("assets/sounds/flixel.ogg", AssetType.SOUND);
		
		
		#elseif html5
		
		var id;
		id = "assets/images/boss.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/curse1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/curse2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/curse3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/curse4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/door.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/explosion.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/heart.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/icon.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tile.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/title.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/maps/test_map.tmx";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/music/ending.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/music/stage.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/curse1.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/curse2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/curse3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/curse4.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyHurt1.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyHurt2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyHurt3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyHurt4.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyLoved.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/hitCurse.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/jump.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/playerHurt.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/powerup.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/beep.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/flixel.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null || (assetType == BINARY && type == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash




































#elseif html5




































#else

#if (windows || mac || linux)







#else




#end

#end
