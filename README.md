## Bank Database Design

- When an employee opens an account, performs a transaction on or reactivates an account there must be a record of which employee performed the action.
- Every person who opens a savings account does not get the same rate.
- Because the bank charges an overdraft fee, a record must be maintained on any transaction that causes an account to go into overdraft.
- Extra error information is required to be stored when a transaction fails.  The bank uses this information for fraud detection and to diagnose periodic problems within their networks and applications.
- Customers have a user login to allow them to access all of their accounts. If a user fails a login attempt, for instance because they have forgotten their password, a record of that failed attempt needs to be kept.
- The information for checking and saving accounts is very similar to each other as are the transactions that update those accounts.
- More than one customer is allowed on each account, and any transaction record should reflect which customer made the transaction.

## Column List

| DateOpened | CustomerFirstName | ErrorLogID |
| --- | --- | --- |
| AccountStatus | CustomerMiddleInitial | ErrorTime |
| OpeningBalance | CustomerLastName | UserName |
| CurrentBalance | CustomerAddress1 | FailedTransactionErrorID |
| AccountID | CustomerAddress2 | FailedTransactionXML |
| CustomerID | City | FailedTransactionErrorTime |
| OverdraftAccountID | State | EmployeeID |
| TransactionID | Zipcode | EmployeeFirstName |
| FailedTransactionID | Email | EmployeeMiddleInitial |
| TransactionTypeID | SSN | EmployeeLastName |
| TransactionTypeName | UserLogin | EmployeeIsManager |
| TransactionAmt | UserPassword | AccountReactivationLogID |
| SavingsInterestRate | UserSecurityQuestion | ReactivationDate   |
| TransactionDate | UserSecurityAnswer | UserSecurityQuestion2 |
| TransactionAmount | HomePhone   | UserSecurityQuestionAnswer2 |
| TransactionType | WorkPhone | UserSecurityQuestion3 |
| OldBalance | CellPhone | UserSecurityQuestionAnswer3 |
| NewBalance |   |   |


## Designed Entities

Categorized columns, \* are Primary Keys

| **Account** | **User Security Questions** | **Employee** | **Transaction Type** |
| --- | --- | --- | --- |
| \*AccountID | \*UserSecurityQuestionID | EmployeeID   | \*TransactionTypeID |
| CurrentBalance | UserSecurityQuestion | EmployeeFirstName   | TransactionTypeName |
| AccountType | UserSecurityQuestion2 | EmployeeLastName   | AccountReactivationLogID |
| AccountStatus | UserSecurityQuestion3 | EmployeeMiddleInitial   | **UserSecurityAnswers** |
| **Customer** | TransactionLog | EmployeeIsManager   | \*UserAnswerID |
| \*CustomerID | \*TransactionID | UserLogins | UserSecurityQuestionAnswer |
| CustomerAddress1 | TransactionType | \*UserLogin | UserSecurityQuestionAnswer2   |
| CustomerAddress2 | TransactionDate | UserName   | UserSecurityQuestionAnswer3 |
| CustomerFirstName | DateOpened | UserPassword   | **Over Draft Log** |
| CustomerLastName | ReactivationDate | LoginErrorLog | OverdraftAccountID |
| CustomerMiddleInitial | TransactionAmount | \*ErrorLogID   | **Failed Transaction Log** |
| City, State, Zipcode | TransactionAmt | ErrorTime | \*FailedTransactionID   |
| Email | NewBalance | SavingsInterestRates | FailedTransactionXML, ErrorTime |
| HomePhone | OpeningBalance | SavingsInterestRateID   | **Failed Transaction Error Type** |
| CellPhone | OldBalance | \*SavingsInterestRate | \*FailedTransactionErrorID |
| WorkPhone |   |   | FailedTransactionErrorTime |
| SSN |   |   |   |
