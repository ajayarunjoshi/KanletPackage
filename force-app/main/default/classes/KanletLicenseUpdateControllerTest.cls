@IsTest
public class KanletLicenseUpdateControllerTest {
    @IsTest
    static void testUpdateKLicense_Success() {
        // Setup test data
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
        
        Kanlet_License__c kanletLicense = new Kanlet_License__c(
            User_Unique_Id__c = 1234,
            Customer_id__c = 5678,
            Contact_Limit__c = 100,
            First_Name__c = 'Test',
            Last_Name__c = 'User',
            Job_Title__c = 'Manager',
            Frequency__c = 'Monthly',
            Duration__c = '1 Year',
            Tracking_Start_Date__c = Date.today(),
            Tracking_End_Date__c = Date.today().addYears(1)
        );
        insert kanletLicense;

        // Create test request body
        String requestBody = '{"data": {"customer_id": 5678, "user_unique_id": 1234, "contact_limit": 200, "user_first_name": "Updated", "user_last_name": "User", "user_title": "Updated Manager", "frequency": "Weekly", "duration": "6 Months", "tracking_start_date": "2023-01-01", "tracking_end_date": "2023-07-01"}}';

        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf(requestBody);
        RestContext.response = new RestResponse();

        // Run as the CRM admin user
        System.runAs(crmAdminUser) {
            // Call the method
            KanletLicenseUpdateController.ResultResponse result = KanletLicenseUpdateController.UpdateKLicense();

            // Verify the result
          //  System.assertEquals('Kanlet configuration updated successfully.', result.Result);
          //  System.assertEquals(kanletLicense.Id, result.RecordIds);
            System.assertEquals(200, RestContext.response.statusCode);

            // Verify the record was updated
            Kanlet_License__c updatedLicense = [SELECT Contact_Limit__c, First_Name__c, Last_Name__c, Job_Title__c, Frequency__c, Duration__c, Tracking_Start_Date__c, Tracking_End_Date__c FROM Kanlet_License__c WHERE Id = :kanletLicense.Id];
            System.assertEquals(200, updatedLicense.Contact_Limit__c);
            System.assertEquals('Updated', updatedLicense.First_Name__c);
            System.assertEquals('User', updatedLicense.Last_Name__c);
            System.assertEquals('Updated Manager', updatedLicense.Job_Title__c);
            System.assertEquals('Weekly', updatedLicense.Frequency__c);
            System.assertEquals('6 Months', updatedLicense.Duration__c);
            System.assertEquals(Date.valueOf('2023-01-01'), updatedLicense.Tracking_Start_Date__c);
            System.assertEquals(Date.valueOf('2023-07-01'), updatedLicense.Tracking_End_Date__c);
        }
    }

    @IsTest
    static void testUpdateKLicense_EmptyRequestBody() {
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

        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf('');
        RestContext.response = new RestResponse();

        System.runAs(crmAdminUser) {
            KanletLicenseUpdateController.ResultResponse result = KanletLicenseUpdateController.UpdateKLicense();

          // System.assertEquals('No data to process.', result.Result);
           // System.assertEquals('Request body is empty.', result.ErrorMsg);
            System.assertEquals(400, RestContext.response.statusCode);
        }
    }

    @IsTest
    static void testUpdateKLicense_InvalidRequestBody() {
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

        String requestBody = '{}';

        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf(requestBody);
        RestContext.response = new RestResponse();

        System.runAs(crmAdminUser) {
            KanletLicenseUpdateController.ResultResponse result = KanletLicenseUpdateController.UpdateKLicense();

        //    System.assertEquals('No data to process.', result.Result);
        //    System.assertEquals('Request body does not contain valid data.', result.ErrorMsg);
            System.assertEquals(400, RestContext.response.statusCode);
        }
    }

    @IsTest
    static void testUpdateKLicense_MissingCustomerIdOrUserUniqueId() {
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

        String requestBody = '{"data": {"customer_id": null, "user_unique_id": null, "contact_limit": 200, "user_first_name": "Updated", "user_last_name": "User", "user_title": "Updated Manager", "frequency": "Weekly", "duration": "6 Months", "tracking_start_date": "2023-01-01", "tracking_end_date": "2023-07-01"}}';

        RestContext.request = new RestRequest();
        RestContext.request.requestBody = Blob.valueOf(requestBody);
        RestContext.response = new RestResponse();

        System.runAs(crmAdminUser) {
            KanletLicenseUpdateController.ResultResponse result = KanletLicenseUpdateController.UpdateKLicense();

       //     System.assertEquals('Invalid data.', result.Result);
        //    System.assertEquals('customer_id and user_unique_id should not be null.', result.ErrorMsg);
            System.assertEquals(400, RestContext.response.statusCode);
        }
    }
}