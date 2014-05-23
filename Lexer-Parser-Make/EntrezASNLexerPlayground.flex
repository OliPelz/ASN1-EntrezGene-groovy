/* this is the scanner playground for my upcoming ASN1 Entrezgene parser
   it is for testing out the correct lexer flex which will later will be called  EntrezASNLexer*/
package de.oliverpelz;

import de.oliverpelz.data.*;
%%
  

%line
%char
%full
%public 
%class EntrezASNLexerPlayground
%state STRING

%debug

DICTKEY=[a-zA-Z][a-zA-Z0-9_-]+
MYWHITESPACES=\n[ ]*
NUMBER=[0-9]+
SINGLESPACE=[ ]
OPENBRACKET=[ ]*\{
CLOSINGBRAKET=[ ]*\}
COMMA=[ ]*\,

%% 

<YYINITIAL> {
  
  "Entrezgene ::= {" { return (new Yytoken(0, yytext(), yyline, yychar, yychar+yylength())); }
  \"	{ yybegin(STRING); }
  {MYWHITESPACES} {}  /*get rid of newlines and blanks at beginning of line*/
  {DICTKEY} { return (new Yytoken(1,yytext(),yyline,yychar,yychar+yylength())); }  
  {NUMBER} { return (new Yytoken(2,yytext(),yyline,yychar,yychar+yylength())); } 
  {SINGLESPACE} { return (new Yytoken(3,yytext(),yyline,yychar,yychar+yylength())); }
  {OPENBRACKET} { return (new Yytoken(4,yytext(),yyline,yychar,yychar+yylength())); }
  {CLOSINGBRAKET} { return (new Yytoken(5,yytext(),yyline,yychar,yychar+yylength())); }
  {COMMA } { return (new Yytoken(6,yytext(),yyline,yychar,yychar+yylength())); }
  
  
}
<STRING> {
  \"    { yybegin(YYINITIAL);}    //end of string
  [^\"]+ { return (new Yytoken(7,yytext(),yyline,yychar,yychar+yylength())); }
}  
. {
  System.out.println("Illegal character: >" + yytext() + "<");
	Utility.error(Utility.E_UNMATCHED);
}

