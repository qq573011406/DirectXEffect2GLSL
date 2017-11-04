Unifroms
{
	bool g_bEnableFog:fogenable;
	vec4 g_fogColor:fogColor;
	vec4 g_fogParam:fogparameters;
	vec4 light_params:ConstVector0;
	mat4 mWorld:world;
	mat4 mWorldViewProj:worldviewprojection;
	vec3 sun_vec:sunvector;

}
#CODEBLOCK_BEGIN

struct SimpleVSOut {
    vec4 pos;
};
struct vertexData {
    vec4 pos;
    vec3 Norm;
    vec4 color;
    vec4 color2;
    vec2 texcoord;
};
uniform mat4 mWorldViewProj;
uniform vec4 light_params;
uniform vec3 sun_vec;
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
uniform vec4 g_fogColor;
uniform mat4 mWorld;
SimpleVSOut SimpleMainVS( in vertexData vsin ) {
    SimpleVSOut xlat_varoutput;
    float test_a = vsin.color.x;
    float test_b = vsin.color.z;
    xlat_varoutput.pos = (mWorldViewProj * vsin.pos);
    return xlat_varoutput;
}
attribute vec4 a_position;
attribute vec3 a_normal;
attribute vec4 a_color;
attribute vec4 a_color2;
attribute vec2 a_texCoord;
void main() {
    SimpleVSOut xl_retval;
    vertexData xlt_vsin;
    xlt_vsin.pos = vec4(a_position);
    xlt_vsin.Norm = vec3(a_normal);
    xlt_vsin.color = vec4(a_color.bgra);
    xlt_vsin.color2 = vec4(a_color2.bgra);
    xlt_vsin.texcoord = vec2(a_texCoord);
    xl_retval = SimpleMainVS( xlt_vsin);
    gl_Position = vec4(xl_retval.pos);
}

#CODEBLOCK_END SimpleMainVS


#CODEBLOCK_BEGIN

struct SimpleVSOut {
    vec4 pos;
};
struct vertexData {
    vec4 pos;
    vec3 Norm;
    vec4 color;
    vec4 color2;
    vec2 texcoord;
};
uniform mat4 mWorldViewProj;
uniform vec4 light_params;
uniform vec3 sun_vec;
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
uniform vec4 g_fogColor;
uniform mat4 mWorld;
vec4 SimpleMainPS( in SimpleVSOut xlat_varinput ) {
    return vec4( 1.0, 0.0, 0.0, 1.0);
}
void main() {
    vec4 xl_retval;
    SimpleVSOut xlt_xlat_varinput;
    xlt_xlat_varinput.pos = vec4(0.0);
    xl_retval = SimpleMainPS( xlt_xlat_varinput);
    gl_FragData[0] = vec4(xl_retval);
}

#CODEBLOCK_END SimpleMainPS



technique SimpleMesh_vs20_ps20
{
	pass P0
	{
		VertexShader = compile vs SimpleMainVS();
		PixelShader = compile ps SimpleMainPS();
	}
}
