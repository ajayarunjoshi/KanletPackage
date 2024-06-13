/* Purpose:-This class is written for UploadKeyContactUtil class
* Date:-11-06-2024
*/

@IsTest
public class UploadKeyContactUtil_Test {
    
    @IsTest
    static void testGetContacts() {
        Account testAccount = new Account(Name = 'Test Account', Website = 'https://test.com');
        insert testAccount;

        testAccount = [SELECT Name, Website FROM Account WHERE Id = :testAccount.Id];
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User', Email = 'testuser@test.com', AccountId = testAccount.Id, Title='Junior Salesforce Developer');
        insert testContact;

        Kanlet_License__c testKanletConfig = new Kanlet_License__c(
            First_Name__c = 'Shripad',
            Last_Name__c = 'Kulkarni',
            Job_Title__c = 'Salesforce Developer',
            Duration__c = '1 year 0 month',
            Contact_Limit__c = 5,
            Frequency__c = 'Weekly',
            Customer_Id__c = 2,
            User_Unique_Id__c = 2,
            Tracking_Start_Date__c = Date.newInstance(2024, 5, 23),
            Tracking_End_Date__c = Date.newInstance(2025, 5, 22)
        );
        insert testKanletConfig;

        K_Contact__c testKContact = new K_Contact__c(
            Contact__c = testContact.Id,
            Job_Title__c = 'Developer',
            Last_Name__c = 'Kumar',
            First_Name__c = 'Swapnil',
            Company_Name__c = 'Krios Info Solutions'
        );
        insert testKContact;

        Track_Request__c testTrackRequest = new Track_Request__c(
            Kanlet_Configuration__c = testKanletConfig.Id
        );
        insert testTrackRequest;

        Track_Request_Contact__c testTrackRequestContact = new Track_Request_Contact__c(
            Track_Request__c = testTrackRequest.Id, 
            K_Contact__c = testKContact.Id
        );
        insert testTrackRequestContact;

        // Mock HTTP response
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"status": true, "data": [], "message": "Success", "status_code": 200}');
        mockResponse.setStatusCode(200);

        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockImpl(mockResponse));

        // Step 2: Invoke the method to test
        List<String> trackRequestIds = new List<String>{testTrackRequest.Id};
        Test.startTest();
        UploadKeyContactUtil.getContacts(trackRequestIds);
        Test.stopTest();

        System.assert(true, 'getContacts method executed successfully.');
    }
    
    @IsTest
    static void testUploadK() {
        // Step 1: Set up test data
        UploadKContact_RequestWrap reqWrap = new UploadKContact_RequestWrap();
        reqWrap.customer_id = 2;
        reqWrap.user_unique_id = 123;
        reqWrap.contact_first_name = 'John';
        reqWrap.contact_last_name = 'Doe';
        reqWrap.contact_title = 'Manager';
        reqWrap.contact_email = 'john.doe@example.com';
        reqWrap.contact_company_name = 'testAccount.name';
        reqWrap.contact_company_website_url = 'https://testcompany.com';

        List<UploadKContact_RequestWrap> reqWrapList = new List<UploadKContact_RequestWrap>{reqWrap};

        // Step 2: Mock HTTP response
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"status": true, "data": [], "message": "Success", "status_code": 200}');
        mockResponse.setStatusCode(200);

        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockImpl(mockResponse));

        // Step 3: Invoke the method to test
        Test.startTest();
        UploadKContact_ResWrap response = UploadKeyContactUtil.uploadK(reqWrapList);
        Test.stopTest();

        // Step 4: Verify the results
        System.assertEquals(true, response.status);
        System.assertEquals('Success', response.message);
        System.assertEquals(200, response.status_code);
    }
    
    private class HttpCalloutMockImpl implements HttpCalloutMock {
        private HttpResponse response;
        HttpCalloutMockImpl(HttpResponse response) {
            this.response = response;
        }
        public HttpResponse respond(HttpRequest req) {
            return response;
        }
    }
}