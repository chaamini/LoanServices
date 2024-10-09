import ballerina/http;
import ballerina/log;
import ballerina/data.xmldata;

type Geolocation record {
    decimal latitude;
    decimal longitude;
};

type AddressValidationResponse record {
    string customerId;
    string validationStatus;
    Geolocation geolocation;
};

type RequestPayload record {
    string customerId;
};
service /api/address on new http:Listener(9096) {

    resource function post validate(@http:Payload RequestPayload payload) returns xml|error {
        log:printInfo("Validating address for Customer ID: " + payload.customerId);

        // Mock address verification
        AddressValidationResponse validationResponse = {
            customerId: payload.customerId,
            validationStatus: "Verified",
            geolocation: {
                latitude: 61,
                longitude: -0.1419
            }
        };
        
        xml response = check xmldata:toXml(validationResponse);

        log:printInfo("Fetched Address Verification details" + response.toString());

        return response;
    }
}


