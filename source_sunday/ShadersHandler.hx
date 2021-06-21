package;

import openfl.filters.ShaderFilter;

class ShadersHandler
{
	public static var chromaticAberration:ShaderFilter = new ShaderFilter(new ChromaticAberration());
	public static var brightShader:ShaderFilter = new ShaderFilter(new Bright());

	public static function setBrightness(brightness:Float):Void
	{
		if (Highscore.getPhoto())
		{
			brightness = 0.0;
		}
		brightShader.shader.data.brightness.value = [brightness];
	}
	
	public static function setContrast(contrast:Float):Void
	{
		if (Highscore.getPhoto())
		{
			contrast = 1.0;
		}
		brightShader.shader.data.contrast.value = [contrast];
	}
	
	public static function setChrome(chromeOffset:Float):Void
	{
		if (Highscore.getPhoto())
		{
			chromeOffset = 0.0;
		}
		chromaticAberration.shader.data.rOffset.value = [chromeOffset];
		chromaticAberration.shader.data.gOffset.value = [0.0];
		chromaticAberration.shader.data.bOffset.value = [chromeOffset * -1];
	}
}