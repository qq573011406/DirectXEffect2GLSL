#include<iostream>
#include "hlsl2glsl.h"

int main(int argc,char** argv)
{
	ShHandle parser = Hlsl2Glsl_ConstructCompiler(EShLangVertex);
    std::cout<<"hello world!"<<std::endl;
    return 0;
}