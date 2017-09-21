#include<iostream>
#include <fstream>
#include <sstream>
#include <string>
#include "hlsl2glsl.h"

struct IncludeContext
{
	std::string currentFolder;
};
bool ReadStringFromFile(const std::string path, std::string& output)
{
	try
	{
		using namespace std;
		ifstream fsInput;
		fsInput.open(path, ios::in);
		std::stringstream vInput;
		vInput << fsInput.rdbuf();
		output = vInput.str();
		return true;
	}
	catch (const std::exception&)
	{
		return false;
	}

}

static bool C_DECL IncludeOpenCallback(bool isSystem, const char* fname, const char* parentfname, const char* parent, std::string& output, void* d)
{
	const IncludeContext* data = reinterpret_cast<IncludeContext*>(d);

	std::string pathName = data->currentFolder + "/" + fname;
	return ReadStringFromFile(pathName.c_str(),output);
}




int hlsl2glsl(const std::string& input, const std::string output)
{
	std::string inputCode;
	ReadStringFromFile(input,inputCode);

	std::cout << "Iutput:================" << std::endl;
	std::cout << inputCode << std::endl;

	ShHandle parser = Hlsl2Glsl_ConstructCompiler(EShLanguage::EShLangFragment);
	const char* sourceStr = inputCode.c_str();

	ETargetVersion version = ETargetGLSL_140;
	unsigned int options = 0;

	IncludeContext includeCtx;
	includeCtx.currentFolder = input.substr(0, input.rfind('/'));
	Hlsl2Glsl_ParseCallbacks includeCB;
	includeCB.includeOpenCallback = IncludeOpenCallback;
	includeCB.includeCloseCallback = NULL;
	includeCB.data = &includeCtx;

	int parseOk = Hlsl2Glsl_Parse(parser, sourceStr, version, &includeCB, options);
	const char* infoLog = Hlsl2Glsl_GetInfoLog(parser);
	if (!parseOk) {
		std::cerr << "Parse failed:\n";
		std::cerr << infoLog << std::endl;
		return parseOk;
	}


	static EAttribSemantic kAttribSemantic[] = {
		EAttrSemTangent,
	};
	static const char* kAttribString[] = {
		"TANGENT",
	};
	Hlsl2Glsl_SetUserAttributeNames(parser, kAttribSemantic, kAttribString, 1);
	int translateOk = Hlsl2Glsl_Translate(parser, "SimpleMainPS", version, options);
	infoLog = Hlsl2Glsl_GetInfoLog(parser);

	std::string txt = Hlsl2Glsl_GetShader(parser);
	std::cout << "Output:================" << std::endl;
	std::cout << txt << std::endl;

	Hlsl2Glsl_DestructCompiler(parser);
	return 0;
}



int main(int argc,char** argv)
{
	if (argc < 3)return -1;
	Hlsl2Glsl_Initialize();
	std::string inputPath = argv[1];
	std::string outputPath = argv[2];
	hlsl2glsl(inputPath, outputPath);
	std::cout << "done";
	Hlsl2Glsl_Shutdown();
	std::getchar();
    return 0;
}

