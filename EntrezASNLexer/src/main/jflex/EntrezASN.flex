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

%debug

DICTKEY=[\w_-]
STRING="[\w_+\s]"
NUMBER=[0-9]
SPACE=\s
NEWLINE=\n

%% 

<YYINITIAL> {
  "Entrezgene ::=" { return (new Yytoken(0,yytext(),yyline,yychar,yychar+yylength())); }
  {DICTKEY}+ { return (new Yytoken(1,yytext(),yyline,yychar,yychar+yylength())); }  
  {STRING}+ { return (new Yytoken(2,yytext(),yyline,yychar,yychar+yylength())); }  
  {NUMBER}+ { return (new Yytoken(3,yytext(),yyline,yychar,yychar+yylength())); }  
  {SPACE}+ { return (new Yytoken(4,yytext(),yyline,yychar,yychar+yylength())); }  
  {NEWLINE}+ { return (new Yytoken(5,yytext(),yyline,yychar,yychar+yylength())); }  
  
  {NEWLINE}+ { } /*than skip*/
}
. {
  System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}

