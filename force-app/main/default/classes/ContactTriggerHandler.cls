public with sharing class ContactTriggerHandler {
    //To update related accounts
    public static void updateRelatedAccounts(List<Contact> con, Map<Id, Contact> conMap){
        Map<Id, Contact> conMapToUpdate = new Map<Id, Contact>();
        if(!con.isEmpty()){
            for(Contact c: con){
                if(conMap.get(c.Id).Description  != c.Description){
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
}