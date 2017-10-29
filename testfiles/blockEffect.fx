// Author: LiXizhi,Clayman

// Desc: 2013/6



#define ALPHA_TESTING_REF  0.95



/** undefine to use linear torch light, otherwise it is power */

// #define POWER_LIGHT_TORCH



#ifdef POWER_LIGHT_TORCH

	/** whether to torch lit small or bigger area */

	// #define LIGHT_TORCH_SMALL_RANGE

#endif



////////////////////////////////////////////////////////////////////////////////

//  Per frame parameters

float4x4 mWorldViewProj : worldviewprojection;



// for selection effect: light_params.x: sun_lightIntensity, light_params.y: damageDegree

// for block effect: light_params.xyz: light color, light_params.w light intensity

float4 light_params: ConstVector0; 

float3 sun_vec: sunvector;



bool g_bEnableFog		:fogenable;

float4   g_fogParam : fogparameters; // (fogstart, fogrange, fogDensity, reserved)

float4   g_fogColor : fogColor;

float4x4 mWorld: world;


struct SimpleVSOut
{
	float4 pos	:POSITION;
};



struct SelectBlockVertexLayout
{
	float4 pos	:POSITION;
	float2 texcoord	:TEXCOORD0;
};



struct SelectBlockVSOut
{
	float4 pos	:POSITION;
	float2 texcoord	:TEXCOORD0;
};
SimpleVSOut SimpleMainVS(	float4 pos		: POSITION,
							float2 texcoord	: TEXCOORD0,
							half4 color		: COLOR0,
							half4 color2 : COLOR1,
							float3	Norm	: NORMAL
)
{
	SimpleVSOut output;
	output.pos = mul(pos, mWorldViewProj);
	return output;
}



float4 SimpleMainPS(SimpleVSOut input) :COLOR0
{
	return float4(1,0,0,1);
}

technique SimpleMesh_vs20_ps20

{

	pass P0

	{

		VertexShader = compile vs_2_0 SimpleMainVS();

		PixelShader  = compile ps_2_0 SimpleMainPS();

	}

}



