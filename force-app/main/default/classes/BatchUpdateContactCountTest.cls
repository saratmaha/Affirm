@isTest
public class BatchUpdateContactCountTest{

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
        
        List<Contact> contactList = new List<Contact>();
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Test';
        contact1.LastName = 'Contact1';
        contact1.AccountId = testAccount1.Id;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Test';
        contact2.LastName = 'Contact1';
        contact2.AccountId = testAccount1.Id;
        
        Contact contact3 = new Contact();
        contact3.FirstName = 'Test';
        contact3.LastName = 'Contact1';
        contact3.AccountId = testAccount2.Id;
        
        contactList.add(contact1);
        contactList.add(contact2);
        contactList.add(contact3);
        
        insert contactList;               
     }
     
      @isTest
      static void testMethod1() {
      
          Test.startTest();
              BatchUpdateContactCount bc = new BatchUpdateContactCount();
              Database.executeBatch(bc);
          Test.stopTest();
          
          List<Account> accounts = [Select Id,name,Number_Of_Contacts__c from Account];
          
          for(Account acc : accounts){
              //System.debug('Account Name -- ' + acc.Name + ' -- Number of contacts --' + acc.Number_Of_Contacts__c);
              
              if(acc.Name.equals('New Account 1')) {
                System.assertEquals(2, acc.Number_Of_Contacts__c, 'Number of contacts not updated');
              }
              if(acc.Name.equals('New Account 2')) {
                System.assertEquals(1, acc.Number_Of_Contacts__c, 'Number of contacts not updated');
              }
              if(acc.Name.equals('New Account 3')) {
                System.assertEquals(null, acc.Number_Of_Contacts__c, 'Number of contacts not updated');
              }
          }      
      }
}