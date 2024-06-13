/* Purpose:-This class is written for FileredDataTableController class
* Date:-11-06-2024
*/
@isTest
public class FileredDataTableControllerTest {

    @isTest
    static void testGetAccount() {
        Test.startTest();
        List<Account> accounts = FileredDataTableController.getAccount();
        Test.stopTest();
        
        System.assertNotEquals(null, accounts, 'List of accounts should not be null');
       
        for (Account acc : accounts) {
            System.assertNotEquals(null, acc.Id, 'Account Id should not be null');
            System.assertNotEquals(null, acc.Name, 'Account Name should not be null');
           
        }
    }

    @isTest
    static void testGetContacts() {
        Test.startTest();
        List<Contact> contacts = FileredDataTableController.getContacts(new List<Id>(), null, null, null, null);
        Test.stopTest();
        
        System.assertNotEquals(null, contacts, 'List of contacts should not be null');
     
        for (Contact con : contacts) {
            System.assertNotEquals(null, con.Id, 'Contact Id should not be null');
            System.assertNotEquals(null, con.FirstName, 'Contact First Name should not be null');
            
        }
    }

    @isTest
    static void testGetAcountIndustryPicklist() {
        Test.startTest();
        List<Map<String, String>> industryPicklist = FileredDataTableController.getAcountIndustryPicklist();
        Test.stopTest();
        
        System.assertNotEquals(null, industryPicklist, 'Industry picklist should not be null');
        // Additional assertions
        for (Map<String, String> entry : industryPicklist) {
            System.assertNotEquals(null, entry.get('value'), 'Industry picklist value should not be null');
            System.assertNotEquals(null, entry.get('label'), 'Industry picklist label should not be null');
        }
    }

    @isTest
    static void testGetAcountRegion() {
        Test.startTest();
        List<Map<String, String>> regionPicklist = FileredDataTableController.getAcountRegion();
        Test.stopTest();
        
        System.assertNotEquals(null, regionPicklist, 'Region picklist should not be null');
      
        for (Map<String, String> entry : regionPicklist) {
            System.assertNotEquals(null, entry.get('value'), 'Region picklist value should not be null');
            System.assertNotEquals(null, entry.get('label'), 'Region picklist label should not be null');
        }
    }

    @isTest
    static void testGetFilteredAccounts() {
        Test.startTest();
        List<Account> filteredAccounts = FileredDataTableController.getFilteredAccounts(null, null, null, null);
        Test.stopTest();
        
        System.assertNotEquals(null, filteredAccounts, 'Filtered accounts should not be null');
       
        for (Account acc : filteredAccounts) {
            System.assertNotEquals(null, acc.Id, 'Filtered Account Id should not be null');
            System.assertNotEquals(null, acc.Name, 'Filtered Account Name should not be null');
            // Add more assertions as needed for other fields
        }
    }

    @isTest
    static void testCreateContacts() {
        Account testAccount = new Account(Name='Test Account',
                                         Industry='Accounting',
                                         Region__c='North'
                                        );
        insert testAccount;

        Map<String, Object> contactInfo = new Map<String, Object>();
        contactInfo.put('contactId', null);
        contactInfo.put('First_Name', 'John');
        contactInfo.put('Last_Name', 'Doe');
        contactInfo.put('JobTitle', 'Engineer');
        contactInfo.put('EmailId', 'john.doe@example.com');
        contactInfo.put('Company', 'Test Company');
        contactInfo.put('website', 'www.example.com');

        List<Map<String, Object>> kcontacts = new List<Map<String, Object>>();
        kcontacts.add(contactInfo);

        // Create Kanlet_License__c record
        Kanlet_License__c kanletLicense = new Kanlet_License__c(
            Customer_id__c = 2,
            User_Unique_Id__c = 2
        );
        insert kanletLicense;

        // Create a Track Request record
        Track_Request__c trackRequest = new Track_Request__c(
            Kanlet_Configuration__c=kanletLicense.Id
        );
        insert trackRequest;

        Test.startTest();
        String result = FileredDataTableController.createContacts(kcontacts, null, trackRequest.Id);
        Test.stopTest();
        System.assertEquals('Success', result, 'Contact creation should be successful');

        List<K_Contact__c> createdKContacts = [SELECT Id, Contact__c FROM K_Contact__c ];
        System.assertNotEquals(0, createdKContacts.size(), 'At least one K_Contact__c should be created');

        for (K_Contact__c kContact : createdKContacts) {
             }
    }

    
    @isTest
    static void testGetFilteredAccountsWithException() {
        Test.startTest();
        
        List<Account> filteredAccounts = FileredDataTableController.getFilteredAccounts('InvalidIndustry', null, null, null);
        Test.stopTest();
        System.assertNotEquals(null, filteredAccounts, 'Filtered accounts should not be null');
     
    }
}