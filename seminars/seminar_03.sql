CREATE DATABASE IF NOT EXISTS seminar_03;
USE seminar_03;
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


SELECT
	id,
    salary,
    CONCAT(first_name, " ", last_name, " возраст: ", age) AS full_name
FROM staff
ORDER BY salary DESC
LIMIT 2;

-- сортировка по нескольком полям
SELECT
	id,
    salary,
    first_name,
    last_name
FROM staff
ORDER BY last_name DESC, first_name DESC, salary; -- по убыванию


-- топ 5 самых высоких ЗП
SELECT
	DISTINCT(salary) AS unique_salary
FROM staff
ORDER BY unique_salary DESC
LIMIT 5;
 

-- группировка 
-- для каждоу занимаемой должности найдём:
-- Минимальную и максимальную ЗП, среднюю ЗП, разницу между максимальной и минимальной ЗП
-- количество сотрудников
SELECT
	post,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    ROUND(AVG(salary),2) AS avg_salary,
    MAX(salary) - MIN(salary) AS diff,
    COUNT(salary) AS count_staff -- 3)
FROM staff -- 1)
WHERE post != "Уборщик" -- работа до группировки -- 2)
GROUP BY post -- 4)
HAVING avg_salary > 25000; -- HAVING работает ТОЛЬКО с агрегатными функциями 5)





