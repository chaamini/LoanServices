import ballerina/http;
import ballerina/log;

type CreditScoreDetails record {
    int paymentHistory;
    int amountsOwed;
    int lengthOfCreditHistory;
    int newCredit;
    int creditMix;
};

type CustomerCreditRecord record {
    string customerId;
    int creditScore;
    string creditScoreDate;
    string creditScoreAgency;
    CreditScoreDetails creditScoreDetails;
};

type RequestPayload record {
    string customerId;
};

service /api/credit on new http:Listener(9094) {

    resource function post score(@http:Payload RequestPayload payload) returns CustomerCreditRecord {
        log:printInfo("Fetching credit score for Customer ID: " +  payload.customerId);

        // Mock credit score retrieval
        CustomerCreditRecord response = {
            "customerId": payload.customerId,
            "creditScore": 680,
            "creditScoreDate": "2024-04-28",
            "creditScoreAgency": "Experian",
            "creditScoreDetails": {
                "paymentHistory": 40,
                "amountsOwed": 25,
                "lengthOfCreditHistory": 20,
                "newCredit": 10,
                "creditMix": 5
            }
        };

        log:printInfo("Fetched customer Credit score details" + response.toJsonString());

        return response;
    }
}
