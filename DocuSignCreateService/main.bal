import ballerina/log;
import ballerina/http;

service /api/docusign on new http:Listener(9098) {
   
   // Mock service to create load document with Docusign
    resource function post create() returns string {
        string response = "Loan Document created in Docusign";
        log:printInfo(response);
        return response;
    }
}
