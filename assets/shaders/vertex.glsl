precision mediump float;
attribute vec4 a_position;
attribute vec3 a_color;
attribute vec3 a_normal;

uniform vec3 u_viewWorldPos;
uniform mat4 u_viewMatrix;
uniform mat4 u_modelMatrix;
uniform mat4 u_projectionMatrix;
uniform mat4 u_normalTransform;

varying vec3 v_lighting;


struct Light {
    vec4 position;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shine;
};

vec3 illuminate(vec4 pos, vec3 nrm, Light src, Material mat) {
    vec3 s = normalize(vec3(src.position - pos));
    vec3 v = normalize(-pos.xyz);
    vec3 r = reflect(-s, nrm);

    vec3 ambient = src.ambient * mat.ambient;
    float sdotn = max(dot(s, nrm) , 0.0);
    vec3 diffuse = src.diffuse * mat.diffuse * sdotn;
    vec3 spec = vec3(0.0);

    if(sdotn > 0.0) {
        spec = src.specular * mat.specular * pow(max(dot(r, v), 0.0), mat.shine);
    }

    return ambient + diffuse + spec;
}


void main()
{
    Light src;
    src.position = vec4(0.0, 5.0, 0.0, 1.0);
    src.ambient = vec3(0.3, 0.3, 0.3);
    src.diffuse = vec3(1.0, 1.0, 1.0);
    src.specular = vec3(1.0, 1.0, 1.0);

    Material mat;
    mat.ambient = vec3(0.9, 0.5, 0.3);
    mat.diffuse = vec3(0.9, 0.5, 0.3);
    mat.specular = vec3(0.8, 0.8, 0.8);
    mat.shine = 100.0;

    vec4 p = u_modelMatrix * a_position;
    vec4 n = normalize(mat3(u_normalTransform) * a_normal);
    v_lighting = illuminate(p, n, src, mat);
    gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * a_position;
}