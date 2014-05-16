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
which we dann can compile for our project
```sh

```