package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

class TiledStage extends TiledMap
{
	
	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	public var platformTiles:FlxGroup;

	//object groups
	private var collidableTileLayers:Array<FlxTilemap>;
	
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();
		platformTiles = new FlxGroup();
		
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
	
		// Load Tile Maps
		for (tileLayer in layers)
		{
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= Reg.PATH_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			
			if (tileLayer.name == "bg"){

				backgroundTiles.add(tilemap);	

			}else if (tileLayer.name == "fg"){

				foregroundTiles.add(tilemap);

			}else{	

				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();

				if (tileLayer.name == "platform"){
					platformTiles.add(tilemap);
				}
				
				collidableTileLayers.push(tilemap);
			}
		}
	}
	
	public function loadObjects(state:PlayState)
	{
		for (group in objectGroups)
		{
			for (o in group.objects)
			{
				loadObject(o, group, state);
			}
		}
	}
	
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState)
	{
		var x:Int = o.x;	
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;
		
		switch (o.type.toLowerCase())
		{
			case "player_start":
				//creates player
				var player = new Player(x,y,state,1);
				state.player = player;
				state.add(player);
				
			case "enemy":
				 var level = Std.parseInt(o.custom.get("level"));
				 var enemy = new Enemy(x,y,level,state);
				 if (state.enemies == null){
				 	state.enemies = new FlxTypedGroup<Enemy>();
				 	state.add(state.enemies);
				 }
				 state.enemies.add(enemy);
				 //boss
				 if (level == 4){
				 	state.boss = enemy;
				 }

			case "door":

				 var curse = Std.parseInt(o.custom.get("curse"));
				 var door = new Door(x,y,curse);
				 if (state.doors == null){
				 	state.doors = new FlxTypedGroup<Door>();
				 	state.add(state.doors);
				 }
				 state.doors.add(door);
		}
	}

	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		var colliding:Bool = false;
		if (collidableTileLayers != null)
		{

			for (map in collidableTileLayers)
			{
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				// if(FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate))
				if(FlxG.overlap(map, obj, null, FlxObject.separate))
				{
					colliding = colliding || true;
				}else{
					colliding = colliding || false;
				}
			}

		}
		return colliding;
	}

}