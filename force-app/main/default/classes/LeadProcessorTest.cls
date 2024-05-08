@isTest
public class LeadProcessorTest {
	@testSetup
    Static void setup(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            Lead l = new Lead();
            l.FirstName = 'Test';
            l.LastName = 'Method'+i;
            l.Company = 'Demo'+i;
            leads.add(l);
        }
        insert leads;
    }
    
    @isTest
    Static void testBatch(){
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        Integer actual = [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, actual);
    }
}