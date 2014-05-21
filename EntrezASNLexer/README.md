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

summarized, how to rerun tests if sth. changed in the jflex script
```sh
./run_tests.sh
```

than we run the tests
```sh
mvn test

```
manual debug of test output
```sh
cat target/output.actual  | grep -i Illegal
```
