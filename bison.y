%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// FLEX stuff:
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int yylineno;
extern int yywrap;
void yyerror(const char *s);

%}

%code requires {
#include "helper.h"
struct Array variables;
struct Array functions;
struct Array structures;
}

%union
{ struct Variable item; }

%token PROGRAM STARTMAIN ENDMAIN 
%token STRUCT ENDSTRUCT TYPEDEF
%token FUNCTION RETURN ENDFUNCTION
%token VARS INTEGER CHAR
%token IF THEN ELSEIF ELSE ENDIF
%token WHILE ENDWHILE FOR TO STEP ENDFOR
%token SWITCH CASE DEFAULT ENDSWITCH
%token BREAK PRINT
%token COL SCOL COMMA LPAR RPAR RBRAK LBRAK
%token EQ PLUS MINUS STAR SLASH POW
%token AND OR LT GT EQ_OP NE_OP

%left PLUS MINUS
%left STAR SLASH
%left POW
%left LPAR RPAR

%token<item> CHARACTER
%token<item> DECINTEGER
%token<item> IDENTIFIER
%token<item> SHORTSTRING
%type<item> identifier
%type<item> integer
%type<item> character
%type<item> literal
%type<item> string
%type<item> print_input

%%
// ---------- Πρόγραμμα
program: PROGRAM IDENTIFIER struct_decl func_decl main {printf("Source code has no syntax errors!\n");};

// ---------- Κυρίως πρόγραμμα
main: STARTMAIN var_decl commands ENDMAIN;

// ---------- Δομή
struct_decl: | struct struct_decl;
struct: STRUCT IDENTIFIER VARS vars_list ENDSTRUCT
      | TYPEDEF STRUCT IDENTIFIER VARS vars_list IDENTIFIER ENDSTRUCT;

// ---------- Συναρτήσεις
func_decl: | func_list;
func_list: function | func_list function;
function: FUNCTION IDENTIFIER LPAR parameters RPAR var_decl commands RETURN return ENDFUNCTION
            {$2.type=FUN; insertArray(&functions,$2);};

return: expression_list SCOL;

// ---------- Παράμετροι συναρτήσεων
parameters: | parameter_list;
parameter_list: type variable | type variable COMMA parameter_list;

// ---------- Μεταβλητές
var_decl: | VARS vars_list;
vars_list: type vars SCOL | type vars SCOL vars_list;
vars: variable | variable COMMA vars;
variable: IDENTIFIER | IDENTIFIER LBRAK INTEGER RBRAK;

type: INTEGER | CHAR;
string: SHORTSTRING {$$ = $1;};

literal: integer {$$ = $1;}
      | character {$$ = $1;}
      | MINUS integer {$$ = $2;};

character: CHARACTER {$$ = $1;};
integer: DECINTEGER {$$ = $1;};
identifier: IDENTIFIER {$$ = $1;};

// ---------- Μαθηματικοί-Λογικοί τελεστές
log_op: AND | OR | GT | LT | EQ_OP | NE_OP;
math_op: PLUS | MINUS | POW | STAR | SLASH;

// ---------- Εντολές Προγράμματος ----------
commands: | list_of_cmds;
list_of_cmds: command | command list_of_cmds;
command: assign | loop | branch | print | break | func_call;

// ---------- Ανάθεση
assign: IDENTIFIER EQ expression_list SCOL;
expression_list: expression | expression math_op expression_list;
expression: literal | IDENTIFIER | func_call;

// ---------- Κλήση συνάρτησης
func_call: identifier LPAR call_params RPAR SCOL{checkDefinition($1,&functions);};
call_params: | variable | literal;

// ---------- Εντολές βρόχου
loop: WHILE LPAR condition RPAR commands ENDWHILE
      | FOR LPAR for_start TO for_target STEP for_target RPAR commands ENDFOR;
for_start: | IDENTIFIER EQ INTEGER;
for_target: | INTEGER;

// ---------- Τερματισμός βρόχου
break: BREAK SCOL;

// ---------- Εντολές ελέγχου
branch: IF LPAR condition RPAR THEN commands if_commands ENDIF
      | SWITCH LPAR sw_checks RPAR sw_cases ENDSWITCH;

if_commands: | ELSEIF LPAR condition RPAR THEN commands if_commands
            | ELSE commands;

sw_checks: sw_check | sw_check math_op sw_checks;
sw_check: literal | IDENTIFIER | func_call;
sw_cases: sw_default | sw_case | sw_case sw_cases;
sw_case: CASE LPAR sw_expr RPAR COL commands;
sw_expr: literal | literal math_op sw_expr;
sw_default: DEFAULT COL commands;

// ---------- Συνθήκη ελέγχου
condition: comparable log_op comparable;
comparable: IDENTIFIER | literal | comparable math_op comparable | comparable log_op comparable;

// ---------- Εντολή εκτύπωσης στην οθόνη
print:
      PRINT LPAR string RPAR SCOL
      { struct Variable empty; empty.type=FUN; print($3.string,empty, &variables);}
      |PRINT LPAR string COMMA LBRAK print_input RBRAK RPAR SCOL
      {print($3.string,$6, &variables);};

print_input: identifier {$$ = $1;}
      |integer {$$ = $1;}
      |character {$$ = $1;}
      |string {$$ = $1;};

%%

// 
int main(int argc, char** argv) {
      initArray(&variables, 5);
      initArray(&functions, 5);
      initArray(&structures, 5);

      // For debugging
      //extern int yydebug;
      //yydebug = 1;

      // Open file 
      FILE *myfile = fopen(argv[1], "r");

      //if it doesn't exist
      if (!myfile) return -1;

      // read file
      yyin = myfile;

      yyparse();
}

void yyerror(const char* s) {
	fprintf(stderr, "Error on line: %d\n", yylineno);
	exit(0);
}