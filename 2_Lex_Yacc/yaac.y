%debug
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define YYSTYPE structure
typedef union {
    int ival;
    char cval;
    char *sval;
} YYSTYPE;

#define YYSTYPE YYSTYPE
extern FILE *yyin;

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int ival;
    char cval;
    char *sval;
}

%token ANTONELGRAM LIGHTS_OUT CHECKERED_FLAG INT CHAR STRING BUNDLE BOOL OF ASSIGNMENT RE WR BEGIN_BLOCK END IFTRY THEN ELSETRY WHILE DO FOR TO LESS LESS_EQUAL EQUAL NOT_EQUAL GREATER_EQUAL GREATER PLUS MINUS TIMES DIVIDE AT IDENTIFIER_NUMBER CONSTANT_NUMBER CHARACTER_LITERAL STRING_LITERAL MOD IDENTIFIER_WITH_AT

%left PLUS MINUS
%left TIMES DIVIDE MOD
%nonassoc THEN
%nonassoc ELSETRY /* Precedence for dangling else */

%%
program:
    ANTONELGRAM IDENTIFIER_NUMBER ';' declist LIGHTS_OUT stmtlist CHECKERED_FLAG
    {
        printf("Program syntactic correct\n");
    };

declist:
    declaration
    | declaration ';' declist
    {
        printf("Declist processed\n");
    };

declaration:
    type IDENTIFIER_NUMBER
    | BUNDLE '[' CONSTANT_NUMBER ']' OF type IDENTIFIER_NUMBER
    {
        printf("Declaration processed\n");
    };

type:
    INT
    | CHAR
    | STRING
    | BUNDLE
    | BOOL
    {
        printf("Type processed\n");
    };

stmtlist:
    stmt
    | stmtlist stmt
    {
        printf("Stmtlist processed\n");
    };

stmt:
    simplstmt
    | structstmt
    {
        printf("Stmt processed\n");
    };

simplstmt:
    assignstmt
    | iostmt
    {
        printf("Simplstmt processed\n");
    };

assignstmt:
    IDENTIFIER_NUMBER ASSIGNMENT expression
    {
        printf("Assignstmt processed\n");
    };

iostmt:
    RE '(' IDENTIFIER_NUMBER ')'
    | WR '(' IDENTIFIER_NUMBER ')'
    {
        printf("Iostmt processed\n");
    };

structstmt:
    ifstmt
    | whilestmt
    | forstmt
    {
        printf("Structstmt processed\n");
    };

ifstmt:
    IFTRY condition THEN stmt %prec THEN
    | IFTRY condition THEN stmt ELSETRY stmt
    {
        printf("Ifstmt processed\n");
    };

whilestmt:
    WHILE condition DO stmtlist END
    {
        printf("Whilestmt processed\n");
    };

forstmt:
    FOR IDENTIFIER_NUMBER ASSIGNMENT expression TO expression DO stmtlist END
    {
        printf("Forstmt processed\n");
    };

condition:
    expression relation expression
    {
        printf("Condition processed\n");
    };

relation:
    LESS
    | LESS_EQUAL
    | EQUAL
    | NOT_EQUAL
    | GREATER_EQUAL
    | GREATER
    {
        printf("Relation processed\n");
    };

expression:
    expression PLUS term
    | expression MINUS term
    | expression MOD term
    | term
    {
        printf("Expression processed\n");
    };

term:
    term TIMES factor
    | term DIVIDE factor
    | factor
    {
        printf("Term processed\n");
    };

factor:
    '(' expression ')'
    | IDENTIFIER_NUMBER
    | CONSTANT_NUMBER
    | CHARACTER_LITERAL
    | STRING_LITERAL
    {
        printf("Factor processed\n");
    };

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error lmao: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file; // Redirect input to the file
    }

    if (yyparse() == 0) {
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }

    return 0;
}
