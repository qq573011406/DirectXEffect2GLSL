Unifroms
{
	vec4 g_fogColor:fogColor;
	vec4 g_fogParam:fogparameters;
	vec4 light_params:ConstVector0;
	mat4 mWorldViewProj:worldviewprojection;
	vec3 sun_vec:sunvector;
	smapler2D tex0Sampler;

}
#CODEBLOCK_BEGIN
#version 140
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 124
float CalcFogFactor( in float d ) {
    #line 128
    float fogCoeff = 0.0;
    fogCoeff = ((d - g_fogParam.x) / g_fogParam.y);
    #line 134
    return clamp( fogCoeff, 0.0, 1.0);
}
#line 150
SimpleVSOut SimpleMainVS( in vec4 pos, in vec3 Norm, in vec4 color, in vec4 color2, in vec2 texcoord ) {
    #line 154
    SimpleVSOut xlat_varoutput;
    xlat_varoutput.pos = (pos * mWorldViewProj);
    #line 158
    xlat_varoutput.texcoord = texcoord;
    #line 164
    float torch_light_strength = color.y;
    vec3 torch_light = (light_params.xyz * torch_light_strength);
    #line 172
    float sun_light_strength = clamp( (color.x * light_params.w), 0.0, 1.0);
    #line 176
    float lightFactor = (0.7 + (0.3 * xll_saturate_f(dot( sun_vec, Norm))));
    vec3 sun_light = ((vec3( 1.0, 1.0, 1.0) + (g_fogColor.xyz * 0.05)) * (sun_light_strength * lightFactor));
    #line 180
    torch_light_strength *= lightFactor;
    #line 186
    vec3 final_light = mix( (torch_light.xyz + sun_light.xyz), sun_light.xyz, vec3( (sun_light_strength / ((torch_light_strength + sun_light_strength) + 0.001))));
    #line 194
    xlat_varoutput.color.xyz = (final_light * color.w);
    xlat_varoutput.color.xyz *= color2.xyz;
    #line 202
    xlat_varoutput.color.w = CalcFogFactor( length(xlat_varoutput.pos.xyz));
    return xlat_varoutput;
}
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_COLOR0;
void main() {
    SimpleVSOut xl_retval;
    xl_retval = SimpleMainVS( vec4(gl_Vertex), vec3(gl_Normal), vec4(gl_Color), vec4(gl_SecondaryColor), vec2(gl_MultiTexCoord0));
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_COLOR0 = vec4(xl_retval.color);
}

#CODEBLOCK_END SimpleMainVS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 272
vec4 SimpleMainPS( in SimpleVSOut xlat_varinput ) {
    #line 276
    vec4 albedoColor = texture( tex0Sampler, xlat_varinput.texcoord);
    #line 280
    vec4 oColor = vec4( mix( (albedoColor.xyz * xlat_varinput.color.xyz), g_fogColor.xyz, vec3( xlat_varinput.color.w)), albedoColor.w);
    return oColor;
}
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_COLOR0;
void main() {
    vec4 xl_retval;
    SimpleVSOut xlt_xlat_varinput;
    xlt_xlat_varinput.pos = vec4(0.0);
    xlt_xlat_varinput.texcoord = vec2(xlv_TEXCOORD0);
    xlt_xlat_varinput.color = vec4(xlv_COLOR0);
    xl_retval = SimpleMainPS( xlt_xlat_varinput);
    gl_FragData[0] = vec4(xl_retval);
}

#CODEBLOCK_END SimpleMainPS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 318
SelectBlockVSOut SelectBlockVS( in vec4 pos, in vec2 texcoord ) {
    #line 322
    SelectBlockVSOut result;
    result.pos = (pos * mWorldViewProj);
    #line 326
    result.texcoord = texcoord;
    return result;
}
varying vec2 xlv_TEXCOORD0;
void main() {
    SelectBlockVSOut xl_retval;
    xl_retval = SelectBlockVS( vec4(gl_Vertex), vec2(gl_MultiTexCoord0));
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
}

#CODEBLOCK_END SelectBlockVS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 334
vec4 SelectBlockPS( in SelectBlockVSOut xlat_varinput ) {
    #line 338
    vec4 color = texture( tex0Sampler, xlat_varinput.texcoord);
    #line 342
    color.xyz *= light_params.x;
    color.w = 1.0;
    #line 346
    return color;
}
varying vec2 xlv_TEXCOORD0;
void main() {
    vec4 xl_retval;
    SelectBlockVSOut xlt_xlat_varinput;
    xlt_xlat_varinput.pos = vec4(0.0);
    xlt_xlat_varinput.texcoord = vec2(xlv_TEXCOORD0);
    xl_retval = SelectBlockPS( xlt_xlat_varinput);
    gl_FragData[0] = vec4(xl_retval);
}

#CODEBLOCK_END SelectBlockPS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 318
SelectBlockVSOut SelectBlockVS( in vec4 pos, in vec2 texcoord ) {
    #line 322
    SelectBlockVSOut result;
    result.pos = (pos * mWorldViewProj);
    #line 326
    result.texcoord = texcoord;
    return result;
}
varying vec2 xlv_TEXCOORD0;
void main() {
    SelectBlockVSOut xl_retval;
    xl_retval = SelectBlockVS( vec4(gl_Vertex), vec2(gl_MultiTexCoord0));
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
}

#CODEBLOCK_END SelectBlockVS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 352
vec4 DamagedBlockPS( in SelectBlockVSOut xlat_varinput ) {
    #line 356
    vec4 color;
    color = texture( tex0Sampler, xlat_varinput.texcoord);
    #line 362
    return color;
}
varying vec2 xlv_TEXCOORD0;
void main() {
    vec4 xl_retval;
    SelectBlockVSOut xlt_xlat_varinput;
    xlt_xlat_varinput.pos = vec4(0.0);
    xlt_xlat_varinput.texcoord = vec2(xlv_TEXCOORD0);
    xl_retval = DamagedBlockPS( xlt_xlat_varinput);
    gl_FragData[0] = vec4(xl_retval);
}

#CODEBLOCK_END DamagedBlockPS


#CODEBLOCK_BEGIN
#version 140

#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 124
float CalcFogFactor( in float d ) {
    #line 128
    float fogCoeff = 0.0;
    fogCoeff = ((d - g_fogParam.x) / g_fogParam.y);
    #line 134
    return clamp( fogCoeff, 0.0, 1.0);
}
#line 220
SimpleVSOut TransparentSimpleMainVS( in vec4 pos, in vec3 Norm, in vec4 color, in vec4 color2, in vec2 texcoord ) {
    #line 224
    SimpleVSOut xlat_varoutput;
    xlat_varoutput.pos = (pos * mWorldViewProj);
    #line 228
    xlat_varoutput.texcoord = texcoord;
    #line 234
    float torch_light_strength = color.y;
    vec3 torch_light = (light_params.xyz * torch_light_strength);
    #line 242
    float sun_light_strength = clamp( (color.x * light_params.w), 0.0, 1.0);
    vec3 sun_light = ((vec3( 1.0, 1.0, 1.0) + (g_fogColor.xyz * 0.05)) * sun_light_strength);
    #line 250
    vec3 final_light = mix( (torch_light.xyz + sun_light.xyz), sun_light.xyz, vec3( (sun_light_strength / ((torch_light_strength + sun_light_strength) + 0.001))));
    #line 258
    xlat_varoutput.color.xyz = (final_light * color.w);
    xlat_varoutput.color.xyz *= color2.xyz;
    #line 264
    xlat_varoutput.color.w = CalcFogFactor( length(xlat_varoutput.pos.xyz));
    return xlat_varoutput;
}
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_COLOR0;
void main() {
    SimpleVSOut xl_retval;
    xl_retval = TransparentSimpleMainVS( vec4(gl_Vertex), vec3(gl_Normal), vec4(gl_Color), vec4(gl_SecondaryColor), vec2(gl_MultiTexCoord0));
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_COLOR0 = vec4(xl_retval.color);
}

#CODEBLOCK_END TransparentSimpleMainVS


#CODEBLOCK_BEGIN
#version 140
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
#line 76
struct SimpleVSOut {
    vec4 pos;
    vec2 texcoord;
    vec4 color;
};
#line 102
struct SelectBlockVSOut {
    vec4 pos;
    vec2 texcoord;
};
#line 32
uniform mat4 mWorldViewProj;
#line 40
uniform vec4 light_params;
uniform vec3 sun_vec;
#line 46
uniform bool g_bEnableFog;
uniform vec4 g_fogParam;
#line 50
uniform vec4 g_fogColor;
uniform mat4 mWorld;
#line 58
uniform sampler tex0Sampler;
#line 124
#line 150
#line 220
#line 272
#line 288
#line 318
#line 334
#line 352
#line 288
vec4 TransparentMainPS( in SimpleVSOut xlat_varinput ) {
    #line 292
    vec4 albedoColor = texture( tex0Sampler, xlat_varinput.texcoord);
    xll_clip_f((albedoColor.w - 0.95));
    #line 296
    vec4 oColor = vec4( mix( (albedoColor.xyz * xlat_varinput.color.xyz), g_fogColor.xyz, vec3( xlat_varinput.color.w)), albedoColor.w);
    return oColor;
}
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_COLOR0;
void main() {
    vec4 xl_retval;
    SimpleVSOut xlt_xlat_varinput;
    xlt_xlat_varinput.pos = vec4(0.0);
    xlt_xlat_varinput.texcoord = vec2(xlv_TEXCOORD0);
    xlt_xlat_varinput.color = vec4(xlv_COLOR0);
    xl_retval = TransparentMainPS( xlt_xlat_varinput);
    gl_FragData[0] = vec4(xl_retval);
}

#CODEBLOCK_END TransparentMainPS



technique SimpleMesh_vs20_ps20
{
	pass P0
	{
		VertexShader = compile vs SimpleMainVS();
		PixelShader = compile ps SimpleMainPS();
		FogEnable = FALSE;
	}
	pass P1
	{
		VertexShader = compile vs SelectBlockVS();
		PixelShader = compile ps SelectBlockPS();
		FogEnable = FALSE;
	}
	pass P2
	{
		VertexShader = compile vs SelectBlockVS();
		PixelShader = compile ps DamagedBlockPS();
		FogEnable = FALSE;
	}
	pass P3
	{
		VertexShader = compile vs TransparentSimpleMainVS();
		PixelShader = compile ps TransparentMainPS();
		FogEnable = FALSE;
	}
}
