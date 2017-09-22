#include "HLSLParser.h"
#include "GLSLGenerator.h"
#include "HLSLGenerator.h"


#include<iostream>
#include <fstream>
#include <sstream>
#include <string>



std::string ReadFile(const char* fileName)
{
	std::ifstream ifs(fileName);
	std::stringstream buffer;
	buffer << ifs.rdbuf();
	return buffer.str();
}


int hlsl2glsl(const std::string& input, const std::string output)
{
    
    std::cout<<"Hello world"<<std::endl;
	using namespace M4;

	std::string inputCode = ReadFile(input.c_str());


	Allocator allocator;
	HLSLParser parser(&allocator, input.c_str(), inputCode.data(), inputCode.size());
	HLSLTree tree(&allocator);
	if (!parser.Parse(&tree)) {
		std::cerr <<"Parsing failed, aborting"<<std::endl;
		return 1;
	}
	GLSLGenerator::Target target = GLSLGenerator::Target_VertexShader;
	GLSLGenerator generator;
	if (!generator.Generate(&tree, GLSLGenerator::Target(target), GLSLGenerator::Version_140, "VSMain")) {
		std::cerr << "Translation failed, aborting" << std::endl;
		return 1;
	}

	std::cout << generator.GetResult();

	//std::cout << "Iutput:================" << std::endl;
	//std::cout << inputCode << std::endl;



	return 0;
}

int main(int argc,char** argv)
{
	if (argc < 3)return -1;
	std::string inputPath = argv[1];
	std::string outputPath = argv[2];
	hlsl2glsl(inputPath, outputPath);
	std::cout << "done";
	std::getchar();
    return 0;
}

