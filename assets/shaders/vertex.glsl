attribute vec4 a_position;
attribute vec3 a_color;
attribute vec3 a_normal;

uniform vec3 u_viewWorldPos;
uniform mat4 u_viewMatrix;
uniform mat4 u_modelMatrix;
uniform mat4 u_projectionMatrix;
uniform mat4 u_normalTransform;
varying vec4 v_color;
varying vec3 v_normal;

uniform bool u_ignoreLighting;

void main()
{

    vec3 d_lightPos = normalize(vec3(0.0, 500.0, 50.0)) * 0.25;
    vec3 diffuseLight = vec3(1.0, 1.0, 1.0);
    vec3 ambientLight = vec3(0.3, 0.3, 0.5);
    vec3 lightPos = vec3(0.0, 6.0, -5.0);

    v_normal = mat3(u_normalTransform) * a_normal;
    gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * a_position;
    gl_PointSize = 10.0;

    vec4 vertexPosition = u_modelMatrix * a_position;
    vec3 lightDirection = normalize(lightPos - vec3(vertexPosition));
    vec3 viewDirection = normalize(u_viewWorldPos - vec3(vertexPosition));
    vec3 halfVector = normalize(lightDirection + viewDirection);

    float d_lightEffect = max(dot(d_lightPos, v_normal), 0.0);
    float specular = max(dot(halfVector, v_normal), 0.0) * 2.5;
    float dotLight = max(dot(lightDirection, v_normal), 0.0) * 25.5;

    vec3 diffuse = diffuseLight * a_color.rgb * dotLight;
    vec3 ambient = ambientLight * a_color.rgb;
    vec3 d_light = d_lightEffect * a_color.rgb;

    v_color = vec4(d_light + diffuse + ambient, 1.0);
    v_color += specular;



}