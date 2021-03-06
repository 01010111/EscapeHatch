// Statics
import states.PlayState.instance as PLAYSTATE;

// Utilities
import util.AssetPaths;

// Frequent Usage
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;

// Extensions
using Math;
using Std;
using flixel.util.FlxSpriteUtil;
using zero.extensions.Tools;
using zero.flixel.extensions.FlxObjectExt;
using zero.flixel.extensions.FlxPointExt;
using zero.flixel.extensions.FlxSpriteExt;
using zero.flixel.extensions.FlxTilemapExt;
using zero.utilities.EventBus;
using flixel.tweens.FlxTween;

#if OGMO
using zero.utilities.OgmoUtils;
using zero.flixel.utilities.FlxOgmoUtils;
#end