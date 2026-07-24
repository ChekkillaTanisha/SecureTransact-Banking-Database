USE secure_transact_db;

-- ==========================================
-- TEST 1
-- CHECK ALL CUSTOMERS
-- ==========================================

SELECT * FROM customers;

-- ==========================================
-- TEST 2
-- CHECK ALL ACCOUNTS
-- ==========================================

SELECT * FROM accounts;

-- ==========================================
-- TEST 3
-- CHECK HIGH VALUE TRANSACTIONS
-- ==========================================

SELECT * FROM high_value_transactions;

-- ==========================================
-- TEST 4
-- CUSTOMER ACCOUNT SUMMARY
-- ==========================================

SELECT * FROM customer_account_summary;

-- ==========================================
-- TEST 5
-- EXECUTE STORED PROCEDURE
-- ==========================================

CALL check_balance('DB100000001');

-- ==========================================
-- TEST 6
-- TRANSFER MONEY
-- ==========================================

CALL transfer_funds(
'DB100000001',
'DB100000002',
5000
);

-- ==========================================
-- TEST 7
-- FREEZE ACCOUNT
-- ==========================================

CALL freeze_account('DB100000010');

-- ==========================================
-- TEST 8
-- CUSTOMER TRANSACTION HISTORY
-- ==========================================

CALL customer_transaction_history(
'DB100000001'
);

-- ==========================================
-- TEST 9
-- EXECUTIVE DASHBOARD
-- ==========================================

SELECT

(SELECT COUNT(*) FROM customers) AS Customers,

(SELECT COUNT(*) FROM accounts) AS Accounts,

(SELECT COUNT(*) FROM transactions) AS Transactions,

(SELECT SUM(balance) FROM accounts) AS Total_Balance;

-- ==========================================
-- TEST 10
-- HIGH RISK ALERTS
-- ==========================================

SELECT *

FROM compliance_alerts

WHERE risk_level IN ('High','Critical');