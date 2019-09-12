precision mediump float;

varying vec2 fragTexCoord;
varying vec3 fragNormal;
varying vec3 vertPos;

uniform vec3 ambientLightIntensity;
uniform vec3 sunLightIntensity;
uniform vec3 sunlightDirection;
uniform vec3 specularIntensity;

uniform sampler2D sampler;

void main()
{
	vec3 surfaceNormal = normalize(fragNormal);
	vec3 normSunDir = normalize(sunlightDirection);

	vec4 texel = texture2D(sampler, fragTexCoord);

	//vec3 lightIntensity = ambientLightIntensity + sunLightIntensity * max(dot(fragNormal, normSunDir), 0.0);

	float lambertian = max(dot(surfaceNormal, normSunDir), 0.0);

	float specular = 0.0;

	if(lambertian > 0.0){
		vec3 R = reflect(-normSunDir, surfaceNormal);
		//vec3 R = 2.0 * lambertian *  surfaceNormal - normSunDir;    
    	vec3 V = normalize(-vertPos); 

    	float specAngle = max(dot(R, V), 0.0);
    	specular = pow(specAngle, 50.0);
	}

	vec3 lightIntensity = ambientLightIntensity + sunLightIntensity * lambertian + specularIntensity * specular ;

	gl_FragColor = vec4(texel.rgb * lightIntensity, texel.a);

	//gl_FragColor = vec4(texel.rgb * ambientLightIntensity + texel.rgb * sunLightIntensity * lambertian + 1.0 * specularIntensity * specular, texel.a);
}