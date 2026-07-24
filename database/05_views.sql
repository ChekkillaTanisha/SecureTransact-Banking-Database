USE secure_transact_db;

-- ==========================================================
-- VIEW 1
-- CUSTOMER ACCOUNT SUMMARY
-- ==========================================================

CREATE VIEW customer_account_summary AS

SELECT

c.customer_id,
c.customer_code,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,

a.account_number,

at.account_type_name,

a.balance,

a.account_status,

b.branch_name,

cu.currency_code

FROM customers c

JOIN accounts a
ON c.customer_id = a.customer_id

JOIN account_types at
ON a.account_type_id = at.account_type_id

JOIN branches b
ON a.branch_id = b.branch_id

JOIN currencies cu
ON a.currency_id = cu.currency_id;



-- ==========================================================
-- VIEW 2
-- HIGH VALUE TRANSACTIONS
-- ==========================================================

CREATE VIEW high_value_transactions AS

SELECT

t.transaction_reference,

sa.account_number AS sender_account,

ra.account_number AS receiver_account,

tt.transaction_type_name,

cu.currency_code,

t.amount,

t.transaction_status,

t.transaction_time

FROM transactions t

JOIN accounts sa
ON t.sender_account_id = sa.account_id

JOIN accounts ra
ON t.receiver_account_id = ra.account_id

JOIN transaction_types tt
ON t.transaction_type_id = tt.transaction_type_id

JOIN currencies cu
ON t.currency_id = cu.currency_id

WHERE t.amount >= 1000000;



-- ==========================================================
-- VIEW 3
-- ACTIVE ACCOUNTS
-- ==========================================================

CREATE VIEW active_accounts AS

SELECT

account_number,

balance,

opened_on,

account_status

FROM accounts

WHERE account_status='Active';

-- ==========================================================
-- VERIFY
-- ==========================================================

SELECT * FROM customer_account_summary;

SELECT * FROM high_value_transactions;

SELECT * FROM active_accounts;

-- ==========================================================
-- VIEW 4
-- BRANCH BALANCE SUMMARY
-- ==========================================================

CREATE VIEW branch_balance_summary AS

SELECT

b.branch_id,
b.branch_name,
b.city,

COUNT(a.account_id) AS total_accounts,

SUM(a.balance) AS total_branch_balance,

AVG(a.balance) AS average_balance

FROM branches b

LEFT JOIN accounts a
ON b.branch_id = a.branch_id

GROUP BY
b.branch_id,
b.branch_name,
b.city;

-- ==========================================================
-- VIEW 5
-- PENDING COMPLIANCE ALERTS
-- ==========================================================

CREATE VIEW pending_compliance_alerts AS

SELECT

ca.alert_id,

t.transaction_reference,

ca.alert_type,

ca.risk_level,

ca.alert_status,

ca.generated_at,

ca.alert_description

FROM compliance_alerts ca

JOIN transactions t
ON ca.transaction_id = t.transaction_id

WHERE ca.alert_status IN ('Open','Under Review');

-- ==========================================================
-- VIEW 6
-- EMPLOYEE INVESTIGATION SUMMARY
-- ==========================================================

CREATE VIEW employee_investigation_summary AS

SELECT

e.employee_id,

CONCAT(e.first_name,' ',e.last_name) AS employee_name,

e.designation,

COUNT(i.investigation_id) AS total_cases,

SUM(
CASE
WHEN i.investigation_status='Completed'
THEN 1
ELSE 0
END
) AS completed_cases,

SUM(
CASE
WHEN i.investigation_status='Assigned'
OR i.investigation_status='In Progress'
THEN 1
ELSE 0
END
) AS pending_cases

FROM employees e

LEFT JOIN investigations i
ON e.employee_id=i.employee_id

GROUP BY

e.employee_id,
employee_name,
e.designation;

-- ==========================================================
-- VIEW 7
-- MONTHLY TRANSACTION SUMMARY
-- ==========================================================

CREATE VIEW monthly_transaction_summary AS

SELECT

YEAR(transaction_time) AS transaction_year,

MONTH(transaction_time) AS transaction_month,

COUNT(*) AS total_transactions,

SUM(amount) AS total_transaction_amount,

AVG(amount) AS average_transaction_amount

FROM transactions

GROUP BY

YEAR(transaction_time),
MONTH(transaction_time);

-- ==========================================================
-- VERIFY
-- ==========================================================

SELECT * FROM branch_balance_summary;

SELECT * FROM pending_compliance_alerts;

SELECT * FROM employee_investigation_summary;

SELECT * FROM monthly_transaction_summary;