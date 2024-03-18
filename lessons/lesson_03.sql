CREATE DATABASE IF NOT EXISTS lesson_03;
USE lesson_03;
CREATE TABLE IF NOT EXISTS Products
(
Id INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(20) NOT NULL,
ProductCount INT  DEFAULT 0,
Price DECIMAL
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

SELECT * FROM Products
ORDER BY Price;

SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum;

SELECT ProductName, Price, ProductCount
FROM Products
ORDER BY ProductCount * Price;

SELECT * FROM products
LIMIT 3;

SELECT * FROM products
LIMIT 2, 3;

SELECT DISTINCT Manufacturer FROM Products;



CREATE TABLE IF NOT EXISTS NewProducts
(
Id INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(20) NOT NULL,
ProductCount INT DEFAULT 0,
Price DECIMAL NOT NULL);
INSERT INTO NewProducts(ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 32000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 5, 28000),
('Nokia 8', 'HMD Global', 6, 38000);

SELECT AVG(Price) AS Average_Price FROM NewProducts;

SELECT AVG(Price) FROM NewProducts
WHERE Manufacturer='Apple';

SELECT COUNT(*) FROM NewProducts;

SELECT MIN(Price), MAX(Price) FROM Products;

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM NewProducts
GROUP BY Manufacturer
HAVING COUNT(*) > 1;

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM NewProducts
WHERE Price * ProductCount > 80000
GROUP BY Manufacturer
HAVING COUNT(*) > 1;
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM NewProducts
WHERE Price * ProductCount > 80000
GROUP BY Manufacturer
HAVING SUM(ProductCount) >2
ORDER BY Units DESC;


SELECT * 
FROM NewProducts
ORDER BY Price DESC; -- Сортировка по убыванию

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
SELECT Manufacturer, COUNT(*) AS Models, Price, ProductCount
FROM NewProducts
WHERE Price > 40000
GROUP BY Manufacturer;
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||




