CREATE DATABASE IF NOT EXISTS seminar_05;
USE seminar_05;
DROP TABLE IF EXISTS staff;
CREATE TABLE IF NOT EXISTS staff
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
	post VARCHAR(45),
    seniority INT,
    salary DECIMAL(8,2),
    age INT
);

TRUNCATE staff;
INSERT staff (first_name, last_name, post, seniority, salary, age)
VALUES
 ('Вася', 'Петров', 'Начальник', 40, 70000, 60),
 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
 
SELECT * FROM staff;


-- РАНЖИРОВАНИЕ
-- Вывести список всех сотрудников, указать место по ЗП в общем списке
SELECT
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS full_name,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Вывести список всех сотрудников, указать место по ЗП в общем списке
-- для каждой должности
SELECT
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS full_name,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Вывести список всех сотрудников, указать место по ЗП в общем списке
-- для каждой должности 
SELECT
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS full_name,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Найти самых высокооплачиваемых сотрудников внутри каждой должности
SELECT * -- post, salary, full_name, dense_rank
FROM (SELECT
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS full_name,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff) rank_staff
WHERE `dense_rank` = 1; -- Сотрудник с самой высокой ЗП

SELECT
	post,
    salary,
    AVG(salary) OVER (ORDER BY salary DESC 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS average
FROM staff;


-- АГРЕГАЦИЯ
-- Для каждой должности:
	-- среднюю ЗП(1)
	-- суммарную ЗП(2)
	-- процентное соотношение отдельно взятой ЗП внутри должности к сумм. ЗП по должности
	-- процентное соотношение отдельно взятой ЗП внутри должности к сумм. ЗП по предприятию
SELECT
	post,
    salary,
    ROUND(AVG(salary) OVER (PARTITION BY post),2) AS avg_salary,
    SUM(salary) OVER (PARTITION BY post) AS sum_salary,-- ЗП по должности
    SUM(salary) OVER () AS total_sum_salary, -- ЗП по заводу
    ROUND(salary * 100 / SUM(salary) OVER (PARTITION BY post),2) AS persent_post,
    ROUND(salary * 100 / SUM(salary) OVER (),2) AS persent_total
FROM staff;
 -- Тоже самое с использованием псевдонимов
SELECT
	post,
    salary,
    ROUND(AVG(salary) OVER w,2) AS avg_salary,
    SUM(salary) OVER w AS sum_salary,-- ЗП по должности
    SUM(salary) OVER w1 AS total_sum_salary, -- ЗП по заводу
    ROUND(salary * 100 / SUM(salary) OVER w,2) AS persent_post,
    ROUND(salary * 100 / SUM(salary) OVER w1,2) AS persent_total
FROM staff
WINDOW w AS (PARTITION BY post),
w1 AS ();


-- ПРЕДСТАВЛЕНИЯ
CREATE OR REPLACE VIEW v_count_post
AS
SELECT 
	post,
    COUNT(*) AS count_staff,
    AVG(salary) AS avg_salary 
FROM staff
GROUP BY post
ORDER BY count_staff DESC;

SHOW FULL TABLES;

SELECT * FROM v_count_post;















