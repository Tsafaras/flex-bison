/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_BISON_TAB_H_INCLUDED
# define YY_YY_BISON_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 16 "bison.y"

#include "helper.h"
struct Array variables;
struct Array functions;
struct Array structures;

#line 55 "bison.tab.h"

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROGRAM = 258,
    STARTMAIN = 259,
    ENDMAIN = 260,
    STRUCT = 261,
    ENDSTRUCT = 262,
    TYPEDEF = 263,
    FUNCTION = 264,
    RETURN = 265,
    ENDFUNCTION = 266,
    VARS = 267,
    INTEGER = 268,
    CHAR = 269,
    IF = 270,
    THEN = 271,
    ELSEIF = 272,
    ELSE = 273,
    ENDIF = 274,
    WHILE = 275,
    ENDWHILE = 276,
    FOR = 277,
    TO = 278,
    STEP = 279,
    ENDFOR = 280,
    SWITCH = 281,
    CASE = 282,
    DEFAULT = 283,
    ENDSWITCH = 284,
    BREAK = 285,
    PRINT = 286,
    COL = 287,
    SCOL = 288,
    COMMA = 289,
    LPAR = 290,
    RPAR = 291,
    RBRAK = 292,
    LBRAK = 293,
    EQ = 294,
    PLUS = 295,
    MINUS = 296,
    STAR = 297,
    SLASH = 298,
    POW = 299,
    AND = 300,
    OR = 301,
    LT = 302,
    GT = 303,
    EQ_OP = 304,
    NE_OP = 305,
    CHARACTER = 306,
    DECINTEGER = 307,
    IDENTIFIER = 308,
    SHORTSTRING = 309
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 24 "bison.y"
 struct Variable item; 

#line 124 "bison.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BISON_TAB_H_INCLUDED  */
