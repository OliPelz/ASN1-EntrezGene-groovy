first install BYacc/J for your OS and put it in path

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

now to the yacc part, we will replace this with a proper maven routine later

```sh
./run_test.sh
yacc -Jclass=EntrezASNParser -Jpackage=de.oliverpelz src/main/parser/EntrezASNParser.y
mv *.java target/classes/de/oliverpelz/
cd target/classes/de/oliverpelz/
javac EntrezASNParser.java
./EntrezASNParser
```

