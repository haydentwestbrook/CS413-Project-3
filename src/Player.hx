import starling.text.TextField;
import starling.core.Starling;
import starling.display.Sprite;
import starling.utils.HAlign;
import starling.utils.VAlign;
import starling.display.Image;
import starling.events.Event;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;

import Root;


class Player extends Sprite {
	
	public var textfield:TextField;
	//textfield.hAlign = HAlign.MIDDLE;
	//textfield.vAlign = VAlign.TOP;	
	
	/*
	basic code for registering bitmap font (i think). 
	var texture:Texture = Root.assets.getTexture(FontTexture);
	var xml:XML = Root.assets.getXml(xmlName); // font.fnt
	Textfield.registerBitmapFont(new BitmapFont(texture, xml));
	textfield.fontName = "fontName"; // same as font in font.fnt file
	*/
	
	public var invString:String;
	public var thirst:Int;
	public var hunger:Int;
	public var inventory:Array<String> = new Array();
	public var ranNum:Int;
	public var playerImg:Image;
	public var player:Image;
	
	public function new () {
		super();
		//playerImg = Root.assets.getTexture("player");
		ranNum = Math.round(Math.random() * 6);
		thirst = 10-ranNum;
		hunger = 4+ranNum;
		player = new Image(Root.assets.getTexture("berrybush"));
		addChild(player);
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, movement);
	}

	public function movement(event:KeyboardEvent) {
	    if (event.keyCode == Keyboard.LEFT) {
	    	player.x -= 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.RIGHT) {
	    	player.x += 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.UP) {
	    	player.y -= 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.DOWN) {
	    	player.y += 10; //placeholder
	    }
	    if(player.x <= 0){
	    	player.x = 0;  //placeholder
	    }
	    else if((player.x + player.width) >= stage.stageWidth){
	    	player.x = stage.stageWidth - player.width;
	    }
	    if(player.y <= 0){
	    	player.y = 0;  //placeholder
	    }
	    else if((player.y + player.height)>= stage.stageHeight){
	    	player.y = stage.stageHeight - player.height; //placeholder
	    }
	    /*for(child in children){ //pseudo-code, will check items on stage and see if they intersect with the player, then will prompt the player for action based on the item.
	    	var bound1 = player.bounds;
	    	var bound2 = child.bounds;
	    	if bound1.intersects(bound2){
	    		if (child == "berrybush"){
	    			//TODO
	    		}
	    	}
	    }*/
	}
	
	public function addToInv(name:String) {
		inventory.push(name);
		displayInv();
	}
	public function displayInv() {
		invString = "";
		for (i in 0...inventory.length) {
			invString += inventory[i] + " ";
		}
		textfield = new TextField(350, 200, invString); // Adjust for heigh and width of game
	}

}		






