

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdio>
#include <cstdlib>


#include "hlsl2glsl.h"

std::string ReadFile(const char* fileName)
{
	std::ifstream ifs(fileName);
	if (!ifs)return "";
	std::stringstream buffer;
	buffer << ifs.rdbuf();
	return buffer.str();
}


void printUsage()
{
	std::cout << "Usage:\n dx2gl <source file path>  <output dir>"<<std::endl;
	std::cout << "eg:\n dx2gl c:\\test.hlsl c:\\" << std::endl;
}

struct IncludeContext
{
	std::string currentFolder;
};

static bool C_DECL IncludeOpenCallback(bool isSystem, const char* fname, const char* parentfname, const char* parent, std::string& output, void* d)
{
	const IncludeContext* data = reinterpret_cast<IncludeContext*>(d);

	std::string pathName = data->currentFolder + "/" + fname;

	output = ReadFile(pathName.c_str());
	return true;
}

static std::string GetCompiledShaderText(ShHandle parser)
{
	std::string txt = Hlsl2Glsl_GetShader(parser);

	int count = Hlsl2Glsl_GetUniformCount(parser);
	if (count > 0)
	{
		const ShUniformInfo* uni = Hlsl2Glsl_GetUniformInfo(parser);
		txt += "\n// uniforms:\n";
		for (int i = 0; i < count; ++i)
		{
			char buf[1000];
			snprintf(buf, 1000, "// %s:%s type %d arrsize %d", uni[i].name, uni[i].semantic ? uni[i].semantic : "<none>", uni[i].type, uni[i].arraySize);
			txt += buf;

			if (uni[i].registerSpec)
			{
				txt += " register ";
				txt += uni[i].registerSpec;
			}

			txt += "\n";
		}
	}

	return txt;
}


int main(int argc,char** argv)
{
	//if (argc < 2)
	//{
	//	printUsage();
	//	return 0;
	//}
	std::string inputPath = "e:/test.hlsl";
	std::string outputDir = "e:/test.glsl";


	Hlsl2Glsl_Initialize();

	std::string input = ReadFile(inputPath.c_str());

	ShHandle parser = Hlsl2Glsl_ConstructCompiler(EShLangFragment);

	// Include
	IncludeContext includeCtx;
	includeCtx.currentFolder = inputPath.substr(0, inputPath.rfind('/'));
	Hlsl2Glsl_ParseCallbacks includeCB;
	includeCB.includeOpenCallback = IncludeOpenCallback;
	includeCB.includeCloseCallback = NULL;
	includeCB.data = &includeCtx;

	// Parse
	const char* sourceStr = input.c_str();
	const char* infoLog = nullptr;
	int parseOk = Hlsl2Glsl_Parse(parser, sourceStr, ETargetGLSL_140, &includeCB, 0);
	if (!parseOk) {
		infoLog = Hlsl2Glsl_GetInfoLog(parser);
	}
	int translateOk = Hlsl2Glsl_Translate(parser, "TransparentMainPS", ETargetGLSL_140, 0);
	if (!translateOk) {
		infoLog = Hlsl2Glsl_GetInfoLog(parser);
	}

	std::string out = GetCompiledShaderText(parser);
	std::cout << out << std::endl;

	Hlsl2Glsl_Shutdown();

    return 0;
}

