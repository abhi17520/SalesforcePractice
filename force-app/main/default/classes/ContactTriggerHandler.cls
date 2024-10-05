public with sharing class ContactTriggerHandler {
    //To update related accounts
    public static void updateRelatedAccounts(List<Contact> con, Map<Id, Contact> conMap){
        Map<Id, Contact> conMapToUpdate = new Map<Id, Contact>();
        if(!con.isEmpty()){
            for(Contact c: con){
                if(c.AccountId != null && conMap.get(c.Id).Description  != c.Description){
                    conMapToUpdate.put(c.AccountId, c);
                }
            }
        }
        if(!conMapToUpdate.isEmpty()){
            List<Account> accList = [SELECT Id, Name, Description FROM Account
                                     WHERE Id IN: conMapToUpdate.keySet()];
            if(!accList.isEmpty()){
                for(Account a: accList){
                    a.Description = conMapToUpdate.get(a.Id).Description;
                }
            }
            update accList;
        }
    }

    //To count no. of contacts associated with an account and display on account field
    public static void updateContactCount(List<Contact> con, Map<Id, Contact> conMap){
        Set<Id> accIds = new Set<Id>();
        for (Contact c: con) {
            //To add the account id of updated contacts
            if(conMap != null && c.AccountId != conMap.get(c.Id).AccountId){
                accIds.add(c.AccountId);
                accIds.add(conMap.get(c.Id).AccountId);
            }
            else{
                //To add the account id of inserted, deleted and undeleted contacts
                accIds.add(c.AccountId);
            }
        }

        if(!accIds.isEmpty()){
            List<Account> accList = [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accIds];
            List<Account> accListToUpdate = new List<Account>();
            if(!accList.isEmpty()){
                for (Account a: accList) {
                    a.Number_Of_Contacts__c = a.Contacts.size();
                    accListToUpdate.add(a);
                }
            }
            
            if(!accListToUpdate.isEmpty()){
                update accListToUpdate;
            }
        }
    }
}