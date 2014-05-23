if [ -e src/main/java/de/oliverpelz/EntrezASNLexerPlayground.java ];then
   rm src/main/java/de/oliverpelz/EntrezASNLexerPlayground.java
fi

if [ -e src/main/java/de/oliverpelz/EntrezASNLexerPlayground.java ];then
   rm src/main/java/de/oliverpelz/EntrezASNLexerPlayground.java
fi



mvn clean jflex:generate;mvn process-resources
yacc -Jclass=EntrezASNParser -Jpackage=de.oliverpelz src/main/parser/EntrezASNParser.y
mv *.java target/classes/de/oliverpelz/
cd target/classes/de/oliverpelz/
javac EntrezASNParser.java

mvn test
