package;

import flixel.*;
import flixel.system.FlxAssets.FlxShader;
/**
 * ...
 * @author bbpanzu
 */
class DirectionalBlur extends FlxShader
{
	
	@:glFragmentSource('
	
		#pragma header
			uniform float angle = 90.0;
			uniform float strength = 0.01;
	vec4 color = texture2D(bitmap, openfl_TextureCoordv);
	//looks good @50, can go pretty high tho
			vec2 uv = openfl_TextureCoordv.xy;
			
		const int samples = 20;
			
		vec4 dirBlur(sampler2D tex, vec2 uv, vec2 angle)
		{
			vec3 acc = vec3(0);
			
			const float delta = 2.0 / float(samples);
			
			for(float i = -1.0; i <= 1.0; i += delta)
			{
				acc += texture2D(tex, uv - vec2(angle.x * i, angle.y * i)).rgb;
			}
			
			
			return vec4(delta * acc, 0);
			
		}


		void main()
		{
			
			
			
			float r = radians(angle);
			vec2 direction = vec2(sin(r), cos(r));
			
			gl_FragColor = dirBlur(bitmap, uv, strength*direction);
		}
			
	
	
	')

	public function new() 
	{
		super();
	}
	
}