precision mediump float;

attribute vec3 vertPosition;
attribute vec2 vertTexCoord;
attribute vec3 vertNormal;

varying vec2 fragTexCoord;
varying vec3 fragNormal;
varying vec3 vertPos;

uniform mat4 mWorld;
uniform mat4 mView;
uniform mat4 mProj;

void main()
{
  vec4 vertPos4 =  mView * mWorld * vec4(vertPosition, 1.0);
  vertPos = vec3(vertPos4) / vertPos4.w;

  fragTexCoord = vertTexCoord;
  fragNormal = (mWorld * vec4(vertNormal, 0.0)).xyz;
  gl_Position = mProj * mView * mWorld * vec4(vertPosition, 1.0);
}