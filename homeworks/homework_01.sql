-- Задание 01
-- Создание сущности с мобильными телефонами
/*
Создайте таблицу (сущность) с мобильными телефонами mobile_phones. При создании необходимо использовать DDL-команды.
Перечень полей (атрибутов):
id – числовой тип, автоинкремент, первичный ключ;
product_name – строковый тип, обязательный к заполнению;
manufacturer – строковый тип, обязательный к заполнению;
product_count – числовой тип, беззнаковый;
price – числовой тип, беззнаковый.
Используя CRUD-операцию INSERT, наполните сущность mobile_phones данными:
product_name	manufacturer	product_count	price
iPhone X		Apple			156				76000
iPhone 8		Apple			180				51000
Galaxy S9		Samsung			21				56000
Galaxy S8		Samsung			124				41000
P20 Pro			Huawei			341				36000
*/
-- При написании запросов указывайте не только имя таблицы, но и схему. В данном случае схема не указана
-- Название вашей схемы - itresume9518562 (заполнено для автотестов)
-- Например, itresume9518562.tablename

-- Вы работаете с PostgreSQL (домашнее задание выполнено для MySQL)
-- Введите свой код ниже

CREATE DATABASE IF NOT EXISTS homework_01;
USE homework_01;
CREATE TABLE IF NOT EXISTS mobile_phones
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(45) NOT NULL,
    manufacturer VARCHAR(45) NOT NULL,
    product_count INT UNSIGNED,
    price INT UNSIGNED
    );
INSERT INTO mobile_phones (product_name, manufacturer, product_count, price) 
VALUES 
	('iPhone X', 'Apple', 156, 76000),
	('iPhone 8', 'Apple', 180, 51000),
	('Galaxy S9', 'Samsung', 21, 56000),
	('Galaxy S8', 'Samsung', 124, 41000),
	('P20 Pro', 'Huawei', 341, 36000);
    

-- Задание 02
-- Выборка мобильных телефонов по количеству
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.
Необходимо вывести название, производителя и цену для мобильных телефонов, у которых количество больше чем 2.
*/

SELECT product_name, manufacturer, price
FROM mobile_phones
WHERE product_count > 2;


-- Задание 03
-- Выборка мобильных телефонов производителя «Samsung»
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.
Необходимо вывести идентификатор, название, производителя, количество и цену для мобильных телефонов, у которых производитель «Samsung».
*/

SELECT id, product_name, manufacturer, product_count, price 
FROM mobile_phones 
WHERE manufacturer = 'Samsung';


-- Задание 04
/*
С помощью регулярных выражений найти:
4.1. Товары, в которых есть упоминание "Iphone"
4.2. "Samsung"
4.3. Товары, в которых есть ЦИФРЫ
4.4. Товары, в которых есть ЦИФРА "8" 
*/

-- 4.1
SELECT * 
FROM mobile_phones 
WHERE product_name REGEXP 'iPhone';

-- 4.2

SELECT * 
FROM mobile_phones 
WHERE manufacturer REGEXP 'Samsung';

-- 4.3
SELECT * 
FROM mobile_phones 
WHERE product_name REGEXP '[0-9]' OR manufacturer REGEXP '[0-9]';

-- 4.4
SELECT * 
FROM mobile_phones 
WHERE product_name REGEXP 8 OR manufacturer REGEXP 8;



