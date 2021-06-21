package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxCamera;
#if (web || android)
import ui.FlxVirtualPad;
#end

using StringTools;

class EffectsMenu extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	
	var mainCam:FlxCamera;
	var higherCam:FlxCamera;
	
	#if (web || android)
	var _pad:FlxVirtualPad;
	#end

	override function create()
	{
		mainCam = new FlxCamera();
		higherCam = new FlxCamera();
		higherCam.bgColor.alpha = 0;
	
		FlxG.cameras.reset(mainCam);
		FlxG.cameras.add(higherCam);
		
		FlxCamera.defaultCameras = [mainCam];
		
		#if (web || android)
		_pad = new FlxVirtualPad(UP_DOWN, A_B);
		_pad.alpha = 0.65;
		add(_pad);
		_pad.cameras = [higherCam];
		#end
	
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Changing Visual Effects...", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);
		
		grpSongs = new FlxTypedGroup<Alphabet>();

		fuckTheClearance();

		if (!FlxG.sound.music.playing)
		{
		FlxG.sound.playMusic(Paths.music('brosucks'), 0, true);
		FlxG.sound.music.fadeIn(2, 0, 0.8);
		}
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}
	
	public function fuckTheClearance():Void
	{
	remove(grpSongs);
	grpSongs = new FlxTypedGroup<Alphabet>();
	songs.splice(0, songs.length);
	add(grpSongs);
	
	var ourFuckingList:Array<String> = Highscore.getEffectKeys();
	
	var fuckingBool:Array<Bool> = [];
	
	var myFuckingList:Array<String> = Highscore.getEffects();
	
	for (shit in ourFuckingList)
	{
		var finalShit:String = shit.replace("2", " TWO ");
		if (myFuckingList.contains(shit))
		{
		finalShit += " ON";
		} else {
		finalShit += " OFF";
		}
		songs.push(new SongMetadata(finalShit, 1, 'gf'));
	}
	
	for (daItem in ourFuckingList)
	{
	if (myFuckingList.contains(daItem))
	{
	fuckingBool.push(true);
	} else {
	fuckingBool.push(false);
	}
	}

	for (i in 0...songs.length)
	{
		var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		#if !web
		if (fuckingBool[i])
		{
		songText.color = 0xffff33;
		}
		#end
		grpSongs.add(songText);
	}
	changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP:Bool = false;
		var downP:Bool = false;
		var accepted:Bool = false;
		var LEFT_P:Bool = false;
		var RIGHT_P:Bool = false;
		var backed:Bool = false;
		
		#if (web || android)
		upP = controls.UP_P || _pad.buttonUp.justPressed;
		downP = controls.DOWN_P || _pad.buttonDown.justPressed;
		accepted = controls.ACCEPT || _pad.buttonA.justPressed;
		backed = controls.BACK || _pad.buttonB.justPressed;
		#if android
		if (FlxG.android.justReleased.BACK)
		{
		backed = true;
		}
		#end
		#else
		upP = controls.UP_P;
		downP = controls.DOWN_P;
		accepted = controls.ACCEPT;
		backed = controls.BACK;
		#end

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		
		if (Highscore.getInput() && FlxG.mouse.wheel != 0)
		{
			changeSelection(FlxG.mouse.wheel * -1);
		}

		if (backed)
		{
			FlxG.switchState(new SettingsMenu());
		}

		if (accepted)
		{
			Highscore.toggleEffect(curSelected);
			fuckTheClearance();
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}