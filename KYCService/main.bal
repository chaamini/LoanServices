import ballerina/data.xmldata;
import ballerina/http;
import ballerina/log;
import ballerina/time;

type Document record {
    string \#content;
    @xmldata:Attribute
    string 'type;
};

type DocumentsVerified record {
    Document[] document;
};

type KYCResponse record {
    string customerId;
    string kycStatus;
    string verificationDate;
    DocumentsVerified documentsVerified;
};

type RequestPayload record {
    string customerId;
};
service /api/kyc on new http:Listener(9092) {

    resource function post validate(@http:Payload RequestPayload payload) returns xml|error {
        log:printInfo("Received KYC Validation Request: " + payload.customerId);

        string kycStatus = "Verified"; // Mock status
        time:Utc currentUtc = time:utcNow();
        string verificationDate = time:utcToString(currentUtc);

        // Mock document verification
        KYCResponse data = {
            customerId: payload.customerId,
            kycStatus: kycStatus,
            verificationDate: verificationDate,
            documentsVerified: {
                document: [
                    { \#content: "Valid", 'type: "Passport" },
                    { \#content: "Valid", 'type: "UtilityBill" }
                ]
            }
        };

        xml response = check xmldata:toXml(data);
        log:printInfo("Fetched customer Verification details" + response.toString());

        return response;
    }
}
