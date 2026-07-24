USE secure_transact_db;

-- ==========================================================
-- MASTER DATA
-- ==========================================================

-- ==========================================================
-- BRANCHES
-- ==========================================================

INSERT INTO branches
(branch_code, branch_name, city, state, country, address)
VALUES
('DB001','Mumbai Main Branch','Mumbai','Maharashtra','India','BKC, Mumbai'),
('DB002','Frankfurt Headquarters','Frankfurt','Hesse','Germany','Taunusanlage 12'),
('DB003','London Branch','London','England','United Kingdom','Winchester House'),
('DB004','Singapore Branch','Singapore','Singapore','Singapore','One Raffles Quay'),
('DB005','New York Branch','New York','New York','USA','Wall Street');



-- ==========================================================
-- ACCOUNT TYPES
-- ==========================================================

INSERT INTO account_types
(account_type_name,minimum_balance,description)
VALUES
('Savings',10000,'Regular Savings Account'),
('Current',25000,'Business Current Account'),
('Salary',0,'Salary Credit Account'),
('Fixed Deposit',50000,'Fixed Deposit Account');



-- ==========================================================
-- CURRENCIES
-- ==========================================================

INSERT INTO currencies
(currency_code,currency_name,currency_symbol)
VALUES
('INR','Indian Rupee','₹'),
('USD','US Dollar','$'),
('EUR','Euro','€'),
('GBP','British Pound','£'),
('SGD','Singapore Dollar','S$');



-- ==========================================================
-- TRANSACTION TYPES
-- ==========================================================

INSERT INTO transaction_types
(transaction_type_name,description)
VALUES
('Deposit','Cash Deposit'),
('Withdrawal','Cash Withdrawal'),
('UPI','Unified Payments Interface'),
('NEFT','National Electronic Funds Transfer'),
('RTGS','Real Time Gross Settlement'),
('IMPS','Immediate Payment Service'),
('SWIFT','International Wire Transfer'),
('ATM','ATM Withdrawal'),
('POS','Card Swipe Purchase'),
('Interest Credit','Interest Credit by Bank');



-- ==========================================================
-- VERIFY MASTER DATA
-- ==========================================================

SELECT * FROM branches;

SELECT * FROM account_types;

SELECT * FROM currencies;

SELECT * FROM transaction_types;