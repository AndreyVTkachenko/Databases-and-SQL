-- 1. Cоздание БД
CREATE DATABASE IF NOT EXISTS seminar_02;


-- 2. Подключение к БД
USE seminar_02;


-- 3. Таблица (все столбцы в ней, без нормализации)
DROP TABLE IF EXISTS product; -- Удалить таблицу, если существует 
CREATE TABLE product
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE, 
	category VARCHAR(100)
);

DESCRIBE product; -- Просмотр содержимого таблицы


-- 4. Производим нормализацию
ALTER TABLE product
DROP category;


-- 5. Выделение второй сущности - "категория"
CREATE TABLE IF NOT EXISTS category
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	category_name VARCHAR(45)-- буква ё на англ. раскладке
);


-- 6. Заполнение таблиц
INSERT INTO product (title)
VALUES
	("Intel Core i7-10700K"), -- id = 1
	("AMD Ryzen 5 5600X"),-- id = 2
	("Intel Core i5-11600K"),-- id = 3
	("AMD Ryzen 7 5800X"), -- id = 4
	("Intel Core i9-11900K"),-- id = 5
    ("GTX1060"), -- id = 6
    ("GTX1070"); -- id = 7
    
-- Добавлем в продукты внешний ключ на category
ALTER TABLE product
ADD category_id INT,
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id)
REFERENCES category(id)
ON UPDATE CASCADE ON DELETE CASCADE;
INSERT INTO category(category_name)
VALUES
	("процессор"),
    ("видеокарта");

UPDATE product
SET category_id = CASE
	WHEN title LIKE "Intel%" OR title LIKE "AMD%" 
		THEN 1
	ELSE 2
END;

SELECT *
FROM product;

SELECT p.title, c.category_name
FROM product p
JOIN category c 
ON p.category_id = c.id;

SELECT 
title,
CASE
	WHEN title LIKE "Intel%" OR title LIKE "AMD%" 
		THEN 1
	ELSE 2
END AS result
FROM product;

SELECT 
	title,
	CASE
		WHEN title LIKE "Intel%" OR title LIKE "AMD%" 
			THEN "Процессоры"
		ELSE "Видеокарты"
	END AS result
FROM product;
