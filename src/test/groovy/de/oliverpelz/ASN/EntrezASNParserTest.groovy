package de.oliverpelz.ASN

import static org.junit.Assert.*;
import org.junit.Test;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import org.junit.Before;


class EntrezASNParserTest {

	def regexp
	def smallEntry
	def weiredEntry
	def groupClasses
	
	
	@Before 
	void setUp() {
			regexp = EntrezASNParser.LINEMATCHER
			
			//currently the groups in our EntrezASNParser.LINEMATCHER have the following layout
			//if you change the LINEMATCHER regexp, you have to change the groupClasses here as well
			//this refers to the indices of the matcher elements
			//that the tests pass!
			groupClasses = [
							k : 0, //k = key, this is the key of a dictionary based datastructure
							v : 1,   //v = value of the dictionary based datastructure
							c : 2,   // comma -> a possible comma
							o : 3,  // opening braket
							e : 4, // closing braket
			]
			
	        smallEntry = """
				Entrezgene ::= {
					track-info {
						geneid 12345 ,
						status live ,
						create-date
						std {
        				year 2003 ,
						month 8
					}
				}
			}
		"""
			weiredEntry = """
					id
            		gi 42406306 } } ,
					"""
	}
	
	@Test
	public void testMainRegexpWorks() {
		URL url = this.getClass().getResource("/match_count.txt");
		def myTestFile = new File(url.getFile());
		myTestFile.eachLine { myLine ->
			if(myLine =~ /^#/) {  //skip lines with comments
				return
			}
			def myLineMatcher = (myLine =~ /^'(.*)'(\t\w)*\t$/)
			if(!myLineMatcher.matches()) {
				fail('file with test cases cannot be loaded '+myLine)
			}	
			if(myLineMatcher[0].size() < 2) {  //if the line does not contain any further info about group's class
				return  
			}
					
			def lineContent = myLineMatcher[0][1];
			
			def matcherToTest = (lineContent =~ regexp)
			if(!matcherToTest.matches()) {
				fail("matcher regexp '${regexp}' does not match line : '${it}' at all!")
			}
			
			for(def i = 1; i < myLineMatcher[0].size(); i++) {
				def groupClass = matcher[0][i]
				def matcherIdxDefined = groupClasses[groupClass] //get appropriate index on the matcher
				if(!matcherToTest[0][matcherIdxDefined]) {
					fail("matcher '${regexp}' is potentially wrong, cannot match the line '${myLine}'")
				}				
			}
			
			//now test against our matchers
			
			
		}
		
	
	}
	
	@Test
	public void entrezGeneEntryRemover() {
		if(! smallEntry =~ /^\s*Entrezgene \:\:\= \{\n/) {
		    fail("cannot find first 'Entrezgene ::= {' entry in ${smallEntry}");
		}
		def rightCurlyCounter = 0
		def matcher = smallEntry =~ /\}/
		
		matcher.findAll { myWord ->
			rightCurlyCounter++;
		}
		assertThat rightCurlyCounter, is(3)
		
		//now remove and test
		smallEntry = smallEntry.replaceAll(/^\s*Entrezgene \:\:\= \{\n/,"")
		if( smallEntry =~ /^\s*Entrezgene \:\:\= \{\n/) {
		    fail("entrezgene has not been removed from String")
		}
		smallEntry = smallEntry.replaceAll(/\}\s*\n*$/,"") //replace last right curly
		int newRightCurlyCounter = 0
		matcher = smallEntry =~ /\}/
		matcher.findAll { myWord ->
			newRightCurlyCounter++
		}
		assertThat rightCurlyCounter, is(newRightCurlyCounter + 1)
	}

	@Test
	public void testLineMatcherRegexp() {
		def line = "track-info {"		
		def matcher = (line =~ regexp);
		assertTrue matcher.matches()
		
		assertThat matcher.getCount(),is(1)
		assertThat((matcher[0].size()),is(5)) //we have four groups plus one -> the first group is always the full string
		
		assertThat matcher[0][0], equalTo("track-info")
		line = "geneid 12345 ,"
		matcher = line =~ regexp;
		assertTrue matcher[0][0], equalTo("geneid")
		assertTrue matcher[0][1], equalTo("12345")
		assertTrue matcher[0][2], equalTo(",")
		
	}

	@Test
	public void testParseRecord() {
		String content 
		//String record = EntrezASNParser.parseRecord(content);
		//assertThat record['track-info']['geneid'], is(12345)
	}

	@Test
	public void testParseFile() {
		URL url = this.getClass().getResource("/input1.asn");
		File testFile= new File(url.getFile());
		if(!testFile.exists() || testFile.isDirectory()) {
			fail("the testfile resource /input1.asn does not exist")
		}
		//def rec = EntrezASNParser.parseFile(testFile)
	//	assertThat rec[0]['track-info']['geneid'], is(1)
	}

}
