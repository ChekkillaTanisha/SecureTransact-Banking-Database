USE secure_transact_db;

-- ==========================================================
-- INDEX 1
-- ACCOUNT NUMBER
-- Fast account lookup
-- ==========================================================

CREATE UNIQUE INDEX idx_account_number
ON accounts(account_number);

-- ==========================================================
-- INDEX 2
-- CUSTOMER EMAIL
-- Fast customer search
-- ==========================================================

CREATE UNIQUE INDEX idx_customer_email
ON customers(email);

-- ==========================================================
-- INDEX 3
-- CUSTOMER PAN
-- ==========================================================

CREATE UNIQUE INDEX idx_customer_pan
ON customers(pan_number);

-- ==========================================================
-- INDEX 4
-- TRANSACTION REFERENCE
-- ==========================================================

CREATE UNIQUE INDEX idx_transaction_reference
ON transactions(transaction_reference);

-- ==========================================================
-- INDEX 5
-- TRANSACTION DATE
-- Used in reports
-- ==========================================================

CREATE INDEX idx_transaction_time
ON transactions(transaction_time);

-- ==========================================================
-- INDEX 6
-- TRANSACTION STATUS
-- ==========================================================

CREATE INDEX idx_transaction_status
ON transactions(transaction_status);

-- ==========================================================
-- INDEX 7
-- AMOUNT
-- High Value Transaction Search
-- ==========================================================

CREATE INDEX idx_transaction_amount
ON transactions(amount);

-- ==========================================================
-- INDEX 8
-- BRANCH
-- ==========================================================

CREATE INDEX idx_branch
ON accounts(branch_id);

-- ==========================================================
-- INDEX 9
-- ACCOUNT STATUS
-- ==========================================================

CREATE INDEX idx_account_status
ON accounts(account_status);

-- ==========================================================
-- INDEX 10
-- RISK LEVEL
-- ==========================================================

CREATE INDEX idx_risk_level
ON compliance_alerts(risk_level);

-- ==========================================================
-- INDEX 11
-- ALERT STATUS
-- ==========================================================

CREATE INDEX idx_alert_status
ON compliance_alerts(alert_status);

-- ==========================================================
-- INDEX 12
-- INVESTIGATION STATUS
-- ==========================================================

CREATE INDEX idx_investigation_status
ON investigations(investigation_status);