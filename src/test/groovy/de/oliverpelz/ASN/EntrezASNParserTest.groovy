package groovy

import static org.junit.Assert.*;
import org.junit.Test;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import org.junit.Before;


class EntrezASNParserTest {

	def smallEntry
	
	@Before 
	void setUp() {
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
		def regexp = EntrezASNParser.LINEMATCHER;
		def matcher = line =~ regexp;
		assertTrue matcher.matches()
		assertTrue matcher[0], is("track-infoX")
		line = "geneid 12345 ,"
		matcher = line =~ regexp;
		assertTrue matcher[0], is("geneid")
		assertTrue matcher[1], is("12345")
		assertTrue matcher[2], is(",")
		
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
