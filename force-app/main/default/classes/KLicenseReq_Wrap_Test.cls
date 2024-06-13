@IsTest
private class KLicenseReq_Wrap_Test {

    @IsTest
    static void testParse() {
        // Test JSON string to deserialize
        String json = '{' +
            '"data": {' +
                '"customer_id": 123,' +
                '"user_unique_id": 456,' +
                '"user_first_name": "John",' +
                '"user_last_name": "Doe",' +
                '"user_title": "Manager",' +
                '"tracking_start_date": "2024-01-01",' +
                '"tracking_end_date": "2024-12-31",' +
                '"duration": "12 months",' +
                '"contact_limit": 100,' +
                '"frequency": "monthly"' +
            '}' +
        '}';
        
        // Deserialize the JSON string
        KLicenseReq_Wrap wrapper = KLicenseReq_Wrap.parse(json);
        
        // Verify the deserialized object
        System.assertEquals(123, wrapper.data.customer_id);
        System.assertEquals(456, wrapper.data.user_unique_id);
        System.assertEquals('John', wrapper.data.user_first_name);
        System.assertEquals('Doe', wrapper.data.user_last_name);
        System.assertEquals('Manager', wrapper.data.user_title);
        System.assertEquals('2024-01-01', wrapper.data.tracking_start_date);
        System.assertEquals('2024-12-31', wrapper.data.tracking_end_date);
        System.assertEquals('12 months', wrapper.data.duration);
        System.assertEquals(100, wrapper.data.contact_limit);
        System.assertEquals('monthly', wrapper.data.frequency);
    }
    
    @IsTest
    static void testSerialize() {
        // Create an instance of KLicenseReq_Wrap
        KLicenseReq_Wrap wrapper = new KLicenseReq_Wrap();
        wrapper.data = new KLicenseReq_Wrap.Data();
        wrapper.data.customer_id = 123;
        wrapper.data.user_unique_id = 456;
        wrapper.data.user_first_name = 'John';
        wrapper.data.user_last_name = 'Doe';
        wrapper.data.user_title = 'Manager';
        wrapper.data.tracking_start_date = '2024-01-01';
        wrapper.data.tracking_end_date = '2024-12-31';
        wrapper.data.duration = '12 months';
        wrapper.data.contact_limit = 100;
        wrapper.data.frequency = 'monthly';
        
        // Serialize the wrapper object to JSON
        String serialized = JSON.serialize(wrapper);
        
        // Deserialize the serialized JSON back into an object
        KLicenseReq_Wrap deserialized = (KLicenseReq_Wrap) JSON.deserialize(serialized, KLicenseReq_Wrap.class);
        
        // Verify the deserialized object
        System.assertEquals(123, deserialized.data.customer_id);
        System.assertEquals(456, deserialized.data.user_unique_id);
        System.assertEquals('John', deserialized.data.user_first_name);
        System.assertEquals('Doe', deserialized.data.user_last_name);
        System.assertEquals('Manager', deserialized.data.user_title);
        System.assertEquals('2024-01-01', deserialized.data.tracking_start_date);
        System.assertEquals('2024-12-31', deserialized.data.tracking_end_date);
        System.assertEquals('12 months', deserialized.data.duration);
        System.assertEquals(100, deserialized.data.contact_limit);
        System.assertEquals('monthly', deserialized.data.frequency);
    }
}