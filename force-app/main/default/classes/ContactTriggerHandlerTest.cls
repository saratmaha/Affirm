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
    
    accountsList.add(testAccount1);
    accountsList.add(testAccount2);
    
    insert accountsList;
   
  }
  
   @isTest
  static void testContactTriggerHandler() {
  
      //Scenarios Admin user and other user who does not have field accessibility
      
  }
  
  
}