%{
#include <stdlib.h>
#include <stdio.h>
#include "bison.tab.h" // Get tokens from bison
#include <string.h>
%}

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
DIGIT [0-9]
NONZERODIGIT [1-9]
DECINTEGER {NONZERODIGIT}{DIGIT}*|"0"
SHORTSTRINGITEM	([^\n\'\"\\])|([\\].)
SHORTSTRING	([']{SHORTSTRINGITEM}*['])|(["]{SHORTSTRINGITEM}*["])
NEWLINE \n

%option noyywrap
%option yylineno
%x C_COMMENT

%%

^[ ]*\n	       		{/* Ignore blank lines. */ ;} 			
^[\t]*\n       		{/* Ignore blank lines. */ ;}
[%].*				{ /*Ignore comments*/}
"PROGRAM"           {return PROGRAM;}
"STARTMAIN"         {return STARTMAIN;}
"ENDMAIN"           {return ENDMAIN;}
"STRUCT"            {return STRUCT;}
"ENDSTRUCT"         {return ENDSTRUCT;}
"TYPEDEF"           {return TYPEDEF;}
"FUNCTION"			{return FUNCTION;}
"RETURN"            {return RETURN;}
"END_FUNCTION"      {return ENDFUNCTION;}
"VARS"              {return VARS;}
"INTEGER"           {return INTEGER;}
"CHAR"              {return CHAR;}
"IF" 			    {return IF;}
"THEN"              {return THEN;}
"ELSEIF"			{return ELSEIF;}
"ELSE"			    {return ELSE;}
"ENDIF"             {return ENDIF;}
"WHILE"             {return WHILE;}
"ENDWHILE"          {return ENDWHILE;}
"FOR"               {return FOR;}
"TO"                {return TO;}
"STEP"              {return STEP;}
"ENDFOR"            {return ENDFOR;}
"SWITCH"            {return SWITCH;}
"CASE"              {return CASE;}
"DEFAULT"           {return DEFAULT;}
"ENDSWITCH"         {return ENDSWITCH;}
"AND"               {return AND;}
"OR"                {return OR;}
"BREAK"             {return BREAK;}
"PRINT"             {return PRINT;}
";"			        {return SCOL;}
","			        {return COMMA;}
":"			        {return COL;}
"="			        {return EQ;}
"("			        {return LPAR;}
")"			        {return RPAR;}
"["			        {return LBRAK;}
"]"			        {return RBRAK;}
"-"			        {return MINUS;}
"+"			        {return PLUS;}
"<"			        {return LT;}
">"			        {return GT;}
"*"			        {return STAR;}
"/"			        {return SLASH;}
"=="			    {return EQ_OP;}
"!="			    {return NE_OP;}
"^"					{return POW;}
"\n"          		{}
"/*"            	{ BEGIN(C_COMMENT); }
<C_COMMENT>"*/" 	{ BEGIN(INITIAL); }
<C_COMMENT>.    	{ }

{IDENTIFIER} {
	strcpy(yylval.item.name, yytext);
	yylval.item.type = IDENT;
	yylval.item.data_type = LITERAL;
	return IDENTIFIER;
	}

{DECINTEGER} {
	yylval.item.ival = atoi(yytext);
	yylval.item.type = INT;
	yylval.item.data_type = LITERAL;
	return DECINTEGER;
	}

{SHORTSTRING} {
	if(strlen(yytext) > 3)
	{
		strcpy(yylval.item.string, yytext);
		yylval.item.type = STRING;
		yylval.item.data_type = LITERAL;
		return SHORTSTRING;
		}
	else {
		strcpy(yylval.item.string, yytext);
		yylval.item.type = CHARACT;
		yylval.item.data_type = LITERAL;
		return CHARACTER;
	}
}
%%