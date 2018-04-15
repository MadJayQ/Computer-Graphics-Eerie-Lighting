precision mediump float;
varying vec4 v_color;
varying vec3 v_normal;

uniform bool u_ignoreLighting;

void main()
{   
    gl_FragColor = v_color;
}