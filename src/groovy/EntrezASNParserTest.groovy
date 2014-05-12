package groovy
import static org.junit.Assert.*;

import org.junit.Test;


class EntrezASNParserTest {

	@Test
	public void testParseRecord() {
		def content = """
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
		def record = EntrezASNParser.parseRecord(content);
		assertThat record['track-info']['geneid'], is(12345)
	}

	@Test
	public void testParseFile() {
		def rec = EntrezASNParser.parseFile("input.asn")
		assertThat rec[0]['track-info']['geneid'], is(1)
	}

}
