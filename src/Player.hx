import starling.text.TextField;
import starling.core.Starling;
import starling.display.Sprite;
import starling.utils.HAlign;
import starling.utils.VAlign;


class Player extends Sprite {
	
	public var textfield:TextField;
	textfield.hAlign = HAlign.MIDDLE;
	textfield.vAlign = VAlign.TOP;	
	
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

	public function new () {
		super();
		ranNum = Math.round(Math.random() * 6);
		thirst = 10-ranNum;
		hunger = 4+ranNum;
	}
	
	public function addToInv(name:String) {
		inventory.push(name);
		displayInv();
	}
	public function displayInv() {
		invString = "";
		for (var i = 0; i < inventory.length; i++) {
			invString += inventory[i] + " ";
		}
		textfield = new TextField(350, 200, invString); // Adjust for heigh and width of game
	}

}		






}