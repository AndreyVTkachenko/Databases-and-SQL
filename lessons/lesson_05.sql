CREATE DATABASE IF NOT EXISTS lesson_05;
USE lesson_05;

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `Date` VARCHAR(45),
    `Medium` VARCHAR(45),
    Conversions INT);
TRUNCATE Orders;
INSERT Orders (`Date`, `Medium`, Conversions)
VALUES
	('10.05.2020', 'cpa', 1),
    ('10.05.2020', 'cpc', 2),
    ('10.05.2020', 'organic', 1),
    ('11.05.2020', 'cpa', 1),
    ('11.05.2020', 'cpc', 3),
    ('11.05.2020', 'organic', 2),
    ('11.05.2020', 'direct', 1),
	('12.05.2020', 'cpc', 1),
	('12.05.2020', 'organic', 2);
    
SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER() AS 'Sum'
FROM Orders;

-- PARTITION BY определяет столбец, по которому будет производиться группировка
-- и является ключевой в разделении набора строк на окна

SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY `Date`) AS 'Sum'
FROM Orders;

SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY `Medium`) AS 'Sum'
FROM Orders;

-- В данном случае сумма рассчитывается по текущей и следующей ячейке в окне
SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY `Date` ORDER BY `Medium`) AS 'Sum'
FROM Orders;


-- ROWS и RANGE
SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY `Date` ORDER BY Conversions ROWS BETWEEN CURRENT ROW and 1 FOLLOWING) AS 'Sum'
FROM Orders;



SELECT
	`Date`,
    `Medium`,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY `Date`) AS 'Sum',
    COUNT(Conversions) OVER(PARTITION BY `Date`) AS 'Count',
    AVG(Conversions) OVER(PARTITION BY `Date`) AS 'Avg',
    MAX(Conversions) OVER(PARTITION BY `Date`) AS 'Max',
    MIN(Conversions) OVER(PARTITION BY `Date`) AS 'Min'
FROM Orders;


-- Ранжирующие функции
SELECT
	`Date`,
    `Medium`,
	Conversions,
	ROW_NUMBER( )
	OVER(PARTITION BY Date ORDER BY Conversions) AS 'Row_number',
	RANK()
	OVER(PARTITION BY Date ORDER BY Conversions) AS 'Rank',
	DENSE_RANK()
	OVER(PARTITION BY Date ORDER BY Conversions) AS 'Dense_Rank',
	NTILE(3)
	OVER(PARTITION BY Date ORDER BY Conversions) AS 'Ntile'
FROM Orders;


-- Функции смещения
SELECT
	`Date`,
    `Medium`,
	Conversions,
	LAG(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lag',
	LEAD(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lead',
	FIRST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'First_Value',
	LAST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Last_Value'
FROM Orders;





-- ПРЕДСТАВЛЕНИЯ

CREATE VIEW CopyProducts AS
SELECT Price, ProductCount, Manufacturer
FROM lesson_02.products
WHERE Manufacturer = 'Apple';

SELECT * FROM CopyProducts;


ALTER VIEW CopyProducts AS
SELECT Price, ProductCount, Manufacturer, ProductName
FROM lesson_02.products
WHERE Manufacturer = 'Apple';

SELECT * FROM CopyProducts;


