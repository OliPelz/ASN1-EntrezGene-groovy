package groovy

import static org.junit.Assert.*;
import org.junit.Test;


class EntrezASNParserTest {

	@Test
	public void testParseRecord() {
		String content = """
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
