@IsTest
/* Purpose:-This class is written for TrackButtonController class
* Date:-11-06-2024
*/
public class TrackButtonControllerTest {
    @testSetup
    static void setup() {
        // Create a CRM Admin user
        User crmAdmin = new User(
            FirstName = 'CRM',
            LastName = 'Admin',
            Email = 'crmadmin@example.com',
            Username = 'crmadmin@example.com' + System.currentTimeMillis(),
            Alias = 'crmadmin',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id
        );
        insert crmAdmin;
        
        // Create a Kanlet License
        Kanlet_License__c kanletLicense = new Kanlet_License__c(Customer_id__c = 2, User_Unique_Id__c = 2);
        insert kanletLicense;
        
        // Create a Track Request
        Track_Request__c trackRequest = new Track_Request__c(Kanlet_Configuration__c = kanletLicense.Id);
        insert trackRequest;
        
        // Create a Contact
        Account account = new Account(Name = 'Test Account');
        insert account;
        Contact contact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = account.Id);
        insert contact;
        
        // Create K_Contact
        K_Contact__c kContact = new K_Contact__c(
            First_Name__c = 'John',
            Last_Name__c = 'Doe',
            Email_Id__c = 'john.doe@example.com',
            Company_Website__c = 'www.example.com',
            Company_Name__c = 'Example Corp',
            Job_Title__c = 'Developer',
            Contact__c = contact.Id
        );
        insert kContact;
        
        // Create Track Request Contact
        Track_Request_Contact__c trackRequestContact = new Track_Request_Contact__c(
            Track_Request__c = trackRequest.Id,
            K_Contact__c = kContact.Id
        );
        insert trackRequestContact;
        
        // Ensure the required metadata exists
        Integration_Metadata__mdt mdt = Integration_Metadata__mdt.getInstance('Upload_Key_Contacts');
    }
    
    @IsTest
    static void testGetContactsSuccess() {
        // Complete all DML operations in the test setup before callout
        Test.startTest();
        
        // Mock HTTP Response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Get the Track Request Id
        Track_Request__c trackRequest = [SELECT Id FROM Track_Request__c LIMIT 1];
        String trackRequestId = trackRequest.Id;
        
        // Call the method and assert the result
        String result = TrackButtonController.getContacts(trackRequestId);
        Test.stopTest();
        System.assertEquals('Success', result);
    }
    
    @IsTest
    static void testGetContactsFailure() {
        // Complete all DML operations in the test setup before callout
        Test.startTest();
        
        // Mock HTTP Response with an error
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(400, 'Bad Request'));
        
        // Get the Track Request Id
        Track_Request__c trackRequest = [SELECT Id FROM Track_Request__c LIMIT 1];
        String trackRequestId = trackRequest.Id;
        
        // Call the method and assert the result
        String result = TrackButtonController.getContacts(trackRequestId);
        Test.stopTest();
        // System.assert(result.contains('Bad Request'));
    }
    
}