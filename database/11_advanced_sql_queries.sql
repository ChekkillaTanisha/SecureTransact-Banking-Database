USE secure_transact_db;

-- ==========================================================
-- ADVANCED SQL QUERY 1
-- RANK CUSTOMERS BY ACCOUNT BALANCE
-- ==========================================================

SELECT
    c.customer_code,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    a.account_number,
    a.balance,
    RANK() OVER (ORDER BY a.balance DESC) AS balance_rank
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

-- ==========================================================
-- ADVANCED SQL QUERY 2
-- TOP 5 HIGHEST VALUE TRANSACTIONS
-- ==========================================================

SELECT *
FROM
(
    SELECT
        transaction_reference,
        amount,
        transaction_status,
        transaction_time,
        ROW_NUMBER() OVER
        (
            ORDER BY amount DESC
        ) AS transaction_rank
    FROM transactions
) t
WHERE transaction_rank <= 5;

-- ==========================================================
-- ADVANCED SQL QUERY 3
-- BRANCH WISE CUSTOMER RANKING
-- ==========================================================

SELECT
    b.branch_name,
    c.customer_code,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    a.balance,
    DENSE_RANK() OVER
    (
        PARTITION BY b.branch_name
        ORDER BY a.balance DESC
    ) AS branch_rank
FROM accounts a
JOIN customers c
ON a.customer_id = c.customer_id
JOIN branches b
ON a.branch_id = b.branch_id;

-- ==========================================================
-- ADVANCED SQL QUERY 4
-- HIGH VALUE CUSTOMERS USING CTE
-- ==========================================================

WITH high_value_customers AS
(
    SELECT
        c.customer_id,
        CONCAT(c.first_name,' ',c.last_name) AS customer_name,
        a.balance
    FROM customers c
    JOIN accounts a
    ON c.customer_id = a.customer_id
    WHERE a.balance >= 500000
)

SELECT *
FROM high_value_customers
ORDER BY balance DESC;

-- ==========================================================
-- ADVANCED SQL QUERY 5
-- BRANCH TOTAL BALANCE USING WINDOW FUNCTION
-- ==========================================================

SELECT
    b.branch_name,
    a.account_number,
    a.balance,

    SUM(a.balance)
    OVER
    (
        PARTITION BY b.branch_name
    ) AS total_branch_balance

FROM accounts a
JOIN branches b
ON a.branch_id = b.branch_id;

-- ==========================================================
-- ADVANCED SQL QUERY 6
-- RUNNING TOTAL OF TRANSACTIONS
-- ==========================================================

SELECT
    transaction_reference,
    transaction_time,
    amount,

    SUM(amount)
    OVER
    (
        ORDER BY transaction_time
    ) AS running_total

FROM transactions;

-- ==========================================================
-- ADVANCED SQL QUERY 7
-- PREVIOUS TRANSACTION AMOUNT
-- ==========================================================

SELECT
    transaction_reference,
    amount,

    LAG(amount)
    OVER
    (
        ORDER BY transaction_time
    ) AS previous_transaction,

    transaction_time

FROM transactions;

-- ==========================================================
-- ADVANCED SQL QUERY 8
-- NEXT TRANSACTION AMOUNT
-- ==========================================================

SELECT
    transaction_reference,
    amount,

    LEAD(amount)
    OVER
    (
        ORDER BY transaction_time
    ) AS next_transaction,

    transaction_time

FROM transactions;