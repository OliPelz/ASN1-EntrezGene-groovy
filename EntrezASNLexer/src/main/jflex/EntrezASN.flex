/* this is the scanner playground for my upcoming ASN1 Entrezgene parser
   (with small modifications to make it more readable) */

%%

%{
  private int comment_count = 0;
%} 

%line
%char
%state COMMENT
%full
%class EntrezASNLexer

%debug

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])*
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*

%% 

<YYINITIAL> {
  "Entrezgene ::=" { return (new Yytoken(0,yytext(),yyline,yychar,yychar+yylength())); }
  
  {NONNEWLINE_WHITE_SPACE_CHAR}+ { } /*than skip*/

  "/*" { yybegin(COMMENT); comment_count++; }

  \"{STRING_TEXT}\" {
    String str =  yytext().substring(1,yylength()-1);
    return (new Yytoken(40,str,yyline,yychar,yychar+yylength()));
  }
  
  {DIGIT}+ { return (new Yytoken(42,yytext(),yyline,yychar,yychar+yylength())); }  

  {Ident} { return (new Yytoken(43,yytext(),yyline,yychar,yychar+yylength())); }  
}

<COMMENT> {
  "/*" { comment_count++; }
  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
  {COMMENT_TEXT} { }
}


{NEWLINE} { }

. {
  System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}

