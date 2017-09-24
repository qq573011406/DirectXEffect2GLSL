add_library(hlslparser
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/CodeWriter.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/GLSLGenerator.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/HLSLGenerator.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/HLSLParser.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/HLSLTokenizer.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/HLSLTree.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/MSLGenerator.cpp"
"${PROJECT_SOURCE_DIR}/External/hlslparser/src/Engine.cpp")

add_library(cpp
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/token.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/ast.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/scope.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/type.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/cpp.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/error.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/scanner.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/parser.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/evaluator.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/code_gen.cc"
"${PROJECT_SOURCE_DIR}/External/wgtcc/src/encoding.cc"
)

add_executable(cpp_test "${PROJECT_SOURCE_DIR}/External/wgtcc/src/main.cc")
target_link_libraries(cpp_test cpp)