%{
#include <stdio.h>
%}

%%
.*com\n     { printf("Line ends with 'com' : %s", yytext); }
.*\n        { printf("Line does not end with 'com' : %s", yytext); }
%%

int main() {
    printf("Enter text (Ctrl+D to end):\n");
    yylex();
    return 0;
}

int yywrap() { return 1; }
