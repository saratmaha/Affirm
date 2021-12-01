public with sharing class ContactTriggerHandler implements ITriggerHandler {
  /* 
    Allows unit tests (or other code) to disable this trigger for the transaction
    To stop this trigger from firing while in a unit test, I could just add the following code to the test:
    ContactTriggerHandler.TriggerDisabled = true;
  */
  public static Boolean TriggerDisabled = false;
  /*
    Checks to see if the trigger has been disabled. For example, you could check a custom setting here.
    In this example, a static property is used to disable the trigger.
    In a unit test, you could use ContactTriggerHandler.TriggerDisabled = true to completely disable the trigger.
  */
  public Boolean IsDisabled() {
    /*
      Use the option below if you set up Custom Settings to controll Triggers
    */
    // if(TriggerSettings__c.ContactTriggerDisabled__c = true) {
    //   return true;
    // } else {
    //   return TriggerDisabled;
    // }
    return TriggerDisabled;
  }

  public void BeforeInsert(List<SObject> newItems) {
    // Cast the Sobject[] to Contact[]
    populateAccountIndustry((Contact[])newItems);
  }

  public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
    // Cast the Map<Id, Sobject> to Contact[]
    populateAccountIndustry((Contact[])newItems.values());
  }

  public void BeforeDelete(Map<Id, SObject> oldItems) {}

  public void AfterInsert(Map<Id, SObject> newItems) {}

  public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}

  public void AfterDelete(Map<Id, SObject> oldItems) {}

  public void AfterUndelete(Map<Id, SObject> oldItems) {}

  /*
    Populate Industry value from parent account
  */
  private void populateAccountIndustry(Contact[] contactList) {
       
    //Store only unique AccountIds
    Set<Id> accountIds = new Set<Id>();
    
    for(Contact con : contactList){
        //verify if the contact has a parent
        if(con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    } 
    
    //Query accounts related to contacts
    Map<Id, Account> accountList = new Map<Id,Account>([SELECT Id,Industry FROM Account Where Id IN :accountIds WITH SECURITY_ENFORCED]); 
    
    //Assign Industry value (even if null assign the value) to Contact Industry field
    for(Contact con : contactList){
        Account acc = accountList.get(con.AccountId);
        con.Account_Industry__c = acc.Industry;       
    }      
  }
}