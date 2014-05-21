/* this is the scanner playground for my upcoming ASN1 Entrezgene parser
   (with small modifications to make it more readable) */
package de.oliverpelz;

import de.oliverpelz.data.*;
%%
  
	
%{
  private int comment_count = 0;
%} 

%line
%char
%state COMMENT
%full
%public 
%class EntrezASNLexer
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

