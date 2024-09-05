public class AccountTriggerHandler {
    //To check if Phone field is empty
    public static void errorPhoneEmpty(List<Account> acc){
        if(!acc.isEmpty()){
            for(Account a: acc){
                if(a.Phone == null){
                    a.Phone.addError('You cannot insert account with Phone field empty.');
                }
            }
        }
    }
    
    //To update related contacts
    public static void updateRelatedContatcts(List<Account> acc, Map<Id, Account> accMap){
        Map<Id, Account> accMapToUpdate = new Map<Id, Account>();
        if(!acc.isEmpty()){
            for(Account a: acc){
                if(accMap.get(a.Id).Phone != a.Phone){
                    accMapToUpdate.put(a.Id, a);
                }
            }
        }
        if(!accMapToUpdate.isEmpty()){
            List<Contact> conList = [SELECT Id, Name, Phone, AccountId FROM Contact
                                     WHERE AccountId IN: accMapToUpdate.keySet()];
            if(!conList.isEmpty()){
                for(Contact c: conList){
                    c.Phone = accMapToUpdate.get(c.AccountId).Phone;
                }
            }
            update conList;
        }       
    }
}