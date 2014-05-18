how to generate lexer
```sh
mvn jflex:generate
```
since there is a bug, you need to copy the resource manually from:
```sh
mvn process-resources
```

this generates java source class lexer in 
```sh
src/main/java/de/oliverpelz/Lexer/EntrezASNLexer.java
```
clean up some shit
```sh
rm -rf target
```

summarized
```sh

mvn jflex:generate;mvn process-resources;rm -rf target
```

than we run the tests
```sh
mvn test

```
