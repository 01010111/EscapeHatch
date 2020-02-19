package objects;

import flixel.FlxSprite;

class GameObject extends FlxSprite {

	public static var wait:Bool = false;

	public var cx(get, never):Int;
	function get_cx() {
		return (getMidpoint().x / 16).floor();
	}
	public var cy(get, never):Int;
	function get_cy() {
		return (getMidpoint().y / 16).floor();
	}

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