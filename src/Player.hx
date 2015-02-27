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
	public var health:Int;
	public var inventory:Array<String> = new Array();
	public var ranNum:Int;
	public var playerImg:Image;
	
	public function new () {
		super();
		//playerImg = Root.assets.getTexture("player");
		ranNum = Math.round(Math.random() * 6);
		health = 10-ranNum;
		playerImg = new Image(Root.assets.getTexture("player"));
		this.x = 750;
		this.y = 30;
		addChild(playerImg);
		//inventory.push("test"); //testing functionality for special buttons
	}

	
	public function addToInv(name:String) {
		inventory.push(name);
		displayInv();
	}
	public function displayInv():String {
		invString = "";
		for (i in 0...inventory.length) {
			invString += inventory[i] + " ";
		}
		return invString;
	}

}		






