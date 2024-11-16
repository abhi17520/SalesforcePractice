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

    //To check for duplicate account
    public static void errorDuplicateAccount(List<Account> acc, Map<Id, Account> accMap){
        Set<String> accNames = new Set<String>();
        Map<String, Account> existingAccMap = new Map<String, Account>();
        if(!acc.isEmpty()){
            for(Account a: acc){
                if(accMap != null && a.Name != accMap.get(a.Id).Name){
                    accNames.add(a.Name);
                } else if(accMap == null){
                    accNames.add(a.Name);
                }
            }
        }
        
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Name IN: accNames];
        if(!accList.isEmpty()){
            for(Account a: accList){
                existingAccMap.put(a.Name, a);
            }

            if(!acc.isEmpty()){
                for(Account a: acc){
                    if(existingAccMap.containsKey(a.Name)){
                        a.addError('Account with same name already exists.');
                    }
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

    //To create related contacts
    public static void createRelatedContacts(List<Account> acc, Map<Id, Account> accMap){
        List<Contact> conList = new List<Contact>();
        for(Account a: acc){
            if((accMap == null || a.Phone != accMap.get(a.Id).Phone) &&  a.Create_Related_Contact__c == true){
                Contact con = new Contact();
                con.LastName = a.Name;
                con.AccountId = a.Id;
                con.Phone = a.Phone;
                conList.add(con);
            }
        }

        if(!conList.isEmpty()){
            insert conList;
        }
    }
}