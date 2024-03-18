-- Комментарий однострочный
# Комментарий однострочный
/*
Это 
многострочный
комментарий
*/

-- 1. Создание БД
-- snake_case, единственное число
CREATE DATABASE IF NOT EXISTS seminar_01; -- Создание БД, если не существует

-- 2. Используем БД
USE seminar_01;

-- 3. Создание таблицы
CREATE TABLE IF NOT EXISTS student
(
	-- имя столбца тип_данных ограничения
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(45)
);

-- 4. Заполнение таблицы данными
TRUNCATE student; -- Очищение таблицы от данных 
INSERT INTO student (first_name)
VALUES 
	("Александр"), -- id = 1
    ("Антон"), -- id = 2 (id ++ => id = id + 1)
	("Андрей"), -- id = 3 (id ++ => id = id + 1)
	("Виктор"); -- id = 4
    
-- 5. Выводим содержимое таблицы
SELECT * FROM student;

-- 6. Вывести ограниченное количество столбцов
SELECT
	first_name
FROM 
	student;
    
-- 7. Вывести информация о студенте, имя которого - "Антон"
SELECT *
FROM student
WHERE first_name = "Антон"

-- 8. Вывести информацию о студенте, имя которых начинаются с буквы - "А"
SELECT *
FROM student
WHERE first_name LIKE "А%";
