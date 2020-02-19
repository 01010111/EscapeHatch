package objects;

import flixel.FlxSprite;

class GameObject extends FlxSprite {

	public static var wait:Bool = false;

	public function new(x:Float, y:Float) {
		super(x, y);
	}

	override function update(elapsed:Float) {
		if (check_wait()) return;
		super.update(elapsed);
	}

	function check_wait() {
		return wait;
	}

}