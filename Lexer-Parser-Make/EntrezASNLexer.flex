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
  private parser yyparser;

  /* constructor taking an additional parser object */
  public Yylex(java.io.Reader r, parser yyparser) {
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
  
  "Entrezgene ::= {" { return parser.NEWGENE; }
  \"	{ yybegin(STRING); }
  {MYEOL} { return parser.MYEOL;}  /*get rid of newlines and blanks at beginning of line*/
  {DICTKEY} { yyparser.yylval = new parserval(yytext(); /*this is how we return lexical values*/
  			  return parser.DICTKEY;	
  			}  
  {NUMBER}  { yyparser.yylval = new parserval(Long.parseLong(yytext())
  			  return parser.NUMBER;	
  			}  
  {SINGLESPACE} { return parser.SINGLESPACE;} 
  {OPENBRACKET} { return parser.OPENBRACKET;} 
  {CLOSINGBRACKET} { return parser.CLOSINGBRACKET;} 
  {COMMA} { return parser.COMMA;} 
  
  
}
<STRING> {
  \"    { yybegin(YYINITIAL);}    //end of string
  [^\"]+ { yyparser.yylval = new parserval(yytext();
  	       return parser.MYSTRING;
		 }  
}  
.  { System.err.println("Error: unexpected character '"+yytext()+"'"); return parser.ERROR; }

