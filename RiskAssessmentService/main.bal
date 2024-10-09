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
    int creditScore;
    string creditScoreDate;
    string creditScoreAgency;
    CreditScoreDetails creditScoreDetails;

};

type EmploymentDetails record {
    string employerName;
    string position;
    int annualIncome;
};

type CustomerLoanRecord record {
    string customerId;
    string loanRequestId;
    decimal loanAmount;
    string loanType;
    string applicationDate;
    EmploymentDetails employmentDetails;
    CustomerCreditRecord creditHistory;
};

type RiskFactorsItem record {
    string factor;
    (int|string) value;
    string impact;
};

type LoanRequest record {
    string loanRequestId;
    string riskLevel;
    int riskScore;
    RiskFactorsItem[] riskFactors;
    string recommendation;
};
service /api/risk on new http:Listener(9097) {

    resource function post assessment(CustomerLoanRecord customerLoanDetails) returns LoanRequest {
        string loanRequestId = customerLoanDetails.loanRequestId;
        log:printInfo("Performing risk assessment for Loan Request ID: " + loanRequestId);

        // Mock risk assessment logic
        LoanRequest response = {
            "loanRequestId": loanRequestId,
            "riskLevel": "Medium",
            "riskScore": 65,
            "riskFactors": [
                {
                    "factor": "Credit Score",
                    "value": 680,
                    "impact": "Moderate"
                },
                {
                    "factor": "Loan Amount",
                    "value": 30000,
                    "impact": "High"
                },
                {
                    "factor": "Employment Stability",
                    "value": "Stable",
                    "impact": "Low"
                }
            ],
            "recommendation": "Proceed to approval with standard terms."
        };

        log:printInfo("Fetching Loan Request Approval Response : " + response.toJsonString());

        return response;
    }
}
