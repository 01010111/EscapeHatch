package objects;

import zero.flixel.ec.ParticleEmitter;
import zero.flixel.ec.ParticleEmitter.FireOptions;
import zero.flixel.ec.ParticleEmitter.Particle;
import flixel.FlxObject;
import zero.utilities.Vec2;
import zero.flixel.input.PlayerController;

class Chicken extends GameObject {

	static var speed:Float = 120;

	var controller = new PlayerController();
	var v_d:String = 'down';
	var walk_particles:ParticleEmitter = new ParticleEmitter(() -> new WalkParticle());

	public function new(x:Float, y:Float) {
		super(x, y);
		make_graphic();
		controller.add();
		drag.set(speed * 2, speed * 2);
		maxVelocity.set(speed, speed);
		FlxG.state.add(walk_particles);
	}

	function make_graphic() {
		loadGraphic(Images.chicken__png, true, 24, 24);
		animation.add('idle_down', [0]);
		animation.add('walk_down', [1,2,3,4,5,6,7,8], 24);
		animation.add('idle_up', [9]);
		animation.add('walk_up', [10,11,12,13,14,15,16,17], 24);
		this.make_rect_hitbox(8, 12, 8, 8);
		this.set_facing_flip_horizontal();
		animation.callback = anim_callback;
	}

	function anim_callback(n:String, f:Int, i:Int) {
		if (f % 2 == 0) if (opposing_acceleration()) walk_particles.fire({
			position: getMidpoint().place_on_circumference(360.get_random(), 4.get_random()),
			acceleration: FlxPoint.get(0, -20)
		});
	}

	function opposing_acceleration() {
		return acceleration.x.sign_of() != velocity.x.sign_of() || velocity.x.sign_of() != acceleration.x.sign_of();
	}

	override function check_wait():Bool return false;
	override function update(elapsed:Float) {
		super.update(elapsed);
		controls();
		animations();
	}

	function controls() {
		walk();
	}

	function walk() {
		var d_in:Vec2 = Vec2.get(0, 0);
		if (controller.pressed(DPAD_UP)) d_in.y -= 1;
		if (controller.pressed(DPAD_DOWN)) d_in.y += 1;
		if (controller.pressed(DPAD_LEFT)) d_in.x -= 1;
		if (controller.pressed(DPAD_RIGHT)) d_in.x += 1;
		if (d_in.length > 0) d_in.length = 1;
		d_in *= speed * 3;
		acceleration.set(d_in.x, d_in.y);
		trace(d_in);
		d_in.put();
	}

	function animations() {
		if (velocity.vector_length() == 0) animation.play('idle_$v_d');
		else animation.play('walk_$v_d');
		if (velocity.x != 0) facing = acceleration.x < 0 ? FlxObject.LEFT : FlxObject.RIGHT;
		if (velocity.y != 0) v_d = velocity.y < 0 ? 'up' : 'down';
		animation.curAnim.frameRate = (velocity.vector_length() * 0.125).to_int();
	}

}

class WalkParticle extends Particle {
	public function new() {
		super();
		makeGraphic(8, 8, 0x00FFFFFF);
		this.drawCircle();
	}
	override function fire(options:FireOptions) {
		super.fire(options);
		var s = 1.get_random(0.25);
		scale.set(s, s);
		scale.tween({ x: 0, y: 0 }, 1.get_random(0.5), { onComplete: (_) -> kill() });
	}
}