@IsTest
public class ProcessContactClassTest {

    @IsTest
    static void testProcessContactClass() {
        // Sample JSON input
        String sampleJson = '{"records":[' +
            '{"attributes":{"type":"Contact","referenceId":"1"},"First_Name__c":"John","Last_Name__c":"Doe","Company__c":"Acme","Company_Website__c":"http://acme.com","New_Company__c":"New Acme","New_Email_Id__c":"john.doe@newacme.com","New_Company_Website__c":"http://newacme.com","New_Designation__c":"Manager"},' +
            '{"attributes":{"type":"Contact","referenceId":"2"},"First_Name__c":"Jane","Last_Name__c":"Smith","Company__c":"TechCorp","Company_Website__c":"http://techcorp.com","New_Company__c":"New TechCorp","New_Email_Id__c":"jane.smith@newtechcorp.com","New_Company_Website__c":"http://newtechcorp.com","New_Designation__c":"Director"}' +
            ']}';

        // Parse the JSON
        ProcessContactClass parsedObject = ProcessContactClass.parse(sampleJson);

        // Verify the records list is not null
        System.assertNotEquals(parsedObject.records, null, 'Records list should not be null');

        // Verify the size of the records list
        System.assertEquals(parsedObject.records.size(), 2, 'There should be 2 records');

        // Verify the content of the first record
        ProcessContactClass.Records record1 = parsedObject.records[0];
        System.assertEquals(record1.attributes.type, 'Contact', 'Type should be Contact');
        System.assertEquals(record1.attributes.referenceId, '1', 'ReferenceId should be 1');
        System.assertEquals(record1.First_Name, 'John', 'First Name should be John');
        System.assertEquals(record1.Last_Name, 'Doe', 'Last Name should be Doe');
        System.assertEquals(record1.Company, 'Acme', 'Company should be Acme');
        System.assertEquals(record1.Company_Website, 'http://acme.com', 'Company Website should be http://acme.com');
        System.assertEquals(record1.New_Company, 'New Acme', 'New Company should be New Acme');
        System.assertEquals(record1.New_Email_Id, 'john.doe@newacme.com', 'New Email Id should be john.doe@newacme.com');
        System.assertEquals(record1.New_Company_Website, 'http://newacme.com', 'New Company Website should be http://newacme.com');
        System.assertEquals(record1.New_Designation, 'Manager', 'New Designation should be Manager');

        // Verify the content of the second record
        ProcessContactClass.Records record2 = parsedObject.records[1];
        System.assertEquals(record2.attributes.type, 'Contact', 'Type should be Contact');
        System.assertEquals(record2.attributes.referenceId, '2', 'ReferenceId should be 2');
        System.assertEquals(record2.First_Name, 'Jane', 'First Name should be Jane');
        System.assertEquals(record2.Last_Name, 'Smith', 'Last Name should be Smith');
        System.assertEquals(record2.Company, 'TechCorp', 'Company should be TechCorp');
        System.assertEquals(record2.Company_Website, 'http://techcorp.com', 'Company Website should be http://techcorp.com');
        System.assertEquals(record2.New_Company, 'New TechCorp', 'New Company should be New TechCorp');
        System.assertEquals(record2.New_Email_Id, 'jane.smith@newtechcorp.com', 'New Email Id should be jane.smith@newtechcorp.com');
        System.assertEquals(record2.New_Company_Website, 'http://newtechcorp.com', 'New Company Website should be http://newtechcorp.com');
        System.assertEquals(record2.New_Designation, 'Director', 'New Designation should be Director');
    }
}