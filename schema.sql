CREATE DATABASE HospitalDB;
USE HospitalDB;



CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    contact VARCHAR(15),
    address TEXT
);


CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    date DATE,
    time TIME,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);


CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT,
    patient_id INT,
    date DATE,
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);


CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);


CREATE TABLE Prescription_Medicine (
    prescription_id INT,
    medicine_id INT,
    quantity INT,
    instructions TEXT,
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);


CREATE TABLE Medical_Record (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT ,
    date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);


CREATE TABLE Room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE,
    type VARCHAR(50),
    status VARCHAR(50)
);


CREATE TABLE Patient_Room (
    patient_id INT,
    room_id INT,
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (patient_id, room_id, from_date),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);


CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    amount DECIMAL(10,2),
    date DATE,
    method VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

ALTER TABLE Patient
ADD blood_group VARCHAR(5);


ALTER TABLE Doctor
MODIFY phone VARCHAR(20);
select * from Patient;

-- Populating Department Table
INSERT INTO Department (name, location) VALUES
('Cardiology', 'Block A'),
('Neurology', 'Block B'),
('Orthopedics', 'Block C'),
('Pediatrics', 'Block D'),
('Oncology', 'Block E');

select * from Department;

INSERT INTO Doctor (name, specialization, phone, email, department_id) VALUES
('Dr. Asha Mehta', 'Cardiologist', '9876543210', 'asha@hospital.com', 1),
('Dr. Rakesh Nair', 'Neurologist', NULL, 'rakesh@hospital.com', 2),
('Dr. Priya Verma', 'Orthopedic', '9988776655', NULL, 3),
('Dr. Sunil Rao', 'Pediatrician', '9876501234', 'sunil@hospital.com', 4),
('Dr. Meena Joshi', 'Oncologist', NULL, NULL, 5);
Select *from Doctor;

INSERT INTO Patient (name, age, gender, contact, address, blood_group) VALUES
('Ravi Sharma', 45, 'Male', NULL, 'Mumbai', 'O+'),
('Sneha Patel', 30, 'Female', '9001234567', 'Pune', NULL),
('Aman Khan', 60, 'Male', '9123456789', 'Delhi', 'A+'),
('Neha Kulkarni', 25, 'Female', NULL, 'Nashik', 'B-'),
('Suresh Singh', 52, 'Male', '9876543211', 'Nagpur', NULL);
SELECT COUNT(*) FROM Patient;

Select * from Patient;
select name, gender
from Patient
WHERE age >50;


INSERT INTO Appointment (patient_id, doctor_id, date, time, status) VALUES
(1, 1, '2025-06-01', '10:00:00', 'Scheduled'),
(2, 2, '2025-06-02', '11:00:00', 'Completed'),
(3, 3, '2025-06-03', '12:00:00', 'Cancelled'),
(4, 4, '2025-06-04', '09:30:00', NULL),
(5, 5, '2025-06-05', '14:00:00', 'Scheduled');
Select * from Appointment;

INSERT INTO Prescription (doctor_id, patient_id, date, notes) VALUES
(1, 1, '2025-06-01', 'Take aspirin daily'),
(2, 2, '2025-06-02', 'MRI advised'),
(3, 3, '2025-06-03', NULL),
(4, 4, '2025-06-04', 'Regular checkup'),
(5, 5, '2025-06-05', NULL);
select * from Prescription;

INSERT INTO Medicine (name, dosage, price, stock) VALUES
('Aspirin', '75mg', 10.00, 100),
('Paracetamol', '500mg', 5.00, 200),
('Amoxicillin', '250mg', 20.00, 150),
('Ibuprofen', '400mg', 15.00, 80),
('Vitamin D', '1000 IU', 25.00, 120);

INSERT INTO Prescription_Medicine (prescription_id, medicine_id, quantity, instructions) VALUES
(1, 1, 30, '1 daily after breakfast'),
(2, 2, 15, '2 daily after food'),
(3, 3, 20, '3 times a day'),
(4, 4, 10, 'As required'),
(5, 5, 25, 'Morning only');

INSERT INTO Medical_Record (patient_id, diagnosis, treatment, notes, date) VALUES
(1, 'Hypertension', 'Medication', 'No note', '2025-06-01'),
(2, 'Migraine', 'Rest & Medicine', 'Needs follow-up', '2025-06-02'),
(3, 'Fracture', 'Surgery', 'Cast for 6 weeks', '2025-06-03'),
(4, 'Cold', 'General medicine', 'No note', '2025-06-04'),
(5, 'Cancer Screening', 'Biopsy', 'Awaiting results', '2025-06-05');
Select diagnosis,treatment
from Medical_Record;

select patient_id
from Medical_Record 
WHERE diagnosis = 'Cancer Screening' AND treatment='Biopsy';


INSERT INTO Room (room_number, type, status) VALUES
('101', 'General', 'Occupied'),
('102', 'Private', 'Available'),
('103', 'ICU', 'Occupied'),
('104', 'General', 'Maintenance'),
('105', 'Private', 'Available');
select type,status
from Room
WHERE type='General';

select room_number
from Room
WHERE type='Private' OR type='General';

INSERT INTO Patient_Room (patient_id, room_id, from_date, to_date) VALUES
(1, 1, '2025-06-01', '2025-06-03'),
(2, 3, '2025-06-02', '2025-06-05'),
(3, 2, '2025-06-03', '2025-06-06'),
(4, 1, '2025-06-04', '2025-06-06'),
(5, 4, '2025-06-05', '2025-06-07');

INSERT INTO Payment (patient_id, amount, date, method) VALUES
(1, 1500.00, '2025-06-01', 'Cash'),
(2, 2000.00, '2025-06-02', 'Card'),
(3, 1800.00, '2025-06-03', 'Online'),
(4, 500.00, '2025-06-04', 'UPI'),
(5, 2200.00, '2025-06-05', 'Cash');

-- Update Dr. Rakesh Nair's phone number (was NULL)
UPDATE Doctor
SET phone = '9998881111'
WHERE doctor_id = 2;

-- Update Dr. Meena Joshi's phone number (was NULL)
UPDATE Doctor
SET phone = '8887772222'
WHERE doctor_id = 5;

UPDATE Doctor
SET email ='meenajoshi@gmail.com'
WHERE doctor_id = 5;

UPDATE Doctor
SET email ='priya@hospital.com'
WHERE doctor_id = 3;
-- Update blood group for patient Sneha Patel (patient_id = 2)
UPDATE Patient
SET blood_group = 'AB+'
WHERE patient_id = 2;

-- Update blood group for patient Suresh Singh (patient_id = 5)
UPDATE Patient
SET blood_group = 'O-'
WHERE patient_id = 5;

UPDATE Patient
SET contact = 9087654321
WHERE patient_id = 1;

UPDATE Patient
SET contact = 9087123451
WHERE patient_id = 4;


-- Update appointment status for appointment with NULL (appointment_id = 4)
UPDATE Appointment
SET status = 'Completed'
WHERE appointment_id = 4;
UPDATE Prescription
SET notes="no note"
WHERE patient_id =3;
UPDATE Prescription
SET notes="no note"
WHERE patient_id =5;

select room_number
from Room
WHERE NOT type='Private';
-- USe of LIKE 'text%'. It means pattern that starts from Dr. will be printed.
SELECT * FROM Doctor 
WHERE name LIKE 'Dr.%';

SELECT * FROM Patient 
WHERE name LIKE 'S%';

-- use of BETWEEN
SELECT * FROM Patient 
WHERE age BETWEEN 25 AND 50;

SELECT * FROM Appointment 
WHERE date BETWEEN '2025-06-01' AND '2025-06-03';

-- Sort patients by age (ascending - youngest first)
SELECT * FROM Patient 
ORDER BY age ASC;

-- Sort departments by location
SELECT * FROM Department 
ORDER BY location;

-- Sort rooms by room number
SELECT * FROM Room 
ORDER BY room_number;

SELECT * FROM Room 
WHERE status = 'Available' 
LIMIT 2;

-- Get next 2 doctors after first 2
SELECT * FROM Doctor 
ORDER BY doctor_id 
LIMIT 2 OFFSET 2;

-- Combining AND,LIKE,BETWEEN,SELECT,WHERE, ORDER By and LIMIT
SELECT * FROM Patient 
WHERE name LIKE 'S%' 
  AND age BETWEEN 25 AND 60 
ORDER BY age ASC 
LIMIT 2;

-- Aggregate Functions used here are COUNT(),SUM(),AVG(),MAX(),MIN()
-- Count()
select COUNT(doctor_id) FROM Doctor;
select COUNT(*) FROM Appointment;
select COUNT(type AND status) FROM Room;

-- SUM()
select SUM(quantity) from Prescription_Medicine;

-- AVG()
select AVG(quantity) from Prescription_Medicine;

-- MIN()
select MIN(age) from Patient;
select MIN(quantity) from Prescription_Medicine;

-- MAX()
select MAX(age) from Patient;
select MAX(quantity) from Prescription_Medicine;

-- Use of GROUP BY clause
SELECT method, SUM(amount) AS total_amount
FROM Payment
GROUP BY method;

SELECT method, COUNT(patient_id) AS number_of_patients
FROM Payment
GROUP BY method;

SELECT patient_id, SUM(amount) AS total_paid
FROM Payment
GROUP BY patient_id;

SELECT room_id, COUNT(patient_id) AS total_patients
FROM Patient_Room
GROUP BY room_id;

-- use of HAVING clause
SELECT method, SUM(amount) AS total_amount
FROM Payment
GROUP BY method
HAVING SUM(amount) > 1500;

SELECT room_id, SUM(DATEDIFF(to_date, from_date)) AS total_days
FROM Patient_Room
GROUP BY room_id
HAVING total_days > 3;

-- categorizing the payements as LOW, MEDIUM and HIGH using GROUP BY 
SELECT 
  CASE 
    WHEN amount < 1000 THEN 'Low'
    WHEN amount BETWEEN 1000 AND 2000 THEN 'Medium'
    ELSE 'High'
  END AS payment_category,
  COUNT(*) AS total
FROM Payment
GROUP BY payment_category;

-- occupancy report by from_date
SELECT from_date, COUNT(patient_id) AS patients_checked_in
FROM Patient_Room
GROUP BY from_date;

-- use of ROUND()
SELECT method, ROUND(AVG(amount), 2) AS avg_payment
FROM Payment
GROUP BY method;

