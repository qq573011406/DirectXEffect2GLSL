

float4x4 mWorldViewProj : worldviewprojection;


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

struct vertexData
{
	float4 pos		: POSITION;
	float3	Norm	: NORMAL;
	half4 color		: COLOR0;
	half4 color2 : COLOR1;
	float2 texcoord	: TEXCOORD0;
};

SimpleVSOut SimpleMainVS(vertexData vsin)
{
	
	SimpleVSOut output;
	float test_a = vsin.color.x;
	float test_b = vsin.color.b;
	output.pos = mul(vsin.pos, mWorldViewProj);
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



