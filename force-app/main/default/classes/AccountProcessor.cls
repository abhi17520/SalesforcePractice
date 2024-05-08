public class AccountProcessor {
	@future(callout=true)
    public static void countContacts(List<Id> accountIds){
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id IN : accountIds];
        List<Account> updatedAccount = new List<Account>();
        for(Account ac : accounts){
            ac.Number_Of_Contacts__c = [SELECT count() FROM Contact WHERE AccountID =: ac.Id];
            System.debug('No. of contacts : '+ ac.Number_Of_Contacts__c);
            updatedAccount.add(ac);
        }
        update updatedAccount;
    }
}