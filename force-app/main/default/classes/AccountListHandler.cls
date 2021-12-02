public class AccountListHandler{

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {    
        Account[] accountList = [Select Id, Name from Account LIMIT 5];
        return accountList;
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(String searchId){
        System.debug('Account Id ->' + searchId);
        Account acc = [
            Select Id, Name, Industry, Type, Owner.Name, Owner.SmallPhotoUrl 
            from Account 
            Where Id = :searchId
        ];
        return acc;
        /*try {
            Account acc = [
                Select Id, Name, Industry, Type, Owner.Name, Owner.SmallPhotoUrl 
                from Account 
                Where Id = :searchId
            ];
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }*/
    }
}