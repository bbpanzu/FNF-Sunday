package;

import openfl.filters.ShaderFilter;

class ShockwaveHandler
{
	public static var shockwave:ShaderFilter = new ShaderFilter(new Shockwave());
	
	public static function getValue(valName:String):Array<Float>
	{
		var daShit:Array<Float> = [];
		switch(valName)
		{
			case "texOffset":
				daShit = shockwave.shader.data.texOffset.value;
			case "centerX":
				daShit = shockwave.shader.data.centerX.value;
			case "centerY":
				daShit = shockwave.shader.data.centerY.value;
			case "radius":
				daShit = shockwave.shader.data.radius.value;
			case "scale":
				daShit = shockwave.shader.data.scale.value;
		}
		return daShit;
	}
	
	public static function setValue(valName:String, valueData:Array<Float>):Void
	{
		if (!Highscore.getPhoto())
		{
		switch(valName)
		{
			case "texOffset":
				shockwave.shader.data.texOffset.value = valueData;
			case "centerX":
				shockwave.shader.data.centerX.value = valueData;
			case "centerY":
				shockwave.shader.data.centerY.value = valueData;
			case "radius":
				shockwave.shader.data.radius.value = valueData;
			case "scale":
				shockwave.shader.data.scale.value = valueData;
		}
		}
	}
}