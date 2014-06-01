/* this is the final lexer which will be used together with our parser BYacc/J*/
/* if you need to experiment wiht the regexps use the EntrezASNLexerPlaygroung and corresponding EnrezASNLexePlayGroundTest*/ 
package de.oliverpelz;

%%

%full
%public 
%class EntrezASNLexer
%state STRING
%byaccj

%{
  /* store a reference to the parser object so we can access it in here*/
  private EntrezASNParser yyparser;

  /* constructor taking an additional parser object */
  public EntrezASNLexer(java.io.Reader r, EntrezASNParser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

DICTKEY=[a-zA-Z][a-zA-Z0-9_-]+
MYEOL=\n[ ]*
NUMBER=[0-9]+
SINGLESPACE=[ ]
OPENBRACKET=[ ]*\{
CLOSINGBRACKET=[ ]*\}
COMMA=[ ]*\,

%% 

<YYINITIAL> {
  
  "Entrezgene ::= {" { return EntrezASNParser.NEWGENE; }
  \"	{ yybegin(STRING); }
  {MYEOL} { }  /*get rid of newlines and blanks at beginning of line*/
  {DICTKEY} { yyparser.yylval = new EntrezASNParserVal(yytext()); /*this is how we return lexical values*/
  			  return EntrezASNParser.DICTKEY;	
  			}  
  {NUMBER}  { yyparser.yylval = new EntrezASNParserVal(Long.parseLong(yytext()));
  			  return EntrezASNParser.NUMBER;	
  			}  
  {SINGLESPACE} { return EntrezASNParser.SINGLESPACE;} 
  {OPENBRACKET} { return EntrezASNParser.OPENBRACKET;} 
  {CLOSINGBRACKET} { return EntrezASNParser.CLOSINGBRACKET;} 
  {COMMA} { } 
  
  
}
<STRING> {
  \"    { yybegin(YYINITIAL);}    //end of string
  [^\"]+ { yyparser.yylval = new EntrezASNParserVal(yytext());
  	       return EntrezASNParser.MYSTRING;
		 }  
}  
.  { System.err.println("Error: unexpected character '"+yytext()+"'"); return EntrezASNParser.ERROR; }

