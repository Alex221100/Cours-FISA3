%{ 
    #include <stdio.h>
%}

%%
courrir |
etre |
marcher |
avoir |
manger    { printf("%s est un verbe \n", yytext); }
Dupont |
Durand     {  printf("%s est un nom\n", yytext); }
[a-zA-Z]+ {printf("%s est inconnu\n", yytext);}
. |
\n;
%%

yywrap() {
    exit(0);
}

int main() {
    yylex();

    return 0;
}
