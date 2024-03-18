CREATE DATABASE IF NOT EXISTS homework_06;
USE homework_06;

-- Задание 01
/*
Создайте функцию, которая принимает кол-во сек и
форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'
*/
DROP PROCEDURE IF EXISTS format_seconds;
DELIMITER $$
CREATE PROCEDURE format_seconds(seconds INT)

BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE secs INT;
    DECLARE result VARCHAR(512);

    SET days = FLOOR(seconds / (24 * 3600));
    SET seconds = seconds % (24 * 3600);
    SET hours = FLOOR(seconds / 3600);
    SET seconds = seconds % 3600;
    SET minutes = FLOOR(seconds / 60);
    SET secs = seconds % 60;
    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', secs, ' seconds');

    SELECT result;
END;

CALL format_seconds(123456789);



-- Задание 02
/*
Выведите только четные числа от 1 до 10 (Через цикл).
Пример: 2,4,6,8,10
*/
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers (IN max_number INT)
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT " ";

    REPEAT
        IF counter % 2 = 0 THEN
            SET result = CONCAT(result, " ", counter);
        END IF;
        SET counter = counter + 1;
		UNTIL counter > max_number
	END REPEAT;

    SELECT result;
END ;

CALL print_numbers(10);



-- Задание 03
/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие,
в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер",
с 00:00 до 6:00 — "Доброй ночи".
(по желанию)
*/
DROP PROCEDURE IF EXISTS hello;
DELIMITER $$
CREATE PROCEDURE hello()
BEGIN
    DECLARE greeting VARCHAR(50);
    DECLARE current_hour INT;

    SET current_hour = HOUR(NOW());

    IF current_hour >= 6 AND current_hour < 12 THEN
        SET greeting = 'Доброе утро';
    ELSEIF current_hour >= 12 AND current_hour < 18 THEN
        SET greeting = 'Добрый день';
    ELSEIF current_hour >= 18 AND current_hour < 24 THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;

    SELECT greeting AS greeting;
END ;

CALL hello();

