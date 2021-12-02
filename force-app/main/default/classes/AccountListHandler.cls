public class AccountListHandler{

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
    
        Account[] accountList = [Select Id, Name from Account LIMIT 5];
        return accountList;
    }

}