# only works with 
# jflex 1.5.1 installed in the system and 
# AND the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = /usr/bin/jflex 
BYACCJ = yacc -J
JAVAC  = javac
JAVA   = java
BUILDPATH = ./bin
SOURCEPATH = ./src/main/java
SRCPATH = $(SOURCEPATH)/de/oliverpelz
TESTPATH = ./src/test/de/oliverpelz
RESOURCESPATH = ./src/test/resources
JUNITJARABSPATH =/usr/share/java/junit-4.10/junit-4.10.jar
COMPILEOPTION=-d $(BUILDPATH) -sourcepath $(SOURCEPATH) -classpath $(BUILDPATH)/.:$(JUNITJARABSPATH) 
RUNOPTION=-classpath $(BUILDPATH)/.:$(JUNITJARABSPATH)
#we use this class for running junittests on the commandline
#for junit3: junit.textui.TestRunner
JUNITTESTRUNNER=org.junit.runner.JUnitCore   
JFLEXOPTIONS=-d $(SRCPATH)
BYACCJOPTIONS=-Jclass=EntrezASNParser -Jpackage=de.oliverpelz
#todo: add a target for building the jar file
# targets:

#build our unit tests and dependancies
#TestPlayground is a jflex definition and class with corresponding text to play around with
#extracting tokens the right way etc.
test: CopyResources TestContainer TestPlayground TestLexerParser 

TestPlayground: EntrezASNLexerPlayground.class EntrezASNLexerPlaygroundTest.class
	$(JAVA) $(RUNOPTION) $(JUNITTESTRUNNER) de.oliverpelz.EntrezASNLexerPlaygroundTest

#the actual real Entrez ASN parser and lexer tests
TestLexerParser: EntrezASNParser.class EntrezASNParserTest.class
	$(JAVA) $(RUNOPTION) $(JUNITTESTRUNNER) de.oliverpelz.EntrezASNParserTest

#copies resources into the build folder
CopyResources: Setup
	cp -r $(RESOURCESPATH) $(BUILDPATH)

#this sets up the project folder
Setup: 
	mkdir -p $(BUILDPATH)
	

TestContainer: $(SRCPATH)/data/Yytoken.java $(SRCPATH)/data/Utility.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/data/Yytoken.java $(SRCPATH)/data/Utility.java

EntrezASNLexerPlayground.class: EntrezASNLexerPlayground.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNLexerPlayground.java

EntrezASNLexerPlaygroundTest.class:
	$(JAVAC) $(COMPILEOPTION) $(TESTPATH)/EntrezASNLexerPlaygroundTest.java

EntrezASNParserTest.class:
	$(JAVAC) $(COMPILEOPTION) $(TESTPATH)/EntrezASNParserTest.java

EntrezASNParser.class: EntrezASNLexer.java EntrezASNParser.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNParserVal.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNParser.java


EntrezASNLexerPlayground.java: EntrezASNLexerPlayground.flex
	$(JFLEX) $(JFLEXOPTIONS) EntrezASNLexerPlayground.flex

EntrezASNLexer.java: EntrezASNLexer.flex
	$(JFLEX) $(JFLEXOPTIONS) EntrezASNLexer.flex

EntrezASNParser.java: EntrezASNParser.y
	$(BYACCJ) $(BYACCJOPTIONS) EntrezASNParser.y
	mv EntrezASNParser.java EntrezASNParserVal.java $(SRCPATH)


clean:
	rm -rf $(BUILDPATH)/* $(SRCPATH)/*~ $(SRCPATH)/EntrezASNLexerPlayground.java $(SRCPATH)/EntrezASNLexer.java $(SRCPATH)/EntrezASNParser.java $(SRCPATH)/EntrezASNParserVal.java 

all: Setup
