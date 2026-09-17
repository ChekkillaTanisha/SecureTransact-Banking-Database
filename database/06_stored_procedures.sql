USE secure_transact_db;

DELIMITER $$

-- ==========================================================
-- PROCEDURE 1
-- DEPOSIT MONEY
-- ==========================================================

CREATE PROCEDURE deposit_money
(
    IN p_account_number VARCHAR(20),
    IN p_amount DECIMAL(18,2)
)

BEGIN

    UPDATE accounts

    SET balance = balance + p_amount

    WHERE account_number = p_account_number;

END$$

-- ==========================================================
-- PROCEDURE 2
-- WITHDRAW MONEY
-- ==========================================================

CREATE PROCEDURE withdraw_money
(
    IN p_account_number VARCHAR(20),
    IN p_amount DECIMAL(18,2)
)

BEGIN

    DECLARE current_balance DECIMAL(18,2);

    SELECT balance
    INTO current_balance

    FROM accounts

    WHERE account_number = p_account_number;

    IF current_balance >= p_amount THEN

        UPDATE accounts

        SET balance = balance - p_amount

        WHERE account_number = p_account_number;

    ELSE

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT='Insufficient Balance';

    END IF;

END$$

-- ==========================================================
-- PROCEDURE 3
-- CHECK ACCOUNT BALANCE
-- ==========================================================

CREATE PROCEDURE check_balance
(
    IN p_account_number VARCHAR(20)
)

BEGIN

    SELECT

    account_number,

    balance,

    account_status

    FROM accounts

    WHERE account_number=p_account_number;

END$$

DELIMITER ;

DELIMITER $$

-- ==========================================================
-- PROCEDURE 4
-- TRANSFER FUNDS
-- ==========================================================

CREATE PROCEDURE transfer_funds
(
    IN p_sender_account VARCHAR(20),
    IN p_receiver_account VARCHAR(20),
    IN p_amount DECIMAL(18,2)
)

BEGIN

    DECLARE sender_balance DECIMAL(18,2);

    DECLARE sender_id INT;
    DECLARE receiver_id INT;

    DECLARE sender_status VARCHAR(20);
    DECLARE receiver_status VARCHAR(20);

    -- Get sender details
    SELECT
        account_id,
        balance,
        account_status
    INTO
        sender_id,
        sender_balance,
        sender_status
    FROM accounts
    WHERE account_number = p_sender_account;

    -- Get receiver details
    SELECT
        account_id,
        account_status
    INTO
        receiver_id,
        receiver_status
    FROM accounts
    WHERE account_number = p_receiver_account;

    -- Validate sender exists
    IF sender_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sender account does not exist';
    END IF;

    -- Validate receiver exists
    IF receiver_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Receiver account does not exist';
    END IF;

    -- Prevent same account transfer
    IF sender_id = receiver_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sender and Receiver cannot be the same account';
    END IF;

    -- Check sender status
    IF sender_status <> 'Active' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sender account is not Active';
    END IF;

    -- Check receiver status
    IF receiver_status <> 'Active' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Receiver account is not Active';
    END IF;

    -- Check sufficient balance
    IF sender_balance < p_amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient Balance';
    END IF;

    START TRANSACTION;

        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = sender_id;

        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = receiver_id;

        INSERT INTO transactions
        (
            transaction_reference,
            sender_account_id,
            receiver_account_id,
            transaction_type_id,
            currency_id,
            amount,
            transaction_status,
            remarks
        )
        VALUES
        (
            CONCAT('TRF', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            LPAD(FLOOR(RAND()*1000),3,'0')),
            sender_id,
            receiver_id,
            4,
            1,
            p_amount,
            'Success',
            'Fund Transfer via Stored Procedure'
        );

    COMMIT;

END$$

-- ==========================================================
-- PROCEDURE 5
-- FREEZE ACCOUNT
-- ==========================================================

CREATE PROCEDURE freeze_account
(
    IN p_account_number VARCHAR(20)
)

BEGIN

    DECLARE account_count INT;

    SELECT COUNT(*)
    INTO account_count
    FROM accounts
    WHERE account_number = p_account_number;

    IF account_count = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account does not exist';

    ELSE

        UPDATE accounts

        SET account_status = 'Frozen'

        WHERE account_number = p_account_number;

    END IF;

END$$



-- ==========================================================
-- PROCEDURE 6
-- CUSTOMER TRANSACTION HISTORY
-- ==========================================================

DELIMITER $$

CREATE PROCEDURE customer_transaction_history(
    IN p_account_number VARCHAR(20)
)
BEGIN

    SELECT
        t.transaction_id,
        t.transaction_reference,
        sa.account_number AS sender_account,
        ra.account_number AS receiver_account,
        tt.transaction_type_name,
        t.amount,
        c.currency_code,
        t.transaction_status,
        t.transaction_time,
        t.remarks
    FROM transactions t

    LEFT JOIN accounts sa
        ON t.sender_account_id = sa.account_id

    LEFT JOIN accounts ra
        ON t.receiver_account_id = ra.account_id

    JOIN transaction_types tt
        ON t.transaction_type_id = tt.transaction_type_id

    JOIN currencies c
        ON t.currency_id = c.currency_id

    WHERE sa.account_number = p_account_number
       OR ra.account_number = p_account_number

    ORDER BY t.transaction_time DESC;

END $$

DELIMITER ;