package states;

import zero.utilities.Color;
import zero.flixel.states.State;

class PlayState extends State
{

	public static var instance:PlayState;

	public function new() {
		super();
		instance = this;
	}

	override function create() {
		bgColor = Color.PICO_8_INDIGO.to_hex();
		add(new objects.Chicken(64, 64));
	}

	override function update(e:Float) {
		super.update(e);
	}

}