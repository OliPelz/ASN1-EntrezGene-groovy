%{
  import java.io.*;
%}
      
%token NEWGENE          /* token marks the beginning of a new gene  */
%token MYEOL    /* this is marking the end of a line and beginning of potential spaces in the new line*/
%token SINGLESPACE
%token OPENBRACKET
%token CLOSINGBRACKET
%token COMMA

%token <dval> DICTKEY  /* a key from a dictionary */
%token <dval> MYSTRING  /* a value for a dictionary*/
%token <dval> NUMBER   /* a number */
      
%%


      
input:   NEWGENE | NUMBER
       ;

%%
  /* a reference to the lexer object */
  private Yylex lexer;

  /* interface to the lexer */
  private int yylex () {
    int yyl_return = -1;
    try {
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }

  /* error reporting */
  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }

  /* lexer is created in the constructor */
  /*public EntrezASNParser(Reader r) {
    lexer = new Yylex(r, this);
  }*/

  /* that's how you use the parser */
  public static void main(String args[]) throws IOException {
    /*EntrezASNParser yyparser = new EntrezASNParser(new FileReader(args[0]));
    yyparser.yyparse();    */
  }

