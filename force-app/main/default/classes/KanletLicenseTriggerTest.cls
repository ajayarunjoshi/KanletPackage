@isTest
public class KanletLicenseTriggerTest {
    @isTest
    static void testKanletLicenseTrigger() {
        // Test before insert
        Kanlet_License__c newLicense = new Kanlet_License__c();
        insert newLicense;
        
        // Retrieve the inserted record
        Kanlet_License__c insertedLicense = [SELECT Id, Is_Updated__c FROM Kanlet_License__c WHERE Id = :newLicense.Id];
        System.assertEquals(false, insertedLicense.Is_Updated__c, 'Is_Updated__c should be false on insert.');

        // Test before update (changing a field other than ICP_Count__c)
        insertedLicense.Is_Updated__c = True;
        update insertedLicense;

        // Retrieve the updated record
        Kanlet_License__c updatedLicense = [SELECT Id, Is_Updated__c FROM Kanlet_License__c WHERE Id = :insertedLicense.Id];
        System.assertEquals(true, updatedLicense.Is_Updated__c, 'Is_Updated__c should be true after first update.');

        // Test before update (changing ICP_Count__c after Is_Updated__c is true)
        updatedLicense.ICP_Count__c = 10;

        // Attempt to update and catch the exception
        Boolean exceptionThrown = false;
        try {
            update updatedLicense;
        } catch (DmlException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('You do not have access to edit this record after it has been updated.'), 
                'Expected error message not found: ' + e.getMessage());
        }
        System.assert(exceptionThrown, 'Exception should have been thrown when updating ICP_Count__c after Is_Updated__c is true.');

        // Test before update (changing ICP_Count__c when Is_Updated__c is false)
        Kanlet_License__c newLicenseForUpdate = new Kanlet_License__c();
        insert newLicenseForUpdate;

        newLicenseForUpdate.ICP_Count__c = 5;
        update newLicenseForUpdate;

        Kanlet_License__c newLicenseUpdated = [SELECT Id, Is_Updated__c FROM Kanlet_License__c WHERE Id = :newLicenseForUpdate.Id];
        System.assertEquals(true, newLicenseUpdated.Is_Updated__c, 'Is_Updated__c should be true after changing ICP_Count__c when it was false.');
    }
}