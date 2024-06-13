@isTest
public class GetKeyContact_ResWrapTest {
    @isTest
    static void testParse() {
        // Define a sample JSON string
        String jsonString = '{' +
            '"status": true,' +
            '"data": {' +
                '"customer_id": 1,' +
                '"customer_name": "Acme Corporation",' +
                '"user_unique_id": 123,' +
                '"industry": ["Technology", "Software"],' +
                '"location_city": ["San Francisco"],' +
                '"location_state": ["California"],' +
                '"location_country": ["USA"],' +
                '"employee_count": ["100-500"],' +
                '"revenue": ["10M-50M"],' +
                '"job_title_function": ["Engineering", "Sales"],' +
                '"job_title_seniority": ["Manager", "Director"],' +
                '"job_title": ["Software Engineer", "Sales Manager"],' +
                '"last_funding_status": ["Series A"],' +
                '"tech_stack": ["Java", "Salesforce"]' +
            '},' +
            '"message": "Data retrieved successfully",' +
            '"status_code": 200,' +
            '"errors": null' +
        '}';

        // Deserialize the JSON string
        GetKeyContact_ResWrap respWrap = GetKeyContact_ResWrap.parse(jsonString);

        // Perform assertions
//System.assertNotNull(respWrap);
        System.assertEquals(true, respWrap.status);
        System.assertEquals(200, respWrap.status_code);
        System.assertEquals('Data retrieved successfully', respWrap.message);
        //System.assertNotNull(respWrap.data);

        GetKeyContact_ResWrap.Data data = respWrap.data;
        System.assertEquals(1, data.customer_id);
        System.assertEquals('Acme Corporation', data.customer_name);
        System.assertEquals(123, data.user_unique_id);
        System.assertEquals(2, data.industry.size());
        System.assertEquals('Technology', data.industry[0]);
        System.assertEquals('Software', data.industry[1]);
        System.assertEquals(1, data.location_city.size());
        System.assertEquals('San Francisco', data.location_city[0]);
        System.assertEquals(1, data.location_state.size());
        System.assertEquals('California', data.location_state[0]);
        System.assertEquals(1, data.location_country.size());
        System.assertEquals('USA', data.location_country[0]);
        System.assertEquals(1, data.employee_count.size());
        System.assertEquals('100-500', data.employee_count[0]);
        System.assertEquals(1, data.revenue.size());
        System.assertEquals('10M-50M', data.revenue[0]);
        System.assertEquals(2, data.job_title_function.size());
        System.assertEquals('Engineering', data.job_title_function[0]);
        System.assertEquals('Sales', data.job_title_function[1]);
        System.assertEquals(2, data.job_title_seniority.size());
        System.assertEquals('Manager', data.job_title_seniority[0]);
        System.assertEquals('Director', data.job_title_seniority[1]);
        System.assertEquals(2, data.job_title.size());
        System.assertEquals('Software Engineer', data.job_title[0]);
        System.assertEquals('Sales Manager', data.job_title[1]);
        System.assertEquals(1, data.last_funding_status.size());
        System.assertEquals('Series A', data.last_funding_status[0]);
        System.assertEquals(2, data.tech_stack.size());
        System.assertEquals('Java', data.tech_stack[0]);
        System.assertEquals('Salesforce', data.tech_stack[1]);
    }
}