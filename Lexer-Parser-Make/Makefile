# only works with 
# jflex 1.5.1 installed in the system and 
# the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = /usr/bin/jflex 
BYACCJ = yacc -J
JAVAC  = javac
JAVA   = java
CLASSPATH = ./classes
SRCPATH = ./src
JUNITJARABSPATH = /usr/share/java/junit-4.10/junit-4.10.jar
COMPILEOPTION = -d $(CLASSPATH) -classpath $(CLASSPATH);$(JUNITJARABSPATH)
JFLEXOPTIONS = -d $(SRCPATH)
#todo: add a target for building the jar file
# targets:

#build our unit tests
test: Setup TestContainer TestPlayground 

TestPlayground: EntrezASNLexerPlayground.class EntrezASNLexerPlaygroundTest.class

Setup: 
	mkdir -p classes

TestContainer: src/data/Yytoken.java src/data/Utility.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/data/Yytoken.java $(SRCPATH)/data/Utility.java

EntrezASNLexerPlayground.class: src/EntrezASNLexerPlayground.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/EntrezASNLexerPlayground.java

EntrezASNLexerPlayground.java: EntrezASNLexerPlayground.flex
	$(JFLEX) $(JFLEXOPTIONS) EntrezASNLexerPlayground.flex

EntrezASNLexerPlaygroundTest.class: src/test/EntrezASNLexerPlaygroundTest.java
	$(JAVAC) $(COMPILEOPTION) $(SRCPATH)/test/EntrezASNLexerPlaygroundTest.java


clean:
	rm -rf $(CLASSPATH)/*

all: Setup
