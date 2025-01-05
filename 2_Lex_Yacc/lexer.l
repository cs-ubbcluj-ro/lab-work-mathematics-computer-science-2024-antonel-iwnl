%{
#include <stdio.h>
#include "yaac.tab.h"
#define YYDEBUG 1
%}

%%

"antonelgram"          { return ANTONELGRAM; }
"Lights out"           { return LIGHTS_OUT; }
"Checkered flag"       { return CHECKERED_FLAG; }
"int"                  { return INT; }
"char"                 { return CHAR; }
"string"               { return STRING; }
"bundle"               { return BUNDLE; }
"bool"                 { return BOOL; }
"of"                   { return OF; }
":="                   { return ASSIGNMENT; }
"="                    { return EQUAL; }
"mod"                  { return MOD; }
"re"                   { return RE; }
"wr"                   { return WR; }
"begin"                { return BEGIN_BLOCK; }
"end"                  { return END; }
"iftry"                { return IFTRY; }
"then"                 { return THEN; }
"elsetry"              { return ELSETRY; }
"while"                { return WHILE; }
"do"                   { return DO; }
"for"                  { return FOR; }
"to"                   { return TO; }
"<"                    { return LESS; }
"<="                   { return LESS_EQUAL; }
"<>"                   { return NOT_EQUAL; }
">="                   { return GREATER_EQUAL; }
">"                    { return GREATER; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return TIMES; }
"/"                    { return DIVIDE; }
"("                    { return '('; }
")"                    { return ')'; }
"@"                    { return AT; }
";"                    { printf("Token SEMICOLON: ;\n"); return ';'; }
[a-zA-Z_ĂÂÎȚȘ@][a-zA-Z0-9_ĂÂÎȚȘ@]* { printf("Token IDENTIFIER: %s\n", yytext); yylval.sval = strdup(yytext); return IDENTIFIER_NUMBER; }
[0-9]+                 { printf("Token CONSTANT_NUMBER: %s\n", yytext); yylval.ival = atoi(yytext); return CONSTANT_NUMBER; }
\'[^\']\'              { printf("Token CHARACTER_LITERAL: %s\n", yytext); yylval.cval = yytext[1]; return CHARACTER_LITERAL; }
\"[^\"]*\"             { printf("Token STRING_LITERAL: %s\n", yytext); yylval.sval = strdup(yytext); return STRING_LITERAL; }
"//".*                 { /* Ignore comments */ }
[ \t\r\n]+ { /* Skip whitespace */ }
. { printf("Unknown token: '%s' (ASCII: %d)\n", yytext, yytext[0]); }

%%

int yywrap() {
    return 1;
}
