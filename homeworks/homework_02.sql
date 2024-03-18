CREATE DATABASE IF NOT EXISTS homework_02;
USE homework_02;

-- Задание 01
-- Создание справочника
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.

Сущность mobile_phones имеет следующие записи:
| id | product_name | manufacturer | product_count | price | 
| -- | ------------ | ------------ | ------------- | ----- | 
|  1 | iPhone X     | Apple        | 156           | 76000 | 
|  2 | iPhone 8     | Apple        | 180           | 51000 | 
|  3 | Galaxy S9    | Samsung      | 21            | 56000 | 
|  4 | Galaxy S8    | Samsung      | 124           | 41000 | 
|  5 | P20 Pro      | Huawei       | 341           | 36000 |

Создайте таблицу (сущность) с заказами manufacturer. При создании необходимо использовать DDL-команды.
Перечень полей (атрибутов):
id – числовой тип, автоинкремент, первичный ключ;
name – строковый тип;

Используя CRUD-операцию INSERT, наполните сущность manufacturer в соответствии с данными, имеющимися в атрибуте manufacturer сущности mobile_phones.
*/
/*
-- При написании запросов указывайте не только имя таблицы, но и схему.
-- Название вашей схемы - itresume9518562 (заполнено для автотестов)
-- Например, itresume9518562.tablename

-- Вы работаете с PostgreSQL (домашнее задание выполнено для MySQL)
-- Введите свой код ниже
*/

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
    
CREATE TABLE IF NOT EXISTS manufacturer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

INSERT INTO manufacturer (name)
SELECT manufacturer
FROM mobile_phones;

SELECT * FROM manufacturer;



-- Задание 02
-- Вывод статуса количества мобильных телефонов
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.

Сущность mobile_phones имеет следующие записи:

id	product_name	manufacturer	product_count	price
1	iPhone X		Apple			156				76000
2	iPhone 8		Apple			180				51000
3	Galaxy S9		Samsung			21				56000
4	Galaxy S8		Samsung			124				41000
5	P20 Pro			Huawei			341				36000
Статусы количества мобильных телефонов (в зависимости от количества): меньше 100 – «little»; от 100 до 300 – «many»; больше 300 – «lots».

Необходимо вывести название, производителя и статус количества для мобильных телефонов.
*/

SELECT 
    product_name,
    manufacturer,
    CASE
        WHEN product_count < 100 THEN 'little'
        WHEN product_count BETWEEN 100 AND 300 THEN 'many' -- (WHEN product_count > 100 AND product_count < 300 THEN 'many')
        ELSE 'lots'
    END AS quantity_status
FROM 
    mobile_phones;
    
-- Задание 03
-- Создание внешнего ключа
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.

Сущность mobile_phones имеет следующие записи:

id	product_name	manufacturer	product_count	price
1	iPhone X		Apple			156				76000
2	iPhone 8		Apple			180				51000
3	Galaxy S9		Samsung			21				56000
4	Galaxy S8		Samsung			124				41000
5	P20 Pro			Huawei			341				36000
Имеется таблица-справочник (сущность) производителей manufacturer.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
name – название.

Сущность manufacturer имеет следующие записи:
id	name
1	Apple
2	Samsung
3	Huawei
Создайте для сущности mobile_phones внешний ключ manufacturer_id (идентификатор производителя), направленный на атрибут id сущности manufacturer. Установите каскадное обновление - CASCADE, а при удалении записи из сущности manufacturer – SET NULL.
Используя CRUD-операцию UPDATE обновите данные в атрибуте manufacturer_id сущности mobile_phones согласно значений, имеющихся в атрибуте manufacturer.
Удалите атрибут manufacturer из сущности mobile_phones.
Выведите идентификатор, название и идентификатор производителя сущности mobile_phones.

-- При написании запросов указывайте не только имя таблицы, но и схему.
-- Название вашей схемы - itresume9518562 (заполнено для автотестов)
-- Например, itresume9518562.tablename
-- Вы работаете с PostgreSQL (домашнее задание выполнено для MySQL)
-- Введите свой код ниже
*/

ALTER TABLE mobile_phones
ADD manufacturer_id INT,
ADD CONSTRAINT fk_manufacturer
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturer (id)
ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE mobile_phones AS mp
JOIN manufacturer AS m ON mp.manufacturer = m.name
SET mp.manufacturer_id = m.id;

ALTER TABLE mobile_phones
DROP COLUMN manufacturer;

SELECT id, product_name, manufacturer_id
FROM mobile_phones;


-- Задание 04
-- Вывод подробного описания статуса
/*
Имеется таблица (сущность) с заказами orders.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
mobile_phones_id – идентификатор мобильного телефона;
order_status - статус.

id	mobile_phones_id	order_status
1	1					OPEN
2	1					OPEN
3	1					CLOSED
4	4					OPEN
5	4					CANCELLED
Подробное описание статусов заказа:
OPEN – «Order is in open state» ;
CLOSED - «Order is closed»;
CANCELLED - «Order is cancelled»

Необходимо вывести идентификатор и подробное описание статуса заказа.
*/

CREATE TABLE IF NOT EXISTS orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    mobile_phones_id INT NOT NULL,
    order_status VARCHAR(45) NOT NULL
    );
INSERT INTO orders (mobile_phones_id, order_status) 
VALUES 
	('1', 'open'),
	('1', 'open'),
	('1', 'closed'),
	('4', 'open'),
	('4', 'cancelled');
    
SELECT 
    id,
    CASE 
        WHEN order_status = 'OPEN' THEN 'Order is in open state'
        WHEN order_status = 'CLOSED' THEN 'Order is closed'
        WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
    END AS full_order_status
FROM orders;

