USE secure_transact_db;

-- ==========================================================
-- REPORT 1
-- TOP 10 CUSTOMERS BY ACCOUNT BALANCE
-- ==========================================================

SELECT

c.customer_code,

CONCAT(c.first_name,' ',c.last_name) AS customer_name,

a.account_number,

b.branch_name,

a.balance

FROM customers c

JOIN accounts a
ON c.customer_id = a.customer_id

JOIN branches b
ON a.branch_id = b.branch_id

ORDER BY a.balance DESC

LIMIT 10;



-- ==========================================================
-- REPORT 2
-- HIGH VALUE TRANSACTIONS
-- ==========================================================

SELECT

t.transaction_reference,

sa.account_number AS sender_account,

ra.account_number AS receiver_account,

tt.transaction_type_name,

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

WHERE t.amount >= 1000000

ORDER BY t.amount DESC;



-- ==========================================================
-- REPORT 3
-- BRANCH WISE TOTAL ACCOUNT BALANCE
-- ==========================================================

SELECT

b.branch_name,

COUNT(a.account_id) AS total_accounts,

SUM(a.balance) AS total_balance,

AVG(a.balance) AS average_balance

FROM branches b

LEFT JOIN accounts a

ON b.branch_id=a.branch_id

GROUP BY

b.branch_id,
b.branch_name

ORDER BY total_balance DESC;



-- ==========================================================
-- REPORT 4
-- PENDING COMPLIANCE ALERTS
-- ==========================================================

SELECT

ca.alert_id,

t.transaction_reference,

ca.alert_type,

ca.risk_level,

ca.alert_status,

ca.generated_at

FROM compliance_alerts ca

JOIN transactions t

ON ca.transaction_id=t.transaction_id

WHERE ca.alert_status IN
('Open','Under Review')

ORDER BY ca.generated_at DESC;



-- ==========================================================
-- REPORT 5
-- EMPLOYEE INVESTIGATION PERFORMANCE
-- ==========================================================

SELECT

e.employee_id,

CONCAT(e.first_name,' ',e.last_name) AS employee_name,

COUNT(i.investigation_id) AS total_cases,

SUM(

CASE

WHEN i.investigation_status='Completed'

THEN 1

ELSE 0

END

) AS completed_cases

FROM employees e

LEFT JOIN investigations i

ON e.employee_id=i.employee_id

GROUP BY

e.employee_id,

employee_name

ORDER BY completed_cases DESC;

-- ==========================================================
-- REPORT 6
-- MONTHLY TRANSACTION SUMMARY
-- ==========================================================

SELECT

YEAR(transaction_time) AS transaction_year,

MONTH(transaction_time) AS transaction_month,

COUNT(*) AS total_transactions,

SUM(amount) AS total_amount,

AVG(amount) AS average_transaction_amount

FROM transactions

GROUP BY

YEAR(transaction_time),
MONTH(transaction_time)

ORDER BY

transaction_year,
transaction_month;



-- ==========================================================
-- REPORT 7
-- TRANSACTION TYPE ANALYSIS
-- ==========================================================

SELECT

tt.transaction_type_name,

COUNT(*) AS total_transactions,

SUM(t.amount) AS total_amount,

AVG(t.amount) AS average_amount

FROM transactions t

JOIN transaction_types tt

ON t.transaction_type_id = tt.transaction_type_id

GROUP BY

tt.transaction_type_name

ORDER BY

total_amount DESC;



-- ==========================================================
-- REPORT 8
-- CURRENCY WISE TRANSACTION ANALYSIS
-- ==========================================================

SELECT

c.currency_code,

COUNT(*) AS total_transactions,

SUM(t.amount) AS total_amount

FROM transactions t

JOIN currencies c

ON t.currency_id = c.currency_id

GROUP BY

c.currency_code

ORDER BY

total_amount DESC;



-- ==========================================================
-- REPORT 9
-- CUSTOMERS WITH PENDING KYC
-- ==========================================================

SELECT

customer_code,

CONCAT(first_name,' ',last_name) AS customer_name,

email,

phone,

city,

state

FROM customers

WHERE kyc_status='Pending';



-- ==========================================================
-- REPORT 10
-- FROZEN ACCOUNTS
-- ==========================================================

SELECT

a.account_number,

CONCAT(c.first_name,' ',c.last_name) AS customer_name,

a.balance,

b.branch_name

FROM accounts a

JOIN customers c

ON a.customer_id=c.customer_id

JOIN branches b

ON a.branch_id=b.branch_id

WHERE a.account_status='Frozen';



-- ==========================================================
-- REPORT 11
-- FAILED TRANSACTIONS
-- ==========================================================

SELECT

transaction_reference,

amount,

transaction_status,

transaction_time,

remarks

FROM transactions

WHERE transaction_status='Failed'

ORDER BY

transaction_time DESC;



-- ==========================================================
-- REPORT 12
-- HIGH RISK COMPLIANCE ALERTS
-- ==========================================================

SELECT

alert_id,

alert_type,

risk_level,

alert_status,

generated_at

FROM compliance_alerts

WHERE risk_level IN ('High','Critical')

ORDER BY

generated_at DESC;

-- ==========================================================
-- REPORT 13
-- TOP 10 CUSTOMERS BY TRANSACTION COUNT
-- ==========================================================

SELECT

c.customer_code,

CONCAT(c.first_name,' ',c.last_name) AS customer_name,

COUNT(t.transaction_id) AS total_transactions

FROM customers c

JOIN accounts a
ON c.customer_id = a.customer_id

JOIN transactions t
ON a.account_id = t.sender_account_id

GROUP BY

c.customer_id,
customer_name,
c.customer_code

ORDER BY total_transactions DESC

LIMIT 10;



-- ==========================================================
-- REPORT 14
-- BRANCH WISE COMPLIANCE DASHBOARD
-- ==========================================================

SELECT

b.branch_name,

COUNT(ca.alert_id) AS total_alerts,

SUM(
CASE
WHEN ca.risk_level='Critical'
THEN 1
ELSE 0
END
) AS critical_alerts,

SUM(
CASE
WHEN ca.alert_status='Open'
THEN 1
ELSE 0
END
) AS open_alerts

FROM branches b

LEFT JOIN accounts a
ON b.branch_id=a.branch_id

LEFT JOIN transactions t
ON a.account_id=t.sender_account_id

LEFT JOIN compliance_alerts ca
ON t.transaction_id=ca.transaction_id

GROUP BY

b.branch_id,
b.branch_name

ORDER BY total_alerts DESC;



-- ==========================================================
-- REPORT 15
-- ACCOUNT TYPE ANALYSIS
-- ==========================================================

SELECT

at.account_type_name,

COUNT(a.account_id) AS total_accounts,

AVG(a.balance) AS average_balance,

SUM(a.balance) AS total_balance

FROM account_types at

LEFT JOIN accounts a

ON at.account_type_id=a.account_type_id

GROUP BY

at.account_type_name

ORDER BY total_balance DESC;



-- ==========================================================
-- REPORT 16
-- EMPLOYEE WORKLOAD
-- ==========================================================

SELECT

e.employee_id,

CONCAT(e.first_name,' ',e.last_name) AS employee_name,

e.designation,

COUNT(i.investigation_id) AS assigned_cases

FROM employees e

LEFT JOIN investigations i

ON e.employee_id=i.employee_id

GROUP BY

e.employee_id,
employee_name,
e.designation

ORDER BY assigned_cases DESC;



-- ==========================================================
-- REPORT 17
-- OPEN INVESTIGATIONS
-- ==========================================================

SELECT

i.investigation_id,

ca.alert_type,

ca.risk_level,

CONCAT(e.first_name,' ',e.last_name) AS investigator,

i.investigation_status,

i.opened_at

FROM investigations i

JOIN compliance_alerts ca

ON i.alert_id=ca.alert_id

JOIN employees e

ON i.employee_id=e.employee_id

WHERE i.investigation_status
IN ('Assigned','In Progress')

ORDER BY

i.opened_at DESC;



-- ==========================================================
-- REPORT 18
-- DAILY TRANSACTION TREND
-- ==========================================================

SELECT

DATE(transaction_time) AS transaction_date,

COUNT(*) AS total_transactions,

SUM(amount) AS total_amount

FROM transactions

GROUP BY

DATE(transaction_time)

ORDER BY

transaction_date DESC;



-- ==========================================================
-- REPORT 19
-- TOP 5 BRANCHES BY TOTAL BALANCE
-- ==========================================================

SELECT

b.branch_name,

SUM(a.balance) AS total_balance

FROM branches b

JOIN accounts a

ON b.branch_id=a.branch_id

GROUP BY

b.branch_id,
b.branch_name

ORDER BY

total_balance DESC

LIMIT 5;



-- ==========================================================
-- REPORT 20
-- EXECUTIVE DASHBOARD
-- ==========================================================

SELECT

(SELECT COUNT(*) FROM customers)
AS total_customers,

(SELECT COUNT(*) FROM accounts)
AS total_accounts,

(SELECT COUNT(*) FROM transactions)
AS total_transactions,

(SELECT SUM(balance) FROM accounts)
AS total_bank_balance,

(SELECT COUNT(*) FROM compliance_alerts
WHERE alert_status='Open')
AS open_alerts,

(SELECT COUNT(*) FROM investigations
WHERE investigation_status IN ('Assigned','In Progress'))
AS active_investigations;