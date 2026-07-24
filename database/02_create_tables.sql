USE secure_transact_db;

-- ===========================================
-- BRANCHES
-- ===========================================

CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_code VARCHAR(10) UNIQUE NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL DEFAULT 'India',
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- ===========================================
-- EMPLOYEES
-- ===========================================

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    designation VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2),
    branch_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_employee_branch
    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);

-- ===========================================
-- ACCOUNT TYPES
-- ===========================================

CREATE TABLE account_types (
    account_type_id INT AUTO_INCREMENT PRIMARY KEY,
    account_type_name VARCHAR(50) UNIQUE NOT NULL,
    minimum_balance DECIMAL(12,2) DEFAULT 0,
    description VARCHAR(255)
);

-- ===========================================
-- CURRENCIES
-- ===========================================

CREATE TABLE currencies (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_code CHAR(3) UNIQUE NOT NULL,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10)
);

-- ===========================================
-- TRANSACTION TYPES
-- ===========================================

CREATE TABLE transaction_types (
    transaction_type_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_type_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(255)
);

-- ===========================================
-- CUSTOMERS
-- ===========================================

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_code VARCHAR(20) UNIQUE NOT NULL,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    gender ENUM('Male','Female','Other'),

    date_of_birth DATE NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    phone VARCHAR(15) UNIQUE NOT NULL,

    pan_number VARCHAR(10) UNIQUE NOT NULL,

    aadhaar_number VARCHAR(12) UNIQUE,

    occupation VARCHAR(100),

    annual_income DECIMAL(15,2)
    CHECK (annual_income >= 0),

    kyc_status ENUM('Pending','Verified','Rejected')
        DEFAULT 'Pending',

    address VARCHAR(255),

    city VARCHAR(50),

    state VARCHAR(50),

    country VARCHAR(50) DEFAULT 'India',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- ===========================================
-- ACCOUNTS
-- ===========================================

CREATE TABLE accounts (

    account_id INT AUTO_INCREMENT PRIMARY KEY,

    account_number VARCHAR(20) UNIQUE NOT NULL,

    customer_id INT NOT NULL,

    branch_id INT NOT NULL,

    account_type_id INT NOT NULL,

    currency_id INT NOT NULL,

    balance DECIMAL(18,2)
    DEFAULT 0.00
    CHECK (balance >= 0),

    account_status ENUM(
        'Active',
        'Inactive',
        'Frozen',
        'Closed'
    ) DEFAULT 'Active',

    opened_on DATE NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_accounts_customer
        FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_accounts_branch
        FOREIGN KEY(branch_id)
        REFERENCES branches(branch_id),

    CONSTRAINT fk_accounts_account_type
        FOREIGN KEY(account_type_id)
        REFERENCES account_types(account_type_id),

    CONSTRAINT fk_accounts_currency
        FOREIGN KEY(currency_id)
        REFERENCES currencies(currency_id)
);

-- ===========================================
-- BENEFICIARIES
-- ===========================================

CREATE TABLE beneficiaries (

    beneficiary_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id INT NOT NULL,

    beneficiary_name VARCHAR(100) NOT NULL,

    beneficiary_account_number VARCHAR(20) NOT NULL,

    beneficiary_bank VARCHAR(100) NOT NULL,

    ifsc_code VARCHAR(15) NOT NULL,

    nickname VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_beneficiary_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)

);

-- ===========================================
-- TRANSACTIONS
-- ===========================================

CREATE TABLE transactions (

    transaction_id INT AUTO_INCREMENT PRIMARY KEY,

    transaction_reference VARCHAR(30) UNIQUE NOT NULL,

    sender_account_id INT NULL,

    receiver_account_id INT NULL,

    transaction_type_id INT NOT NULL,

    currency_id INT NOT NULL,

    amount DECIMAL(18,2)
    NOT NULL
    CHECK(amount > 0),

    transaction_status ENUM(
        'Pending',
        'Success',
        'Failed',
        'Cancelled'
    ) DEFAULT 'Pending',

    remarks VARCHAR(255),

    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_sender_account
        FOREIGN KEY (sender_account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT fk_receiver_account
        FOREIGN KEY (receiver_account_id)
        REFERENCES accounts(account_id),

    CONSTRAINT fk_transaction_type
        FOREIGN KEY (transaction_type_id)
        REFERENCES transaction_types(transaction_type_id),

    CONSTRAINT fk_transaction_currency
        FOREIGN KEY (currency_id)
        REFERENCES currencies(currency_id)

);
-- ===========================================
-- COMPLIANCE ALERTS
-- ===========================================

CREATE TABLE compliance_alerts (

    alert_id INT AUTO_INCREMENT PRIMARY KEY,

    transaction_id INT NOT NULL,

    alert_type VARCHAR(100) NOT NULL,

    risk_level ENUM(
        'Low',
        'Medium',
        'High',
        'Critical'
    ) NOT NULL,

    alert_status ENUM(
        'Open',
        'Under Review',
        'Resolved',
        'Closed'
    ) DEFAULT 'Open',

    alert_description VARCHAR(255),

    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_alert_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id)

);

-- ===========================================
-- INVESTIGATIONS
-- ===========================================

CREATE TABLE investigations (

    investigation_id INT AUTO_INCREMENT PRIMARY KEY,

    alert_id INT NOT NULL,

    employee_id INT NOT NULL,

    investigation_status ENUM(
        'Assigned',
        'In Progress',
        'Completed',
        'Closed'
    ) DEFAULT 'Assigned',

    findings TEXT,

    action_taken TEXT,

    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    closed_at TIMESTAMP NULL,

    CONSTRAINT fk_investigation_alert
        FOREIGN KEY (alert_id)
        REFERENCES compliance_alerts(alert_id),

    CONSTRAINT fk_investigation_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)

);

-- ===========================================
-- AUDIT LOGS
-- ===========================================

CREATE TABLE audit_logs (

    log_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT,

    table_name VARCHAR(100) NOT NULL,

    record_id INT,

    action_type ENUM(
        'INSERT',
        'UPDATE',
        'DELETE'
    ) NOT NULL,

    action_description TEXT,

    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    ip_address VARCHAR(45),

    CONSTRAINT fk_audit_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)

);