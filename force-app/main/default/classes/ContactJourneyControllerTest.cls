/* Purpose:-This class is written for ContactJourneyController class
* Date:-11-06-2024
*/


@isTest
private class ContactJourneyControllerTest {
    
    @isTest
    static void testGetCareerEventsByContactId_Success() {
        // Create test data
        Account testAccount = new Account(
            Name = 'Krios Info Solutions',
            Website = 'http://www.krios.com'
        );
        insert testAccount;
        
        Contact testContact = new Contact(
            FirstName = 'Sachin',
            LastName = 'Kulkarni',
            Email = 'sachin.kulkarni@kriosispl.com',
            AccountId = testAccount.Id
        );
        insert testContact;
        
        K_Contact__c kContact = new K_Contact__c(
            Contact__c = testContact.Id,
            Job_Title__c = 'Salesforce Developer',
            Last_Name__c = 'Kulkarni',
            First_Name__c = 'Sachin',
            Company_Name__c = 'Krios Info Solutions'
        );
        insert kContact;
        
        K_Processed_Contact__c testCareerEvent = new K_Processed_Contact__c(
            Company__c = 'Krios Info Solutions',
            First_Name__c = 'Sachin',
            ContactId__c = testContact.Id,
            Last_Name__c = 'Kulkarni',
            Job_Title__c = 'Manager',
            Contact_Status__c = 'Left',
            K_Contact__c = kContact.Id,
            Action_Taken__c = 'Skip'
        );
        insert testCareerEvent;
        
        // Call the method to test
        Test.startTest();
        K_Processed_Contact__c result = ContactJourneyController.getCareerEventsByContactId(testContact.Id);
        Test.stopTest();
        
        // Verify the results
        System.assertNotEquals(null, result, 'Expected a valid career event');
        System.assertEquals(testCareerEvent.Company__c, result.Company__c, 'Company does not match');
        System.assertEquals(testCareerEvent.First_Name__c, result.First_Name__c, 'First name does not match');
        System.assertEquals(testCareerEvent.ContactId__c, result.ContactId__c, 'Contact Id does not match');
        System.assertEquals(testCareerEvent.Last_Name__c, result.Last_Name__c, 'Last name does not match');
        System.assertEquals(testCareerEvent.Job_Title__c, result.Job_Title__c, 'Job title does not match');
        System.assertEquals(testCareerEvent.Contact_Status__c, result.Contact_Status__c, 'Contact status does not match');
        System.assertEquals(testCareerEvent.K_Contact__c, result.K_Contact__c, 'K Contact Id does not match');
        System.assertEquals(testCareerEvent.Action_Taken__c, result.Action_Taken__c, 'Action taken does not match');
    }
    
    @isTest
    static void testGetCareerEventsByContactId_NoResults() {
        // Create test data
        Contact testContact = new Contact(
            FirstName = 'Jane',
            LastName = 'Smith',
            Email = 'jane.smith@example.com'
        );
        insert testContact;
        
        // Call the method to test
        Test.startTest();
        K_Processed_Contact__c result = ContactJourneyController.getCareerEventsByContactId(testContact.Id);
        Test.stopTest();
        
        // Verify the results
        System.assertEquals(null, result, 'Expected no career events');
    }
    
    /*@isTest
    static void testGetCareerEventsByContactId_Exception() {
        // Call the method with an invalid contact Id to simulate an exception
        Test.startTest();
        try {
            K_Processed_Contact__c result = ContactJourneyController.getCareerEventsByContactId('invalidContactId');
            System.assert(false, 'Expected exception was not thrown');
        } catch (QueryException e) {
            System.assert(e.getMessage().contains('List has no rows for assignment to SObject'), 'Unexpected exception message');
        }
        Test.stopTest();
    }*/
}