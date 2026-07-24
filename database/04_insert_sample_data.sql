USE secure_transact_db;

-- ==========================================================
-- SAMPLE EMPLOYEES
-- ==========================================================

INSERT INTO employees
(first_name,last_name,email,phone,designation,hire_date,salary,branch_id)
VALUES
('Rahul','Sharma','rahul.sharma@db.com','9876500001','Branch Manager','2021-02-10',120000,1),
('Priya','Patel','priya.patel@db.com','9876500002','Compliance Officer','2022-05-15',95000,1),
('Amit','Verma','amit.verma@db.com','9876500003','Risk Analyst','2020-09-18',105000,2),
('Sneha','Joshi','sneha.joshi@db.com','9876500004','Relationship Manager','2023-01-11',75000,3),
('Rohan','Mehta','rohan.mehta@db.com','9876500005','Operations Executive','2022-08-20',65000,4),
('Neha','Kapoor','neha.kapoor@db.com','9876500006','Compliance Officer','2021-06-14',90000,5),
('Arjun','Nair','arjun.nair@db.com','9876500007','AML Analyst','2022-11-01',98000,2),
('Karan','Singh','karan.singh@db.com','9876500008','Risk Officer','2023-03-09',88000,3),
('Anjali','Desai','anjali.desai@db.com','9876500009','Branch Manager','2019-07-05',125000,4),
('Vikram','Rao','vikram.rao@db.com','9876500010','Internal Auditor','2020-10-12',110000,5);

-- ==========================================================
-- SAMPLE CUSTOMERS
-- ==========================================================

INSERT INTO customers
(customer_code,first_name,last_name,gender,date_of_birth,email,phone,pan_number,aadhaar_number,occupation,annual_income,kyc_status,address,city,state,country)
VALUES

('CUST001','Tanisha','Chekkilla','Female','2005-11-10','tanisha@email.com','9000000001','ABCDE1111A','111122223333','Software Engineer',900000,'Verified','Andheri','Mumbai','Maharashtra','India'),

('CUST002','Aarav','Shah','Male','1995-04-15','aarav@email.com','9000000002','ABCDE1112B','111122223334','Business Owner',1800000,'Verified','Bandra','Mumbai','Maharashtra','India'),

('CUST003','Riya','Patil','Female','1998-07-20','riya@email.com','9000000003','ABCDE1113C','111122223335','Doctor',2500000,'Verified','Kothrud','Pune','Maharashtra','India'),

('CUST004','Kabir','Mehta','Male','1993-02-11','kabir@email.com','9000000004','ABCDE1114D','111122223336','Chartered Accountant',2100000,'Pending','Connaught Place','Delhi','Delhi','India'),

('CUST005','Sara','Khan','Female','1997-09-12','sara@email.com','9000000005','ABCDE1115E','111122223337','Teacher',750000,'Verified','Hazratganj','Lucknow','Uttar Pradesh','India'),

('CUST006','Aditya','Kulkarni','Male','1994-12-01','aditya@email.com','9000000006','ABCDE1116F','111122223338','Software Architect',2700000,'Verified','Baner','Pune','Maharashtra','India'),

('CUST007','Neha','Verma','Female','1996-05-19','nehaverma@email.com','9000000007','ABCDE1117G','111122223339','Lawyer',1600000,'Verified','Indiranagar','Bengaluru','Karnataka','India'),

('CUST008','Rohan','Iyer','Male','1992-01-18','rohan@email.com','9000000008','ABCDE1118H','111122223340','Investment Banker',5200000,'Verified','Powai','Mumbai','Maharashtra','India'),

('CUST009','Ananya','Reddy','Female','1999-10-05','ananya@email.com','9000000009','ABCDE1119J','111122223341','Data Scientist',1900000,'Verified','Madhapur','Hyderabad','Telangana','India'),

('CUST010','Vivek','Gupta','Male','1991-03-30','vivek@email.com','9000000010','ABCDE1120K','111122223342','Businessman',6500000,'Verified','Civil Lines','Jaipur','Rajasthan','India');

-- ==========================================================
-- SAMPLE ACCOUNTS
-- ==========================================================

INSERT INTO accounts
(account_number, customer_id, branch_id, account_type_id, currency_id, balance, account_status, opened_on)
VALUES

('DB100000001',1,1,1,1,350000.00,'Active','2023-01-10'),
('DB100000002',2,1,2,1,850000.00,'Active','2022-09-12'),
('DB100000003',3,2,1,3,125000.00,'Active','2024-02-18'),
('DB100000004',4,3,2,4,920000.00,'Active','2021-08-25'),
('DB100000005',5,1,1,1,58000.00,'Active','2024-05-15'),
('DB100000006',6,4,3,5,145000.00,'Active','2023-11-02'),
('DB100000007',7,5,1,2,420000.00,'Active','2022-04-20'),
('DB100000008',8,2,2,3,2500000.00,'Active','2020-12-01'),
('DB100000009',9,4,1,5,98000.00,'Active','2023-07-08'),
('DB100000010',10,3,2,4,1850000.00,'Active','2021-03-16');

-- ==========================================================
-- SAMPLE BENEFICIARIES
-- ==========================================================

INSERT INTO beneficiaries
(customer_id,
beneficiary_name,
beneficiary_account_number,
beneficiary_bank,
ifsc_code,
nickname)

VALUES

(1,'Aarav Shah','DB100000002','Deutsche Bank','DBIN000001','Business'),

(1,'Riya Patil','DB100000003','Deutsche Bank','DBIN000002','Doctor'),

(2,'Kabir Mehta','DB100000004','Deutsche Bank','DBIN000003','CA'),

(2,'Sara Khan','DB100000005','Deutsche Bank','DBIN000004','Family'),

(3,'Aditya Kulkarni','DB100000006','Deutsche Bank','DBIN000005','Friend'),

(4,'Neha Verma','DB100000007','Deutsche Bank','DBIN000006','Legal'),

(5,'Rohan Iyer','DB100000008','Deutsche Bank','DBIN000007','Investment'),

(6,'Ananya Reddy','DB100000009','Deutsche Bank','DBIN000008','Office'),

(7,'Vivek Gupta','DB100000010','Deutsche Bank','DBIN000009','Business'),

(8,'Tanisha Chekkilla','DB100000001','Deutsche Bank','DBIN000010','Personal');

-- ==========================================================
-- VERIFY
-- ==========================================================

SELECT * FROM accounts;

SELECT * FROM beneficiaries;

-- ==========================================================
-- SAMPLE TRANSACTIONS
-- ==========================================================

INSERT INTO transactions
(transaction_reference,
sender_account_id,
receiver_account_id,
transaction_type_id,
currency_id,
amount,
transaction_status,
remarks)

VALUES

('TXN000001',1,2,3,1,2500.00,'Success','UPI Payment'),
('TXN000002',2,3,4,1,25000.00,'Success','NEFT Transfer'),
('TXN000003',3,4,5,1,150000.00,'Success','RTGS Payment'),
('TXN000004',4,5,6,4,40000.00,'Success','NEFT Transfer'),
('TXN000005',5,6,6,1,12000.00,'Success','IMPS'),

('TXN000006',6,7,7,5,500000.00,'Success','International SWIFT'),
('TXN000007',7,8,3,2,6500.00,'Success','UPI'),
('TXN000008',8,9,4,3,90000.00,'Success','NEFT'),
('TXN000009',9,10,6,5,10000.00,'Success','IMPS'),
('TXN000010',10,1,5,4,300000.00,'Pending','RTGS'),

('TXN000011',1,3,3,1,1500.00,'Success','UPI Grocery'),
('TXN000012',2,5,4,1,76000.00,'Success','Vendor Payment'),
('TXN000013',3,6,5,1,250000.00,'Success','RTGS'),
('TXN000014',4,7,6,1,8000.00,'Success','IMPS'),
('TXN000015',5,8,3,2,5500.00,'Success','UPI'),

('TXN000016',6,9,7,5,850000.00,'Success','International Transfer'),
('TXN000017',7,10,4,2,45000.00,'Success','Salary Transfer'),
('TXN000018',8,1,3,3,3200.00,'Success','UPI'),
('TXN000019',9,2,6,5,9000.00,'Failed','IMPS Failed'),
('TXN000020',10,3,5,4,120000.00,'Success','RTGS'),

('TXN000021',1,4,3,1,900.00,'Success','UPI'),
('TXN000022',2,6,4,1,18000.00,'Success','NEFT'),
('TXN000023',3,7,5,1,350000.00,'Success','RTGS'),
('TXN000024',4,8,6,2,12000.00,'Success','IMPS'),
('TXN000025',5,9,7,5,950000.00,'Pending','Large International Transfer'),

('TXN000026',6,2,7,3,1200000.00,'Success','High Value SWIFT Transfer'),
('TXN000027',8,5,7,2,1800000.00,'Success','International Business Payment'),
('TXN000028',2,9,5,1,450000.00,'Success','RTGS Transfer'),
('TXN000029',9,1,3,1,3500.00,'Success','UPI Transfer'),
('TXN000030',10,7,4,4,62000.00,'Success','NEFT Salary'),

('TXN000031',3,5,6,1,25000.00,'Success','IMPS'),
('TXN000032',4,8,3,1,1400.00,'Success','UPI'),
('TXN000033',5,2,4,1,52000.00,'Success','NEFT'),
('TXN000034',7,6,7,5,2100000.00,'Pending','Large SWIFT Transfer'),
('TXN000035',8,3,5,3,600000.00,'Success','RTGS'),

('TXN000036',1,10,3,1,2000.00,'Success','UPI'),
('TXN000037',2,4,6,1,9000.00,'Success','IMPS'),
('TXN000038',6,9,4,1,72000.00,'Success','NEFT'),
('TXN000039',10,5,7,2,2500000.00,'Pending','International SWIFT'),
('TXN000040',9,8,5,5,500000.00,'Success','RTGS'),

('TXN000041',5,4,3,1,950.00,'Success','UPI'),
('TXN000042',3,7,4,1,36000.00,'Success','NEFT'),
('TXN000043',2,10,7,3,1500000.00,'Success','Corporate SWIFT'),
('TXN000044',1,8,5,1,450000.00,'Success','RTGS'),
('TXN000045',4,9,6,5,18000.00,'Success','IMPS'),

('TXN000046',8,6,7,2,3200000.00,'Pending','Large International Transfer'),
('TXN000047',7,5,3,1,4200.00,'Success','UPI'),
('TXN000048',6,4,4,1,65000.00,'Success','NEFT'),
('TXN000049',9,3,5,1,750000.00,'Success','RTGS'),
('TXN000050',10,2,7,3,5000000.00,'Pending','Very High Value SWIFT');

-- ==========================================================
-- COMPLIANCE ALERTS
-- ==========================================================

INSERT INTO compliance_alerts
(transaction_id,
alert_type,
risk_level,
alert_status,
alert_description)

VALUES

(26,'High Value Transaction','High','Open',
'SWIFT transfer exceeded ₹10 lakh'),

(34,'Suspicious International Transfer','Critical','Under Review',
'Multiple overseas transfers detected'),

(39,'AML Monitoring','High','Open',
'Repeated foreign currency movement'),

(43,'Corporate Risk Review','Medium','Open',
'Corporate payment flagged for review'),

(46,'Large Cross Border Transfer','Critical','Under Review',
'Very high international payment'),

(50,'Extreme Value Transaction','Critical','Open',
'Transaction exceeds internal threshold');

-- ==========================================================
-- INVESTIGATIONS
-- ==========================================================

INSERT INTO investigations
(alert_id,
employee_id,
investigation_status,
findings,
action_taken)

VALUES

(1,2,'Assigned',
'Awaiting supporting documents',
'Pending'),

(2,7,'In Progress',
'Customer contacted for verification',
'Enhanced Due Diligence'),

(3,6,'Assigned',
'AML review initiated',
'Pending'),

(4,8,'Completed',
'Business transaction verified',
'No further action'),

(5,2,'In Progress',
'Compliance approval pending',
'Monitoring'),

(6,10,'Assigned',
'Escalated to Risk Committee',
'Pending');

-- ==========================================================
-- AUDIT LOGS
-- ==========================================================

INSERT INTO audit_logs
(employee_id,
table_name,
record_id,
action_type,
action_description,
ip_address)

VALUES

(2,'transactions',26,'INSERT',
'Compliance alert generated',
'10.10.1.20'),

(7,'investigations',2,'UPDATE',
'Investigation status updated',
'10.10.1.25'),

(6,'compliance_alerts',3,'INSERT',
'AML alert created',
'10.10.1.30'),

(8,'investigations',4,'UPDATE',
'Case closed',
'10.10.1.35'),

(2,'transactions',50,'INSERT',
'Critical transaction reviewed',
'10.10.1.40');

-- ==========================================================
-- VERIFY SAMPLE DATA
-- ==========================================================

SELECT COUNT(*) AS Employees FROM employees;
SELECT COUNT(*) AS Customers FROM customers;
SELECT COUNT(*) AS Accounts FROM accounts;
SELECT COUNT(*) AS Beneficiaries FROM beneficiaries;
SELECT COUNT(*) AS Transactions FROM transactions;
SELECT COUNT(*) AS Compliance_Alerts FROM compliance_alerts;
SELECT COUNT(*) AS Investigations FROM investigations;
SELECT COUNT(*) AS Audit_Logs FROM audit_logs;