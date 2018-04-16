precision mediump float;
varying vec3 v_lighting;
void main()
{   
    gl_FragColor = vec4(v_lighting, 1.0);
}