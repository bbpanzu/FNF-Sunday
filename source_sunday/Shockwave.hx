package;

import flixel.system.FlxAssets.FlxShader;

class Shockwave extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform float radius;
		uniform float scale;
		uniform float centerX;
		uniform float centerY;
		uniform float texOffset;
		
		void main()
		{
			//openfl_TextureCoordv.st += vec2(scale, 0.0);
			vec4 daFrag = texture2D(bitmap, openfl_TextureCoordv);
		
			if (radius == 0)
			{
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
		
			if (daFrag.x > centerX + radius && daFrag.x + openfl_TextureSize.x < daFrag.x + texOffset)
			{
				//daFrag.x += scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.x < centerX - radius && daFrag.x - openfl_TextureSize.x > daFrag.x - texOffset)
			{
				//daFrag.x -= scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.y > centerY + radius && daFrag.y + openfl_TextureSize.y < daFrag.y + texOffset)
			{
				//daFrag.y += scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.y < centerY - radius && daFrag.y - openfl_TextureSize.y > daFrag.y - texOffset)
			{
				//daFrag.y -= scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			gl_FragColor = daFrag;
		}')
	public function new()
	{
		super();
	}
}
