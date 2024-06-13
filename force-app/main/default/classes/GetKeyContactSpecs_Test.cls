@IsTest
public class GetKeyContactSpecs_Test {
    
    @IsTest
    static void testGetKeyContactSpec_CreateNewICP() {
        // Create a test Kanlet_License__c record
        Kanlet_License__c kanletLicense = new Kanlet_License__c(
            Customer_id__c = 2,
            User_Unique_Id__c = 2
        );
        insert kanletLicense;
        
        // Mock the callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call the GetKeyContactSpec method
        Test.startTest();
        String result = GetKeyContactSpecs.GetKeyContactSpec(kanletLicense.Id);
        Test.stopTest();
        
        // Verify the response
        System.assertEquals('Success', result, 'Expected the method to return Success.');

        // Verify the creation of the ICP__c record
        List<ICP__c> icps = [SELECT Id, Customer_Id__c, User_Unique_Id__c FROM ICP__c WHERE Kanlet_License__c = :kanletLicense.Id];
        System.assertEquals(1, icps.size());
        ICP__c icp = icps[0];
        System.assertEquals(2, icp.Customer_Id__c);
        System.assertEquals(2, icp.User_Unique_Id__c);
    }
    
    @IsTest
    static void testGetKeyContactSpec_UpdateExistingICP() {
        // Create a test Kanlet_License__c record
        Kanlet_License__c kanletLicense = new Kanlet_License__c(
            Customer_id__c = 2,
            User_Unique_Id__c = 2
        );
        insert kanletLicense;
        
        // Create a mock existing ICP__c record
        ICP__c existingIcp = new ICP__c(
            Kanlet_License__c = kanletLicense.Id,
            Insert_date__c = Date.today(),
            Customer_Id__c = 2,
            User_Unique_Id__c = 2
        );
        insert existingIcp;
        
        // Mock the callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call the GetKeyContactSpec method
        Test.startTest();
        String result = GetKeyContactSpecs.GetKeyContactSpec(kanletLicense.Id);
        Test.stopTest();
        
        // Verify the response
        System.assertEquals('Success', result, 'Expected the method to return Success.');

        // Verify the update of the existing ICP__c record
        List<ICP__c> icps = [SELECT Id, Customer_Id__c, User_Unique_Id__c FROM ICP__c WHERE Kanlet_License__c = :kanletLicense.Id];
        System.assertEquals(1, icps.size());
        ICP__c icp = icps[0];
        System.assertEquals(2, icp.Customer_Id__c);
        System.assertEquals(2, icp.User_Unique_Id__c);
    }
    
    // Mock HttpResponse class for testing callouts
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status": true, "data": {"customer_id": 2, "user_unique_id": 2, "employee_count": ["100"], "industry": ["Tech"], "job_title": ["CEO"], "job_title_function": ["Management"], "job_title_seniority": ["Senior"], "last_funding_status": ["Series A"], "location_city": ["San Francisco"], "location_country": ["USA"], "location_state": ["CA"], "revenue": ["10M"], "tech_stack": ["Apex"], "customer_name": "Example Customer"}}');
            res.setStatusCode(200);
            return res;
        }
    }
}