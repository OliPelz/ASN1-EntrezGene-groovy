package de.oliverpelz.ASN

class EntrezASNParser {
//test with http://www.regexplanet.com/advanced/java/index.html
	static String LINEMATCHER = /^\s*([\w_-]*)\s{0,1}([\w_-]*)|(\"[\s\w_-]*\")(\s\{){0,1}(\s[{}])*(\s[,]){0,1}/;   //first group is the variable, second group is the value for the variable, third group is a bracket, fourth group is a comma
	static String parseRecord(String content) {
		def dataStruct = [:]
		//Todo : get rid of first 'Entrezgene ::= {' and last '}'
		//content =~ /^Entrezgene ::=//
		return parseRecursive(content, dataStruct);
	
	}
	//this is the main parsing function (ASN is a JSON like object)
	static parseRecursive(content, dataStruct) {
		for(String line : content.split("\n")) {
			def matcher = (line =~ LINEMATCHER)
			if(matcher.matches()) {
				//def word = $1;
				//def brak = $2;
			}
			
		}
	}
	static String parseFile(File file) {
		 //Scanner scanner = new Scanner( new File("EastOfJava.txt") );
		 	
	}
 }
 
 /*
 method next_record :
 // set new line seperator
 lineSeperator = "Entrezgene ::= {"; # set record separator
 
 //open asn file and put in stream
 
 // iterate through each line
 InputStream.eachLine(closure)
 
 //in the iteration closure
 
 { line ->
	 //get rid of the 'Entrezgene ::= ' at the beginning of Entrez Gene record
	 
	 tmp = (/^\s*Entrezgene ::= ({.*)/si)? $1 : "{" . $_;
 
	 call parse_record (tmp)
 
 }
 
 
 method parse_record(record)
 */
