
create database mini_bank;
go
use mini_bank;

--------------------------------------------------------------------------------------------------
--Creation of Tables------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
create table UserLogins
	(
	UserLoginID smallint primary key not null identity(1,1),
	UserLogin char(15) not null,
	UserPassword varchar(20) not null
	);	 
--------------------------------------------------------------------------------------------------
create table AccountType
	(
	AccountTypeID tinyint primary key not null identity (1,1),
	AccountTypeDescription varchar(30) null
	);
--------------------------------------------------------------------------------------------------
create table AccountStatusType
	(
	AccountStatusTypeID tinyint primary key not null identity(5,1),
	AccountStatusDescription varchar(30) null
	);
--------------------------------------------------------------------------------------------------
create table LoginErrorLog
	(
	ErrorLogID int primary key not null identity(1000,1),
	ErrorTime datetime null,
	FailedTransactionXML xml null
	);
--------------------------------------------------------------------------------------------------
create table Employee
	(
	EmployeeID int primary key not null identity(1,1),
	EmployeeFirstName varchar(25),
	EmployeeMiddleInitial char(1) null,
	EmployeeLastName varchar(25) not null,
	EmployeeIsManager bit null	
	);
--------------------------------------------------------------------------------------------------
create table UserSecurityQuestions
	(
	UserSecurityQuestionID tinyint primary key not null identity(1,1),
	UserSecurityQuestion varchar(50) null
	);
--------------------------------------------------------------------------------------------------
Create table FailedTransactionErrorType
	(
	FailedTransactionErrorTypeID tinyint primary key not null identity(1,1),
	FailedTransactionDescription varchar(50) not null
	);
--------------------------------------------------------------------------------------------------
Create table SavingsInterestRates
	(
	InterestSavingsRateID tinyint primary key not null identity(5,1),
	InterestRateValue numeric(9,9) not null,
	InterestRateDescription varchar(20) null
	);
--------------------------------------------------------------------------------------------------
create table TransactionType
	(
	TransactionTypeID tinyint primary key not null identity(9,1),
	TransactionTypeName char(10) not null,
	TransactionTypeDescription varchar(50) null,
	TransactionFeeAmount smallmoney null	
	);
--------------------------------------------------------------------------------------------------
create table UserSecurityAnswears
	(
	UserLoginID smallint primary key not null references UserLogins(UserLoginID),
	UserSecurityAnswear varchar(25) not null,
	UserSecurityQuestionID tinyint not null
	);
--------------------------------------------------------------------------------------------------
create table FailedTransactionLog
	(
	FailedTransactioID int primary key not null,
	FailedTransactionErrorTypeID tinyint not null references 
		FailedTransactionErrorType(FailedTransactionErrorTypeID),
	FailedTransactionErrorTime datetime null,
	FailedTransactionXML xml not null
	);
--------------------------------------------------------------------------------------------------
create table Account
	(
	AccountID int primary key not null,                
	CurrentBalance money null,              
	AccountTypeID tinyint not null references AccountType(AccountTypeID),
	AccountStatusTypeID tinyint not null references AccountStatusType(AccountStatusTypeID), 
	InterestSavingsRateID tinyint null references SavingsInterestRates(InterestSavingsRateID)                                       
	);
--------------------------------------------------------------------------------------------------
create table Customer
	(
	CustomerID int primary key not null identity(6,1),
	AccountID int not null references Account(AccountID),
	UserLoginID smallint not null references UserLogins(UserLoginID),
	CustomerAdress1 varchar(30) not null,
	CustomerAdress2 varchar(30) null,
	CustomerFirstName varchar(30) not null,
	CustomerMiddleInitial varchar(1) null,
	CustomerLastName varchar(30) not null,
	City varchar(20) not null,
	State char(2) not null,
	Zipcode char(10) not null,
	EmailAddress varchar(40) not null,
	HomePhone char(10) null,
	CellPhone char(10) null,
	WorkPhone char(10) null,
	SSN char(9) not null
	);
--------------------------------------------------------------------------------------------------
create table LoginAccount
	(
	UserLoginID smallint not null references UserLogins(UserLoginID),
	AccountID int not null references Account(AccountID)
	);
--------------------------------------------------------------------------------------------------
create table CustomerAccount
	(
	AccountID int not null references Account(AccountID),
	CustomerID int not null references Customer(CustomerID),
	);
--------------------------------------------------------------------------------------------------
create table TransactionLog
	(
	TransactionID int primary key not null identity(1,1),
	TransactionDate datetime null,
	TransactionTypeID tinyint not null references TransactionType(TransactionTypeID),
	AccountID int not null references Account(AccountID),
	CustomerID int not null references Customer(CustomerID),
	EmployeeID int not null references Employee(EmployeeID),
	UserLoginID smallint not null references UserLogins(UserLoginID),
	TransactionAmount money null,
	NewBalance money null
	);
--------------------------------------------------------------------------------------------------
create table OverDraftLog
	(
	AccountID int primary key not null references Account(AccountID),
	OverDraftDate datetime null,
	OverDraftAmount money null,
	OverDraftTransactionXML xml null
	);
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--Insert of Data Into the Tables------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
insert into UserLogins (UserLogin, UserPassword)
values ('User1', 'User1'),
	   ('User2', 'User2'),
	   ('User3', 'User3'),
	   ('User4', 'User4'),
	   ('User5', 'User5');
--------------------------------------------------------------------------------------------------
insert into AccountType (AccountTypeDescription)
values ('Savings'),
	   ('Checking'),
	   ('Bussiness'),
	   ('BussinessUSD'),
	   ('BussinessGBP');
--------------------------------------------------------------------------------------------------
insert into AccountStatusType (AccountStatusDescription)
values ('Closed'),
	   ('Active'),
	   ('On Hold'),
	   ('Disabled'),
	   ('Confiscated');
--------------------------------------------------------------------------------------------------
insert into LoginErrorLog (ErrorTime, FailedTransactionXML)
values ('20170505 10:34:15', 'Failed Login'),
	   ('20170606 11:35:15', 'Bad Connection'),
	   ('20170707 12:36:16', 'Closed for Bussiness'),
	   (getdate(), 'Server Maintenance'),
	   (getdate(), 'Too Many Attempts');
--------------------------------------------------------------------------------------------------
insert into Employee(EmployeeFirstName, EmployeeMiddleInitial, EmployeeLastName, EmployeeIsManager)
			         		 
values ('E1','A','E1',0),
	   ('E2','B','E2',1),
	   ('E3','C','E3',0),
	   ('E4','D','E4',1),
	   ('E5','E','E5',0);
--------------------------------------------------------------------------------------------------
insert into UserSecurityQuestions (UserSecurityQuestion)
values ('Name of your first child?'),
	   ('Name of your first pet?'),
	   ('Country of origin?'),
	   ('Your nickname?'),
	   ('Best Dish?');
--------------------------------------------------------------------------------------------------
insert into FailedTransactionErrorType (FailedTransactionDescription)
values ('Withdraw Limit Reached'),
	   ('Technical Error'),
	   ('Wrong PIN'),
	   ('Insufficient Funds'),
	   ('Authorization Decline');
--------------------------------------------------------------------------------------------------
insert into SavingsInterestRates (InterestRateValue, InterestRateDescription)
values (0.05,'Low'),
	   (0.1,'High'),
	   (0.07,'Prime'),
	   (0.04,'Fixed'),
	   (0.025,'Variable');
--------------------------------------------------------------------------------------------------
insert into TransactionType (TransactionTypeName, TransactionTypeDescription, TransactionFeeAmount)
values ('Balance','See Money',0),
	   ('Debit','From Chekings Account',1),
	   ('Credit','Visa or Mastercard',5),
	   ('Overdraft','From Chekings Account',10),
	   ('Deposit','To Chekings Account',0);
--------------------------------------------------------------------------------------------------
insert into UserSecurityAnswears (UserLoginID, UserSecurityAnswear, UserSecurityQuestionID)		
values (1,'Milk',1),
	   (2,'Beer',2),
	   (3,'Honey',3),
	   (4,'Water',4),
	   (5,'Apples',5);
--------------------------------------------------------------------------------------------------
insert into FailedTransactionLog (FailedTransactioID, FailedTransactionErrorTypeID,
			FailedTransactionErrorTime, FailedTransactionXML)
values (1,1,'20180606 16:16:16','First'),
	   (2,2,'20180505 13:13:13','Second'),
	   (3,3,'20180404 14:14:14','Third'),
	   (4,4,'20180303 15:15:15','Fourth'),
	   (5,5,getdate(),'Fifth');
--------------------------------------------------------------------------------------------------
insert into Account (AccountID, CurrentBalance, AccountTypeID, AccountStatusTypeID, 
			InterestSavingsRateID)
values (6, 15000.7, 2,6, 6),
	   (7, 153.5, 2, 6, 5),
	   (8, 9999.9, 1, 7, 8),
	   (9, 0.0, 4, 8, 7),
	   (10, 130000.3, 3, 9, 5);
--------------------------------------------------------------------------------------------------
insert into Customer (AccountID, UserLoginID, CustomerAdress1, CustomerAdress2,
                      CustomerFirstName, CustomerMiddleInitial, CustomerLastName, City,
                      State, Zipcode, EmailAddress, HomePhone, CellPhone, WorkPhone, SSN)					   
values (6, 5, '5 Way', 'N\A', 'User5', 'U', '5User', 'Toronto', 'ON', '3A5z9z',
        'user5@user5.com', '1416555555', '1416555555', '1416555555', '000000000'),
	   (7, 4, '6 Way', 'N\A', 'User4', 'V', '4User', 'Vaughan', 'ON', '5B4x9y',
	    'user4@user5.com', '1416666666', '1416666666', '1416666666', '444444444'),
	   (8, 3, '7 Way', 'N\A', 'User3', 'W', '3User', 'Berrie', 'ON', '6C3y9k',
	    'user3@user5.com', '1416777777', '1416777777', '1416777777', '333333333'),
	   (9, 2, '8 Way', 'N\A', 'User2', 'X', '2User', 'Winnipeg', 'MB', '7D2z9b',
	    'user2@user5.com', '1416888888', '1416888888', '1416888888', '222222222'),
	   (10, 1,'9 Way', 'N\A', 'User1', 'Y', '1User', 'British', 'BC', '8E2t9m',
	    'user1@user5.com', '1416999999', '1416999999', '1416999999', '111111111'); 
--------------------------------------------------------------------------------------------------	 
insert into LoginAccount (UserLoginID, AccountID)
values (5, 6),
	   (4, 7),
	   (3, 8),
	   (2, 9),
	   (1, 10);
--------------------------------------------------------------------------------------------------
insert into CustomerAccount (AccountID, CustomerID)
values (6, 6),
	   (7, 7),
	   (8, 8),
	   (9, 9),
	   (10, 10);
--------------------------------------------------------------------------------------------------
insert into TransactionLog (TransactionDate, TransactionTypeID, AccountID, CustomerID,
							EmployeeID, UserLoginID, TransactionAmount, NewBalance)
values (getdate(), 9, 6, 6, 3, 5, 0, 15000.7),
	   (getdate(), 10, 7, 7, 2, 4, -100, 53.0),
	   (getdate(), 11, 8, 8, 1, 3, -999, 9000),
	   (getdate(), 12, 9, 9, 2, 2, -560, -5),
	   (getdate(), 13, 10, 10, 4, 1, 500, 130500);
--------------------------------------------------------------------------------------------------
insert into OverDraftLog (AccountID, OverDraftDate, OverDraftAmount, OverDraftTransactionXML)
values (6, getdate(), 0, 'Clear'),
       (7, getdate(), 0, 'Clear'),
       (8, getdate(), 0, 'Clear'),
       (9, getdate(), -100, 'Once'),
       (10,getdate(), 0, 'Clear');
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
--Views and Procedures----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

--1. Customers from Ontario with Checking Account-------------------------------------------------

create view Customers_ON_Chekings as
select CustomerLastName, CustomerMiddleInitial, CustomerFirstName, State, AccountTypeDescription       
from Customer, AccountType 
where State = 'ON' and AccountTypeDescription = 'Checking';

--2. Total Balance > 5000 View--------------------------------------------------------------------

create view TotalBalance as
select CustomerLastName, CustomerMiddleInitial , CustomerFirstName,
       (CurrentBalance + CurrentBalance*InterestRateValue) TotalBalance
from Customer C join Account A on C.AccountID = A.AccountID join SavingsInterestRates SIR 
                               on A.InterestSavingsRateID = SIR.InterestSavingsRateID
where (CurrentBalance + CurrentBalance*InterestRateValue) > 5000;

--3. Customers by Account Type---------------------------------------------------------------------

create view AccountTypeCount as
select CustomerLastName, CustomerFirstName, AccountTypeDescription, 
       count(AccountTypeDescription) NumOfAccounts
from Customer C join Account A on C.AccountID = A.AccountID
				join AccountType AT on A.AccountTypeID = AT.AccountTypeID
where AccountTypeDescription = 'Savings' or AccountTypeDescription = 'Checking'
group by CustomerLastName, CustomerFirstName, AccountTypeDescription;

--4. Get Login and Password of a particular customer-----------------------------------------------

create view GetLoginPassword as
select UserLogin, UserPassword
from Account A join LoginAccount LA on A.AccountID = LA.AccountID
			   join UserLogins UL on LA.UserLoginID = UL.UserLoginID
where A.AccountID = 10;

--5. Customers with Overdraft----------------------------------------------------------------------

create view Overdraft as
select CustomerLastNAme, CustomerMiddleInitial, CustomerFirstName, OverDraftAmount
from OverDraftLog, Customer
where OverDraftAmount < 0 and OverDraftLog.AccountID = Customer.AccountID
group by CustomerLastNAme, CustomerMiddleInitial, CustomerFirstName, OverDraftAmount;

--6. Add prefix to login of every user--------------------------------------------------------------

create procedure AddPrefix
    @Prefix varchar(30)  
as
    update UserLogins  
	set UserLogin = concat(@Prefix, UserLogin)
	select * from UserLogins;                     
go
execute AddPrefix 'User_';

--7. Get the full name of a customer---------------------------------------------------------------

create procedure Customer_FullName
    @ID int 
as    
	select CustomerLastName, CustomerMiddleInitial, CustomerFirstName
	from Customer C, Account A
	where A.AccountID = C.AccountID and C.AccountID = @ID;
go
execute Customer_FullName 8;

--8. Login errors in the past 24 hours------------------------------------------------------------

create procedure ErrorLogsLast24
as
	select * from LoginErrorLog
	where ErrorTime < getdate() and ErrorTime > dateadd(hour, -24, getdate());
go
execute ErrorLogsLast24;

--9. Deposit money into customers account---------------------------------------------------------

create procedure Deposit
    @Amount money, @ID int 
as 
	update Account  
	set CurrentBalance = CurrentBalance + @Amount
	where AccountID = @ID;
go
execute Deposit 100, 8;

--10. Withdraw money from customers account-------------------------------------------------------

create procedure Withdrawal
    @Amount money, @ID int 
as 
	update Account  
	set CurrentBalance = CurrentBalance - @Amount
	where AccountID = @ID;
go
execute Withdrawal 100, 8;

--11. Remove security question---------------------------------------------------------------------

create procedure RemoveQuestion
    @Login varchar(25) 
as
	delete USQ from UserSecurityQuestions USQ join UserSecurityAnswears USA 
			on USQ.UserSecurityQuestionID = USA.UserSecurityQuestionID
            join UserLogins  UL on USA.UserLoginID = UL.UserLoginID 
	where UL.UserLogin = @Login;
go
execute RemoveQuestion 'User_User4';

--12. Drop column---------------------------------------------------------------------------------

alter table Customer drop column SSN;

--End---------------------------------------------------------------------------------------------