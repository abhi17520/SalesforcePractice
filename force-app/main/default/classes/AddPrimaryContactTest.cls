@isTest
public class AddPrimaryContactTest {
	@isTest
    static void addPrimaryContactTest(){
        List<Account> test = new List<Account>();
        for(Integer i=0; i<50; i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.BillingState = 'NY';
            test.add(acc);
        }
        for(Integer i=0; i<50; i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.BillingState = 'CA';
            test.add(acc);
        }
        insert test;
        
        Contact c = new Contact();
        c.FirstName = 'demo';
        c.LastName = 'demo';
        insert c;
        String state = 'CA';
        AddPrimaryContact addit = new addPrimaryContact(c, state);
        
        System.Test.startTest();
        System.enqueueJob(addit);
        System.Test.stopTest();
        
        Integer actual = [SELECT count() FROM Contact WHERE accountId In (SELECT id FROM Account WHERE BillingState = 'CA')];
        System.assertEquals(50, actual);
    }
}