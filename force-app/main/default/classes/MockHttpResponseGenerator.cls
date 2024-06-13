@IsTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    private Integer statusCode;
    private String statusMessage;

    public MockHttpResponseGenerator() {
        this.statusCode = 200;
        this.statusMessage = '{"success":1,"fail":0}';
    }

    public MockHttpResponseGenerator(Integer statusCode, String statusMessage) {
        this.statusCode = statusCode;
        this.statusMessage = '{"error":"' + statusMessage + '"}';
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(this.statusCode);
        
        if (this.statusCode == 200) {
            res.setBody('{"success":1,"fail":0}');
        } else {
            res.setBody(this.statusMessage);
        }
        
        return res;
    }
}