public without sharing class AccountListView {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [Select Id, Name, Phone, AccountNumber, Industry, Rating, AnnualRevenue
                FROM Account];
    }
}