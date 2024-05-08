@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 ? 3 5 2023';
	@isTest
    static void testScheduledJob(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            Lead l = new Lead();
            l.FirstName = 'Test';
            l.LastName = 'Lead'+i;
            l.Company = 'The Inc';
            leads.add(l);
        }
        insert leads;
        
        Test.startTest();
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String jobId = System.schedule('Scheduled Job', CRON_EXP, dlp);
        Test.stopTest();
        
        Integer actual = [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce' AND Company = 'The Inc'];
        System.assertEquals(200, actual);
    }
}