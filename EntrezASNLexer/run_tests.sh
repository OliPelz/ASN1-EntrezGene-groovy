if [ -e src/main/java/de/oliverpelz/EntrezASNLexer.java ];then
   rm src/main/java/de/oliverpelz/EntrezASNLexer.java
fi
mvn clean jflex:generate;mvn process-resources;mvn test
