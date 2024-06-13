/* Purpose:-This class is written for AccountCardController class
* Date:-11-06-2024
*/

@isTest
public class AccountCardController_Test {
    
    @isTest
    static void testKProcessedContact() {
        // Create test data
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contact con = new Contact(AccountId = acc.Id, LastName='Test Contact');
        insert con;
        
        K_Contact__c kContact = new K_Contact__c(Contact__c = con.Id);
        insert kContact;
        
        K_Processed_Contact__c kpc1 = new K_Processed_Contact__c(K_Contact__c = kContact.Id, Contact_Status__c = 'Processed');
        insert kpc1;
        
        K_Processed_Contact__c kpc2 = new K_Processed_Contact__c(K_Contact__c = kContact.Id, Contact_Status__c = 'Pending');
        insert kpc2;
        
        K_Processed_Contact__c kpc3 = new K_Processed_Contact__c(K_Contact__c = kContact.Id, Action_Taken__c = 'No Action Taken');
        insert kpc3;
        
        Test.startTest();
        List<K_Processed_Contact__c> result = AccountCardController.kProcessedContact(acc.Id);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(2, result.size(), 'Expected 2 processed contacts');
        
        // Verify the fields of the first result
        System.assertEquals(kpc1.Id, result[0].Id);
        System.assertEquals(kContact.Id, result[0].K_Contact__r.Contact__r.AccountId);
        System.assertEquals('Processed', result[0].Contact_Status__c);
        
        // Verify the fields of the second result
        System.assertEquals(kpc2.Id, result[1].Id);
        System.assertEquals(kContact.Id, result[1].K_Contact__r.Contact__r.AccountId);
        System.assertEquals('Pending', result[1].Contact_Status__c);
    }
    
    @isTest
    static void testKProcessedContact_NoRecordsFound() {
        // Create test data
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Test.startTest();
        List<K_Processed_Contact__c> result = AccountCardController.kProcessedContact(acc.Id);
        Test.stopTest();
        
        // Verify no records are found
        System.assertEquals(0, result.size(), 'Expected no processed contacts');
    }
}