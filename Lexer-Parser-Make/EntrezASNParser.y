%{
  import java.io.*;
  import java.util.HashMap;
%}
      
%token NEWGENE          /* token marks the beginning of a new gene  */
%token SINGLESPACE
%token OPENBRACKET
%token CLOSINGBRACKET
%token ERROR

%token <dval> DICTKEY  /* a key from a dictionary */
%token <dval> MYSTRING  /* a value for a dictionary*/
%token <dval> NUMBER   /* a number */
      
%%

allGenes: gene
	  | allGenes gene

gene: NEWGENE objs CLOSINGBRACKET {}

objs: obj
      | objs obj

obj:  DICTKEY SINGLESPACE MYSTRING
     | DICTKEY SINGLESPACE NUMBER
     | DICTKEY SINGLESPACE DICTKEY
     | DICTKEY

%%
  private int flushCounter; /*a counter for persisting in the database*/
  private HashMap<String,Object> dsObject;  /*our datastructure to save*/
  private DictionaryFilter dictFilter;  /*only process and store dictionary keys which follow this structure*/
  private PersistToDatabaseInterface persistToDatabase; /*an interface which has to implement the saveObj() method for persisting*/ 
  /* a reference to the lexer object */
  private EntrezASNLexer lexer;

  /* method to set debug flag */
  public void setDebug() {
	yydebug=true;
  }


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
  public EntrezASNParser(Reader r) {
    lexer = new EntrezASNLexer(r, this);
  }

