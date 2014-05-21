if [ -e src/main/java/de/oliverpelz/EntrezASNLexerTest.java ];then

   rm src/main/java/de/oliverpelz/EntrezASNLexerTest.java
fi
mvn clean jflex:generate;mvn process-resources;mvn test
