CREATE DATABASE IF NOT EXISTS lesson_04;
USE lesson_04;

DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees
(
	Empid INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(45) NOT NULL,
    Address VARCHAR(45) NOT NULL,
    Phone DOUBLE,
    salary INT
);
TRUNCATE Employees;
INSERT Employees (`Name`, Address, Phone, salary)
VALUES
('Nikhil', 'Delhi', 9878906543, 8000),
('Divya', 'Ranchi', 8990076543, 5000),
('Ravi', 'Bareilly', 7789945765, 7000),
('Anna', 'Noida', 9789945760, 4000),
('Surbhi', 'Jaipur', 7800541123, 5500);
SELECT * FROM Employees;

DROP TABLE IF EXISTS Customers;
CREATE TABLE IF NOT EXISTS Customers
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    AccountSum DECIMAL
);
TRUNCATE Customers;
INSERT Customers (FirstName, LastName, AccountSum)
VALUES
('Tom', 'Smith', 2000),
('Sam', 'Bpown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800),
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800),
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800);
SELECT * FROM Customers;


-- объединение двух столбцов обеих таблиц
SELECT FirstName, LastName
FROM Customers
UNION SELECT `Name`, Phone
FROM Employees;

-- объединение двух столбцов обеих таблиц с сортировкой
SELECT FirstName, LastName
FROM Customers
UNION SELECT `Name`, Phone
FROM Employees
ORDER BY FirstName DESC;

-- объединение двух столбцов обеих таблиц с выводом повторяющихся данных
SELECT FirstName, LastName
FROM Customers
UNION ALL SELECT `Name`, Phone
FROM Employees
ORDER BY FirstName DESC;

-- UNION в пределах одной таблицы. Начисление процентов на вклад:
-- Если сумма меньше 3000, то начисляются проценты в размере 10% от суммы на счете.
-- Если на счете больше 3000, то проценты увеличиваются до 30%.
SELECT FirstName, LastName, AccountSum + AccountSum * 0.1 AS TotalSum
FROM Customers WHERE AccountSum < 3000
UNION SELECT FirstName, LastName, AccountSum + AccountSum * 0.3 AS TotalSum
FROM Customers WHERE AccountSum >= 3000;

-- копирование таблицы
CREATE TABLE test
(
	Id INT,
    `Name` VARCHAR(45)
);
INSERT INTO test VALUES
(1, 'Bob'), (2, 'Tom'), (3, 'Tim');

SELECT * FROM test;
CREATE TABLE copy SELECT * FROM test;

SELECT * FROM copy;