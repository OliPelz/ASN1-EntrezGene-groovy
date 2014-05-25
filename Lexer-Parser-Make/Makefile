# only works with 
# jflex 1.5.1 installed in the system and 
# the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = /usr/bin/jflex 
BYACCJ = yacc -J
JAVAC  = javac
JAVA   = java
BUILDPATH = ./classes
SRCPATH = ./src
JUNITJARABSPATH =/usr/share/java/junit-4.10/junit-4.10.jar
JFLEXJARABSPATH=/usr/lib/jflex-1.5.1.jar
COMPILEOPTION=-d $(BUILDPATH) -classpath $(BUILDPATH)/.:$(JUNITJARABSPATH):$(JFLEXJARABSPATH)
RUNOPTION=-classpath $(BUILDPATH):$(JUNITJARABSPATH)
#we use this class for running junittests on the commandline
JUNITTESTRUNNER=junit.textui.TestRunner   
JFLEXOPTIONS=-d $(SRCPATH)
BYACCJOPTIONS=-Jclass=EntrezASNParser -Jpackage=de.oliverpelz
#todo: add a target for building the jar file
# targets:

#build our unit tests and dependancies
#TestPlayground is a jflex definition and class with corresponding text to play around with
#extracting tokens the right way etc.
test: CopyResources TestContainer TestPlayground TestLexerParser 

TestPlayground: EntrezASNLexerPlayground.class EntrezASNLexerPlaygroundTest.class
	$(JAVA) $(RUNOPTION) $(JUNITTESTRUNNER) EntrezASNLexerPlaygroundTest

#the actual real Entrez ASN parser and lexer tests
TestLexerParser: EntrezASNLexer.class EntrezASNParser.class EntrezASNParserTest.class
	$(JAVA) $(RUNOPTION) $(JUNITTESTRUNNER) EntrezASNParserTest

#copies resources into the build folder
CopyResources: Setup
	cp -r $(SRCPATH)/test/resources $(BUILDPATH)

#this sets up the project folder
Setup: 
	mkdir -p $(BUILDPATH)
	

TestContainer: src/data/Yytoken.java $(SRCPATH)/data/Utility.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/data/Yytoken.java $(SRCPATH)/data/Utility.java

EntrezASNLexerPlayground.class: EntrezASNLexerPlayground.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNLexerPlayground.java

EntrezASNLexerPlaygroundTest.class:
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/test/EntrezASNLexerPlaygroundTest.java

EntrezASNParserTest.class:
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/test/EntrezASNLexerTest.java

EntrezASNLexer.class: EntrezASNLexer.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNLexer.java

EntrezASNParser.class: EntrezASNParser.java
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
	rm -rf $(BUILDPATH)/* src/*~ src/EntrezASNLexerPlayground.java src/EntrezASNLexer.java src/EntrezASNParser.java src/EntrezASNParserVal.java 

all: Setup
