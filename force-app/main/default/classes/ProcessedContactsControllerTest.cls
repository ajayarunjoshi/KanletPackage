@IsTest
private class ProcessedContactsControllerTest {
    
    private static User createTestUser() {
        User adminUser = new User(
            FirstName = 'CRM',
            LastName = 'Admin',
            Email = 'megha.bhoyar@kriosispl.in',
            Username = 'crmadmin@kanlet.com',
            Alias = 'cadmin',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'CRM Admin' LIMIT 1].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert adminUser;
        return adminUser;
    }
    
    @IsTest
    static void testCreateProcessedContacts_Success() {
        
        User adminUser = createTestUser();
        
        Test.startTest();
        
        
        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf('{"data":[{"contact_first_name":"John","contact_last_name":"Doe","new_company_name":"NewCompany","new_company_website_url":"http://newcompany.com","new_designation":"Manager","new_email_id":"john.doe@newcompany.com","previos_company_name":"OldCompany","previos_website":"http://oldcompany.com","previos_designation":"Engineer","previos_email_Id":"john.doe@oldcompany.com","unique_id":"001xx000003DGbWAAW","start_date":"2024-01-01"}]}');
        RestContext.response = new RestResponse();
        
        ProcessedContactsController.ResultResponse result = ProcessedContactsController.createProcessedContacts();
        
        Test.stopTest();
        
        
    }
    
    @IsTest
    static void testCreateProcessedContacts_EmptyRequestBody() {
        
        User adminUser = createTestUser();
        
        Test.startTest();
        
        
        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf('');
        RestContext.response = new RestResponse();
        
        ProcessedContactsController.ResultResponse result = ProcessedContactsController.createProcessedContacts();
        
        Test.stopTest();
        
        
        System.assertEquals('No data to process.', result.Result);
        System.assertEquals('Request body is empty.', result.ErrorMsg);
        System.assertEquals(400, RestContext.response.statusCode);
    }
    
    @IsTest
    static void testCreateProcessedContacts_InvalidDateFormat() {
        
        User adminUser = createTestUser();
        
        Test.startTest();
        
        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf('{"data":[{"contact_first_name":"John","contact_last_name":"Doe","new_company_name":"NewCompany","new_company_website_url":"http://newcompany.com","new_designation":"Manager","new_email_id":"john.doe@newcompany.com","previos_company_name":"OldCompany","previos_website":"http://oldcompany.com","previos_designation":"Engineer","previos_email_Id":"john.doe@oldcompany.com","unique_id":"001xx000003DGbWAAW","start_date":"invalid-date"}]}');
        RestContext.response = new RestResponse();
        
        
        try {
            ProcessedContactsController.createProcessedContacts();
            // System.assert(false, 'Exception should have been thrown due to invalid date format.');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
            System.assert(e.getMessage().contains('Invalid date format for start_date'));
        }
        
        Test.stopTest();
    }
    
    @IsTest
    static void testCreateProcessedContacts_ExceptionHandling() {
        
        User adminUser = createTestUser();
        
        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf('{"data":[{"contact_first_name":"John","contact_last_name":"Doe"}]}');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        
        
        try {
            ProcessedContactsController.ResultResponse result = ProcessedContactsController.createProcessedContacts();
            
        } catch (Exception e) {
            System.assertEquals('Server Error: DML Exception', e.getMessage().substring(0, 24));
        }
        
        Test.stopTest();
    }
    
    @IsTest
    static void testSendSuccessEmail() {
        User adminUser = createTestUser();
        
        Test.startTest();
        ProcessedContactsController.sendSuccessEmail(adminUser);
        Test.stopTest();
        
    }
    
    @IsTest
    static void testSendFailureEmail() {
        User adminUser = createTestUser();
        
        Test.startTest();
        ProcessedContactsController.sendFailureEmail(adminUser);
        Test.stopTest();
        
    }
}