/**
* This class counts number of contacts on a given account and update Number_Of_Contacts__c field on Account
* Implements Batchable and schedulable to schedule to run this job daily
*/

global class BatchUpdateContactCount implements Database.Batchable<sObject>,Schedulable {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, AccountId FROM Contact';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contacts){        
        
        // Fill the map with accountIds and contact count 
        Map<Id,Integer> accountCountMap = new Map<Id,Integer>(); 
        for(Contact con : contacts){
           if(!accountCountMap.containsKey(con.AccountId)){
               accountCountMap.put(con.AccountId, 0);
           }
           accountCountMap.put(con.AccountId, accountCountMap.get(con.AccountId) + 1);                        
        }
        
        //use the account ids from above map to query all relavent accounts 
        List<Account> accountsList = [Select Id, Number_Of_Contacts__c FROM Account Where Id IN :accountCountMap.keySet()];
        
        //update the number_of_contacts value
        for(Account acc : accountsList){
            Integer contactCount = accountCountMap.get(acc.Id);
            acc.Number_Of_Contacts__c = contactCount;            
        }
        
        // update using database.update to allow partial success of records and use saveresult for finish activities 
        // such as logging or sending email etc
        Database.SaveResult [] updateResult =  Database.update(accountsList);
    }
    
    global void finish(Database.BatchableContext bc){
        /**
         * Do finish activities such as to send email       
        */
    }
    
    global void execute(SchedulableContext sc){
    
    }

}