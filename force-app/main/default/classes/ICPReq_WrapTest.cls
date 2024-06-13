@isTest
public class ICPReq_WrapTest {

    @isTest
    static void testICPReq_Wrap() {
        // Create an instance of ICPReq_Wrap
        ICPReq_Wrap wrapper = new ICPReq_Wrap();
        ICPReq_Wrap.Data data = new ICPReq_Wrap.Data();

        // Populate the data fields
        data.customer_id = 1;
        data.customer_name = 'ACME Corporation';
        data.user_unique_id = 123;
        data.industry = new List<String>{'Tech', 'Finance'};
        data.location_city = new List<String>{'New York', 'San Francisco'};
        data.location_state = new List<String>{'NY', 'CA'};
        data.location_country = new List<String>{'USA'};
        data.employee_count = new List<String>{'1000-5000'};
        data.revenue = new List<String>{'$100M+'};
        data.job_title_function = new List<String>{'Engineer', 'Manager'};
        data.job_title_seniority = new List<String>{'Junior', 'Senior'};
        data.job_title = new List<String>{'Software Developer', 'Product Manager'};
        data.last_funding_status = new List<String>{'Series C'};
        data.tech_stack = new List<String>{'Java', 'Python'};

        // Assign data to wrapper
        wrapper.data = data;

        // Serialize to JSON
        String json = JSON.serialize(wrapper);

        // Print the JSON (Optional: Print for verification in debug log)
        System.debug('Serialized JSON: ' + json);

        // Deserialize back to object
        ICPReq_Wrap deserializedWrapper = ICPReq_Wrap.parse(json);

        // Verify the deserialized fields
        System.assertEquals(wrapper.data.customer_id, deserializedWrapper.data.customer_id);
        System.assertEquals(wrapper.data.customer_name, deserializedWrapper.data.customer_name);
        System.assertEquals(wrapper.data.user_unique_id, deserializedWrapper.data.user_unique_id);
        System.assertEquals(wrapper.data.industry, deserializedWrapper.data.industry);
        System.assertEquals(wrapper.data.location_city, deserializedWrapper.data.location_city);
        System.assertEquals(wrapper.data.location_state, deserializedWrapper.data.location_state);
        System.assertEquals(wrapper.data.location_country, deserializedWrapper.data.location_country);
        System.assertEquals(wrapper.data.employee_count, deserializedWrapper.data.employee_count);
        System.assertEquals(wrapper.data.revenue, deserializedWrapper.data.revenue);
        System.assertEquals(wrapper.data.job_title_function, deserializedWrapper.data.job_title_function);
        System.assertEquals(wrapper.data.job_title_seniority, deserializedWrapper.data.job_title_seniority);
        System.assertEquals(wrapper.data.job_title, deserializedWrapper.data.job_title);
        System.assertEquals(wrapper.data.last_funding_status, deserializedWrapper.data.last_funding_status);
        System.assertEquals(wrapper.data.tech_stack, deserializedWrapper.data.tech_stack);
    }
}