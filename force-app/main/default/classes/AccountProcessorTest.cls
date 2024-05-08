@IsTest
public class AccountProcessorTest {
    @testSetup 
    static void testSetUp(){
        
    }
    
	@IsTest
    public static void testCountContacts(){
        Account ac = new Account();
        ac.Name = 'Abhinav';
        insert ac;
        
        Contact c = new Contact(
            AccountId = ac.Id,
            FirstName = 'Test1',
            LastName = 'Contact'
        );
        insert c;
        
        Contact c1 = new Contact(
            AccountId = ac.Id,
            FirstName = 'Test2',
            LastName = 'Contact'
        );
        insert c1;
        List<Id> acctIds = new List<Id>();
        acctIds.add(ac.Id);
        Test.startTest();
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();
    }
}