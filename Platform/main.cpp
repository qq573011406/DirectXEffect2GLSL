

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdio>
#include <cstdlib>




std::string ReadFile(const char* fileName)
{
	std::ifstream ifs(fileName);
	std::stringstream buffer;
	buffer << ifs.rdbuf();
	return buffer.str();
}


void printUsage()
{
	std::cout << "Usage:\n dx2gl <source file path>  <output dir>"<<std::endl;
	std::cout << "eg:\n dx2gl c:\\test.hlsl c:\\" << std::endl;
}

//
//bool preprocess(const std::string& hlslPath,std::string& out)
//{
//	
//	std::FILE* fin = fopen(hlslPath.c_str(), "r");
//	if (!fin) {
//		std::cerr << "Can't Open input file " << hlslPath << std::endl;
//		return false;
//	}
//
//	// out to tmp file
//	std::FILE* fout = std::tmpfile();
//	if (!fout) {
//		std::cerr << "Create temp file failed!" << hlslPath << std::endl;
//		return false;
//	}
//
//	cpp_execute(fin, fout);
//	std::fclose(fin);
//
//	long fsize = std::ftell(fout) + 1;
//	char* outBuffer = (char*)malloc(fsize * sizeof(char));
//	memset(outBuffer, 0, fsize * sizeof(char));
//	std::rewind(fout);
//	std::fread(outBuffer, sizeof(char), fsize-1, fout);
//	std::fclose(fout);
//
//	std::string ret = outBuffer;
//	free(outBuffer);
//	out = ret;
//
//	return true;
//}






int main(int argc,char** argv)
{
	if (argc < 3)
	{
		printUsage();
		return 0;
	}
	//std::string inputPath = argv[1];
	//std::string outputDir = argv[2];

	//std::string ppOut;
	//if (!preprocess(inputPath, ppOut)) return -1;

	//// Parse
	//using namespace M4;
	//Allocator allocator;
	//HLSLParser parser(&allocator,inputPath.c_str(), ppOut.data(), ppOut.size());
	//HLSLTree tree(&allocator);
	//if (!parser.Parse(&tree)) {
	//	std::cerr << "Parsing failed, aborting" << std::endl;
	//	return 1;
	//}
	//// export glsl


    return 0;
}

