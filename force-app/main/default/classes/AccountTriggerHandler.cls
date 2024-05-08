public class AccountTriggerHandler {
    public static void errorPhoneEmpty(List<Account> acc){
        if(!acc.isEmpty()){
            for(Account a: acc){
                if(a.Phone == null){
                    a.Phone.addError('You cannot insert account with Phone field empty.');
                }
            }
        }
    }
}