import ballerina/http;
import ballerina/log;

type CustomerFaultRecord record {
    string customerId;
    string fraudCheckStatus;
    int fraudScore;
    anydata[] fraudAlerts;
};

type RequestPayload record {
    string customerId;
};
service /api/fraud on new http:Listener(9093) {

    resource function post .(@http:Payload RequestPayload payload) returns CustomerFaultRecord {
        log:printInfo("Performing fraud check for Customer ID: " + payload.customerId);

        // Mock fraud check
        CustomerFaultRecord response = {
            "customerId": payload.customerId,
            "fraudCheckStatus": "Clear",
            "fraudScore": 0,
            "fraudAlerts": []
        };

        log:printInfo("Fetched customer Fraud details" + response.toString());

        return response;
    }
}

