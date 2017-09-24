%option noyywrap
%{
#include "cpp.h"
#define YY_NO_UNISTD_H
#define M malloc
#define X yytext
#define A a=X
#define B(x) BEGIN x;
#define Y YY_CURRENT_BUFFER
*a,*b,**v,**V,**t,**T,i,s=1,o;
g(){t=M(++s);T=M(s);for(i=1;i<s-1;i++)t[i]=v[i],T[i]=V[i];free(v);free(V);v=t;V=T;}
f(){for(i=1;i<s;i++)if(!strcmp(v[i],a))return i;return 0;}
d(y){X[yyleng-y]=0;}
%}
%x D F I
N .*\n
%%
"//".*
"/*"([^\*]|\*[^\/])*"*/"
\"(\\.|[^\\"])*\" ECHO;
^"#include "\"[^\"]*\" d(1),yypush_buffer_state(yy_create_buffer(fopen(X+10,"r"),YY_BUF_SIZE));
^"#define "[^ ]* {B(D)strcpy(a=M(yyleng),X+8);}
<D>" "?{N} {b=M(yyleng);d(1);f(strcpy(b,X+(X[0]==32)))?free(V[i]),V[i]=b:g(),v[s-1]=a,V[s-1]=b;B(0)}
^"#undef "{N} d(1),v[f(A+7)][0]=0;
^"#if defined(".*")\n" h(2,12);
^"#ifdef "{N} h(1,7);
^"#if "{N} {d(1);if(!atoi(X+4))B(F)}
^"#ifndef "{N} {d(1);if(f(A+8))B(F)}
<F>^"#if"{N} o++;
<F>^"#endif"{N} if(!o--)B(++o)
<F>^"#else"{N} if(!o)B(0)
<F>^"#elif defined(".*")\n" if(!o){d(2);if(f(A+14))B(0)}
<F>^"#elif "{N} if(!o){d(1);if(atoi(X+6))B(0)}
<F>{N}
^"#endif"{N}
^"#el"("se"|"if"){N} B(I)
<I>^"#endif"{N} B(0)
<I>{N}
[a-zA-Z_][a-zA-Z_0-9]* fprintf(yyout,f(A)?V[i]:a);
<<EOF>> {a=Y;yypop_buffer_state();if(!Y)exit(0);fclose(a);}
%%
h(x,y){d(x);if(!f(A+y))B(F)}

int cpp_execute(FILE* input,FILE* output)
{
    yyset_in(input);
    yyset_out(output);
    yylex();
    return 0;
}

