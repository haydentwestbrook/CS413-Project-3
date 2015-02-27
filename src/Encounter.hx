import starling.text.TextField;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Button;
import starling.animation.Transitions;
import starling.events.Event;
import starling.core.Starling;
import starling.display.Image;
import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.text.BitmapFont;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundMixer;
import Root;
import Root.GameOver;

class Encounter extends Sprite {

	public var image:Image;
	public var dialogBox:DialogBox;
	public var visited:Bool;
	public var thisTexture:String;
	public function new(texture:String, textString:String, options:Array<String>, rightAnswer:Int, rightText:String, wrongText:String, 
						rightTexture:String, wrongTexture:String, x:Int, y:Int,player, bonusOption:String, reqItem:String, 
						maxHealthLoss:Int, minHealthLoss:Int) {
		super();

		image = new Image(Root.assets.getTexture(texture));
		thisTexture = texture;
		image.x = x;
		image.y = y;
		addChild(image);
		dialogBox = new DialogBox(textString, options, rightAnswer, rightText, wrongText, rightTexture, wrongTexture, player, 
								  bonusOption, reqItem, maxHealthLoss, minHealthLoss);
		

		//Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, activateEncounter);
	}

	public function activateEncounter() {
		if(!visited) {
			addChild(dialogBox);
			if (this.thisTexture == "bear") {
				var beargrowl:SoundChannel = Root.assets.playSound("beargrowlshort");
			}
			Starling.current.stage.removeEventListeners();
			Starling.current.stage.addEventListener(Event.TRIGGERED, dialogBox.buttonHandler);
		}
	}

	public function deactivateEncounter() {
		visited = true;
		removeChild(dialogBox);
		Starling.current.stage.removeEventListeners();
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, cast (this.parent, Game).movement);

		cast(this.parent, Game).updatePlayerInfo();

		var winSituation = true;
		for(encounter in cast(this.parent, Game).encounters) {
			if(!encounter.visited){
		    		winSituation = false;
		    	}
		}
		if(winSituation){
		    var gameOver = new GameOver(true, this);
		}
	    if(cast(this.parent, Game).player.health <=0){
	    	var gameOver = new GameOver(false, this);
	    }

	}
}

class DialogBox extends Sprite {

	var background:Image;
	var text:TextField;
	var options:Array<String>;
	var rightAnswer:Int;
	var buttons:Array<Button>;
	var closeButton:Button;
	var rightText:String;
	var wrongText:String;
	var rightTexture:String;
	var wrongTexture:String;
	var reqItem:String;
	var bonusOption:String;
	var minHealthLoss:Int;
	var maxHealthLoss:Int;

	public function new(textString:String, options:Array<String>, rightAnswer:Int, rightText:String, wrongText:String, rightTexture:String, wrongTexture:String, player:Player, bonusOption:String, reqItem:String, maxHealthLoss:Int, minHealthLoss:Int) {
		super();
		this.rightAnswer = rightAnswer;
		this.rightText = rightText;
		this.wrongText = wrongText;
		this.rightTexture = rightTexture;
		this.wrongTexture = wrongTexture;
		this.reqItem = reqItem;
		this.bonusOption = bonusOption;
		this.minHealthLoss = minHealthLoss;
		this.maxHealthLoss = maxHealthLoss;

		background = new Image(Root.assets.getTexture("encounterScreen"));
		addChild(background);
		

		text = new TextField(250, 300, textString);
		text.hAlign = starling.utils.HAlign.LEFT;
		text.vAlign = starling.utils.VAlign.TOP;
		text.fontSize = 14;
		text.x = 275;
		text.y = 40;
		addChild(text);

		buttons = new Array<Button>();
		var y = 40;
		
		
		for(option in options) {
			var optionText = new TextField(250, 30, option);
			optionText.hAlign = starling.utils.HAlign.LEFT;
			optionText.fontSize = 14;
			optionText.x = 90;
				optionText.y = y + 6;
			addChild(optionText);

			var button = new Button(Root.assets.getTexture("optionbutton"));
			button.x = 50;
			button.y = y;
			buttons.push(button);
			addChild(button);
			y += 50;
		}
		for(item in player.inventory){
			if(item == reqItem){
				var optionText = new TextField(250, 30, bonusOption);
				optionText.hAlign = starling.utils.HAlign.LEFT;
				optionText.fontSize = 14;
				optionText.x = 90;
				optionText.y = y + 6;
				addChild(optionText);

				var button = new Button(Root.assets.getTexture("optionbutton"));
				button.x = 50;
				button.y = y;
				buttons.push(button);
				addChild(button);
				y += 50;
			}
		}
	}	

	public function buttonHandler(event:Event) {
		var buttonEvent = cast(event.target, Button);

		if(buttonEvent.name == "close") {
			cast(this.parent, Encounter).deactivateEncounter();
		}

		var i = 0;
		for(button in buttons) {
			if(button == buttonEvent && i == rightAnswer) {
				success();
			} else if(button == buttonEvent && i != rightAnswer) {
				fail();
			}
			i++;
		}
	}

	public function success() {
		text.text = rightText;
		var x = cast(parent,Encounter).image.x;
		var y = cast(parent,Encounter).image.y;
		parent.removeChild(cast(parent, Encounter).image);
		if(rightTexture != "") {
			var image = new Image(Root.assets.getTexture(rightTexture));
			image.x = x;
			image.y = y;
			cast (parent, Encounter).addChild(image);
		}

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 275;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);
	}

	public function fail() {
		if(maxHealthLoss > 0) {
			var rand = Std.random(maxHealthLoss);
			if(rand < minHealthLoss) {
				rand = minHealthLoss;
			}
			cast (this.parent.parent, Game).player.health -= rand;
		}


		text.text = wrongText;
		var x = cast(parent,Encounter).image.x;
		var y = cast(parent,Encounter).image.y;
		removeChild(cast(parent, Encounter).image);
		if(rightTexture != "") {
			var image = new Image(Root.assets.getTexture(rightTexture));
			image.x = x;
			image.y = y;
			cast (parent, Encounter).addChild(image);
		}

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 275;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);
	}
}