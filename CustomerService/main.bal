import ballerina/http;
import ballerina/log;

type Address record {
    string street;
    string city;
    string county;
    string postcode;
    string country;
};

type EmploymentDetails record {
    string employerName;
    string position;
    int annualIncome;
};

type CreditHistory record {
    int numberOfLatePayments;
    int totalLoans;
    int activeLoans;
};

type CustomerRecord record {
    string customerId;
    string firstName;
    string lastName;
    string dateOfBirth;
    string email;
    string phone;
    Address address;
    EmploymentDetails employmentDetails;
    CreditHistory creditHistory;
};

type RequestPayload record {
    string customerId;
};

service /api/customers on new http:Listener(9091) {

    resource function post .(@http:Payload RequestPayload payload) returns CustomerRecord|error {
        log:printInfo("Fetching details for Customer ID: " + payload.customerId);

        // In a real application, fetch customer details from a database
        // Here, we'll return a mock response

        CustomerRecord customerDetails = {
            "customerId": payload.customerId,
            "firstName": "Alice",
            "lastName": "Smith",
            "dateOfBirth": "1990-08-20",
            "email": "alice.smith@domain.co.uk",
            "phone": "+447700900123",
            "address": {
                "street": "456 High Street",
                "city": "London",
                "county": "Greater London",
                "postcode": "SW1A 1AA",
                "country": "UK"
            },
            "employmentDetails": {
                "employerName": "Innovatech Ltd.",
                "position": "Product Manager",
                "annualIncome": 75000
            },
            "creditHistory": {
                "numberOfLatePayments": 0,
                "totalLoans": 2,
                "activeLoans": 1
            }
        };

        log:printInfo("Fetched customer details" + customerDetails.toJsonString());

        return customerDetails;
    }
}