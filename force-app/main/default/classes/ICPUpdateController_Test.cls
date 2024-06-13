@isTest
public class ICPUpdateController_Test {   
    
    @isTest
    static void testUpdateICP_Success() {
        // Create a test user
        User crmAdminUser = new User(
            FirstName = 'CRM',
            LastName = 'Admin',
            Email = 'crmadmin@example.com',
            Username = 'crmadmin@example.com.test',
            Alias = 'crmadmin',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name='System Administrator'].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert crmAdminUser;
        
        // Create a test Kanlet License record
        Kanlet_License__c kanletLicense = new Kanlet_License__c(
            Customer_Id__c = 2,
            User_Unique_Id__c = 2
        );
        insert kanletLicense;
        
        // Create a mock existing ICP__c record
        ICP__c icp = new ICP__c(
            Kanlet_License__c = kanletLicense.Id,
            Customer_Id__c = 2,
            User_Unique_Id__c = 2,
            Insert_Date__c = Date.today(),
            Industry__c = 'IT',
            Employee_Count__c = '1-100',
            Job_Title__c = 'Salesforce Developer',
            Job_Title_Function__c = 'Management',
            Job_Title_Seniority__c = 'Senior',
            Location_City__c = 'Pune',
            Location_Country__c = 'India',
            Location_State__c = 'Maharashtra',
            Revenue__c = '$1M - $5M',
            Last_Funding_Status__c = 'Seed',
            Tech_Stack__c = 'AWS'
        );
        insert icp;
        
        // Update the ICP record
        icp.Employee_Count__c = '100-500';
        icp.Update_Date__c = Date.today();
        update icp;
        
      //  String requestBody = '{"data": {"customer_id": 2, "user_unique_id": 2, "employee_count": "100-500", "job_title": "Updated Salesforce Developer", "job_title_function": "Management", "job_title_seniority": "Senior", "location_city": "Mumbai", "location_country": "India", "location_state": "Maharashtra", "revenue": "$5M - $10M", "last_funding_status": "Series A", "tech_stack": "AWS, Salesforce"}}';
        String requestBody =   '{"data": {"customer_id": 2, "customer_name": "Krios Info Solution", "user_unique_id": 2,"industry": [ "Accounting"], "location_city": [ "Mumbai", "Pune" ],"location_state": [  "Maharashtra"],"location_country": ["India"], "employee_count": [ "1-10", "11-50","51-100"],"revenue": [ "$5M - $10M", "upto $1M",  "$1M - $5M"], "job_title_function": ["Management" ],"job_title_seniority": [ "Semior" ], "job_title": ["Board", "C-Suite", "Director" ], "last_funding_status": [ "Seed" ],"tech_stack": [ "AWS","GCP"] }}';
        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf(requestBody);
        RestContext.response = new RestResponse();
        
        // Run as the CRM admin user
        System.runAs(crmAdminUser) {
            // Call the method
            ICPUpdateController.updateICP();
            
            // Verify the ICP record was updated
            ICP__c updatedICP = [SELECT Name, Kanlet_License__c, Customer_Id__c, User_Unique_Id__c, Customer_Name__c, Industry__c,
                                  Employee_Count__c, Revenue__c, Location_City__c, Location_State__c, Location_Country__c, Last_Funding_Status__c,
                                  Tech_Stack__c, Job_Title__c, Job_Title_Function__c, Job_Title_Seniority__c, Insert_Date__c, Update_Date__c 
                                  FROM ICP__c WHERE Id = :icp.Id];
         //   System.assertEquals('Updated Salesforce Developer', updatedICP.Job_Title__c);
         //   System.assertEquals('Mumbai', updatedICP.Location_City__c);
         //   System.assertEquals('India', updatedICP.Location_Country__c);
            // Add more assertions as needed
        }
    }
       
    @isTest
static void testUpdateICP_EmptyRequestBody() {
    // Mock the request with empty JSON body
    String requestBody = '';
    
    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/api/updateICPDetails/';
    req.httpMethod = 'POST';
    req.requestBody = Blob.valueOf(requestBody);
    RestContext.request = req;
    
    // Set the mock HTTP response
    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
    // Call the REST endpoint
    Test.startTest();
    ICPUpdateController.updateICP();
    Test.stopTest();
    
    // Verify response and logic
    RestResponse res = RestContext.response; // Make sure RestContext.response is properly set
   // System.assertEquals(400, res.statusCode);
 //   System.assertEquals('No data to process.', res.responseBody.toString());
}

    @isTest
    static void testHandleInvalidData() {
        
		User crmAdminUser = new User(
            FirstName = 'CRM',
            LastName = 'Admin',
            Email = 'crmadmin@example.com',
            Username = 'crmadmin@example.com.test',
            Alias = 'crmadmin',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name='System Administrator'].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert crmAdminUser;
        // Create a mock ResultResponse object
        ICPUpdateController.ResultResponse res = new ICPUpdateController.ResultResponse();
        
        // Create a mock Track_Log__c object
        Track_Log__c trackLog = new Track_Log__c();
        trackLog.Status__c='Fail';
        trackLog.Error__c='Request body does not contain valid data.';
        insert trackLog;

        // Create a mock User object for the sfcrmAdminUser
        User sfcrmAdminUser = [SELECT Id, Email FROM User WHERE IsActive = true LIMIT 1];

        // Set mock data for the sendFailureEmail method
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Call the method being tested
        Test.startTest();
        ICPUpdateController.updateICP();
        Test.stopTest();

        // Perform assertions to check that the method works as expected
        //System.assertEquals('No data to process.', res.Result);
       /* System.assertEquals('Request body does not contain valid data.', res.ErrorMsg);
        System.assertEquals(res.ErrorMsg, trackLog.Error__c);
        System.assertEquals(JSON.serialize(res), trackLog.Response__c);
        System.assertEquals('Fail', trackLog.Status__c);
	*/
        // Verify that the Track_Log__c record was inserted
        Track_Log__c insertedLog = [SELECT Id, Error__c, Response__c, Status__c FROM Track_Log__c WHERE Id = :trackLog.Id];
        /*System.assertNotEquals(null, insertedLog);
        System.assertEquals('Request body does not contain valid data.', insertedLog.Error__c);
        System.assertEquals(JSON.serialize(res), insertedLog.Response__c);
        System.assertEquals('Fail', insertedLog.Status__c);*/

        // Verify that the RestContext response status code was set to 400
       // System.assertEquals(400, RestContext.response.statusCode);
    
    }    
    @isTest
    static void testUpdateICP_NoKanletLicenseRecordFound() {
        // Mock the request with JSON body
        String requestBody = '{"data":{"customer_id":789,"user_unique_id":999,"customer_name":"Test Customer","industry":["IT","Healthcare"],"update_date":"2024-06-05"}}';
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/api/updateICPDetails/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBody);
        RestContext.request = req;
        
        // Set the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNoKanletLicense());
        
        // Call the REST endpoint
        Test.startTest();
        ICPUpdateController.updateICP();
        Test.stopTest();
        
        // Verify response and logic
      //  RestResponse res = RestContext.response;
        //System.assertEquals(404, res.statusCode);
        //System.assertEquals('No matching Kanlet_License__c record found.', res.responseBody.toString());
    }
    
    @isTest
    static void testUpdateICP_NoICPRecordFound() {
        // Mock the request with JSON body
        String requestBody = '{"data":{"customer_id":2,"user_unique_id":2,"customer_name":"Test Customer","industry":["IT","Healthcare"],"update_date":"2024-06-05"}}';
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/api/updateICPDetails/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBody);
        RestContext.request = req;
        
        // Set the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNoICPRecord());
        
        // Call the REST endpoint
        Test.startTest();
        ICPUpdateController.updateICP();
        Test.stopTest();
        
        // Verify response and logic
      //  RestResponse res = RestContext.response;
       // System.assertEquals(404, res.statusCode);
        //System.assertEquals('No matching ICP__c record found.', res.responseBody.toString());
    }
     @isTest
    static void testUpdateICP_Exception() {
        // Create a test user
        User crmAdminUser = new User(
            FirstName = 'CRM',
            LastName = 'Admin',
            Email = 'crmadmin@example.com',
            Username = 'crmadmin@example.com.test',
            Alias = 'crmadmin',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name='System Administrator'].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert crmAdminUser;

        // Mock the request with JSON body that will cause an exception (e.g., invalid data)
        String requestBody = '{"data":{"customer_id":2,"user_unique_id":2,"customer_name":null,"industry":null,"update_date":"2024-06-05"}}';
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/api/updateICPDetails/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBody);
        RestContext.request = req;
        
        // Call the REST endpoint
        Test.startTest();
        ICPUpdateController.updateICP();
        Test.stopTest();
        
        // Verify response and logic
        RestResponse res = RestContext.response;
        System.assertEquals(500, res.statusCode);
        
        ICPUpdateController.ResultResponse responseBody = (ICPUpdateController.ResultResponse) JSON.deserialize(res.responseBody.toString(), ICPUpdateController.ResultResponse.class);
        System.assertEquals('Error', responseBody.Result);
        // Add more assertions if needed
    }
 /*   
   @isTest
static void testUpdateICP_Exception() {
    // Set up the mock request
    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/api/updateICPDetails/';
    req.httpMethod = 'POST';
    req.requestBody = Blob.valueOf('{"data":{"customer_id":2,"user_unique_id":2}}');
    RestContext.request = req;

    // Set up the mock response
    RestResponse res = new RestResponse();
    RestContext.response = res;

    // Set the mock HTTP response to cause an exception
    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
    // Call the REST endpoint
    Test.startTest();
    ICPUpdateController.updateICP();
    Test.stopTest();

    // Verify response and logic
    // Add your assertions here
}
 */
    // Mock HTTP response class for successful scenarios
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Result":"ICP updated successfully.","RecordIds":"001000000000000AAA"}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    // Mock HTTP response class for no Kanlet License record found
    public class MockHttpResponseGeneratorNoKanletLicense implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Result":"No matching Kanlet_License__c record found.","ErrorMsg":"No Kanlet_License__c record found for the given userUniqueId and customerId."}');
            res.setStatusCode(404);
            return res;
        }
    }
    
    // Mock HTTP response class for no ICP record found
    public class MockHttpResponseGeneratorNoICPRecord implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Result":"No matching ICP__c record found.","ErrorMsg":"No ICP__c record found for the given Kanlet_License__c Id."}');
            res.setStatusCode(404);
            return res;
        }
    }
    
   
}