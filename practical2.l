%{
#include <stdio.h>
#include <string.h>

int lineCount = 0, spaceCount = 0, tabCount = 0, wordCount = 0, characterCount = 0;
int commentCount = 0, keywordCount = 0, identifierCount = 0;

char *keywords[] = {
    "auto","break","case","char","const","continue","default","do","double",
    "else","enum","extern","float","for","goto","if","int","long","register",
    "return","short","signed","sizeof","static","struct","switch","typedef",
    "union","unsigned","void","volatile","while"
};

int isKeyword(const char *word) {
    for(int i=0; i<sizeof(keywords)/sizeof(keywords[0]); i++)
        if(strcmp(word, keywords[i]) == 0)
            return 1;
    return 0;
}
%}

%%
"/*"([^*]|\*+[^*/])*\*+"/"      { commentCount++; characterCount += yyleng; }

"//".*                         { commentCount++; characterCount += yyleng; }

" "                            { spaceCount++;  characterCount++; }
"\t"                           { tabCount++;    characterCount++; }

[a-zA-Z_][a-zA-Z0-9_]*         {  
                                 wordCount++;  
                                 characterCount += yyleng;
                                 if (isKeyword(yytext)) keywordCount++;
                                 else identifierCount++;
                               }

\n                             { lineCount++; characterCount++; }

.                              { characterCount++; }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter code (Ctrl+D to end):\n");
    yylex();

    printf("\nLines       : %d\n", lineCount);
    printf("Spaces      : %d\n", spaceCount);
    printf("Tabs        : %d\n", tabCount);
    printf("Words       : %d\n", wordCount);
    printf("Characters  : %d\n", characterCount);
    printf("Comments    : %d\n", commentCount);
    printf("Keywords    : %d\n", keywordCount);
    printf("Identifiers : %d\n", identifierCount);
}
