@isTest
private class ContactTriggerHandlerTest {
  
  
  @testSetup
  static void setup() {
  
    List<Account> accountsList = new List<Account>(); 
    
    Account testAccount1 = new Account(
      Name = 'New Account 1',
      Industry = 'Agriculture'
    );
     
     Account testAccount2 = new Account(
      Name = 'New Account 2'
    );
      
    Account testAccount3 = new Account(
      Name = 'New Account 3',
      Industry = 'Banking'
    );
    
    accountsList.add(testAccount1);
    accountsList.add(testAccount2);
    accountsList.add(testAccount3);
    
    insert accountsList;
   
  }
  
   @isTest
  static void testContactTriggerHandler() {
  
      //Scenarios Admin user and other user who does not have field accessibility
      
      Account[] accounts = [Select Id,Name from Account];
      //System.debug('acc size - ' +accounts.size());
      
      Id acc1Id;
      Id acc2Id;
      Id acc3Id;
      
      for(Account acc : accounts){
          if(acc.Name.contains('New Account 1')){
              acc1Id = acc.Id;
		  } 
          if(acc.Name.contains('New Account 2')) {
          	acc2Id = acc.Id;            
          }
          if(acc.Name.contains('New Account 3')) {
          	acc3Id = acc.Id;            
          }
      }
      
      List<Contact> contacts = new List<Contact>();
      
      Contact contact1 = new Contact();
      contact1.FirstName = 'Test';
      contact1.LastName = 'Contact1';
      contact1.AccountId = acc1Id;
      
      Contact contact2 = new Contact();
      contact2.FirstName = 'Test';
      contact2.LastName = 'Contact2';
      contact2.AccountId = acc2Id;
      
      contacts.add(contact1);
      contacts.add(contact2);
      
      Test.startTest();
      insert contacts;     
      Test.stopTest();
      List<Contact> cons = [select Id,LastName,Account_industry__c,Account.Industry from Contact];
      
      for(Contact con : cons){
          System.assertEquals(con.Account.Industry, con.Account_Industry__c, 'Industry is not populated');
      }
      
      for(Contact con : cons){
          if(con.Account_Industry__c == 'Agriculture'){
              con.AccountId = acc3Id;
          }
      }
      
      update cons;
      
      for(Contact con : cons){
          System.assertEquals(con.Account.Industry, con.Account_Industry__c, 'Industry is not populated');
      }      
  }  
}