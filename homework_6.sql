# Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

# 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

-- смотрю содержание колонок
USE shop;
SELECT 'created_at', 'updated_at' FROM users;

-- если не заполнены, заполняю текущим временем и датой

UPDATE users SET created_at = NOW(), updated_at = NOW();

# 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- неудачно проектирубю таблицу
ALTER TABLE users MODIFY COLUMN created_at VARCHAR(100) NULL;
ALTER TABLE users MODIFY COLUMN updated_at VARCHAR(100) NULL;

UPDATE users SET created_at = '20.10.2017 8:10', updated_at = '20.10.2017 8:10';

-- преобразую поля к формату DATETIME с сохранением значений
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

-- преобразую в тип DATETIME
ALTER TABLE users MODIFY COLUMN created_at DATETIME NULL, MODIFY COLUMN updated_at DATETIME NULL;

# 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

-- заполняю таблицу storehouses_products
INSERT INTO storehouses_products (id, storehouse_id, product_id, value, created_at, updated_at) VALUES 
	(1, 1, 1, 0, NOW(), NOW()),
	(DEFAULT, 2, 2, 2500, NOW(), NOW()),
	(DEFAULT, 3, 3, 0, NOW(), NOW()),
	(DEFAULT, 4, 4, 30, NOW(), NOW()),
	(DEFAULT, 5, 5, 500, NOW(), NOW()),
	(DEFAULT, 6, 6, 1, NOW(), NOW());

-- сортирую
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 999999 ELSE value END;

# 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT * FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august'); 

# 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id=2, id=1, id=5;

# Практическое задание теме “Агрегация данных”

# 1. Подсчитайте средний возраст пользователей в таблице users

SELECT SUM(DATE_FORMAT(NOW() , '%Y') - DATE_FORMAT(birthday_at, '%Y'))/COUNT(birthday_at) FROM users; 

# 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT DATE_FORMAT(STR_TO_DATE(CONCAT_WS('.', DATE_FORMAT(birthday_at, '%d'), DATE_FORMAT(birthday_at, '%M'), DATE_FORMAT(NOW(), '%Y')),'%d.%M.%Y'), '%W') as WeekDay, COUNT(*) FROM users GROUP BY WeekDay;

# 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы

SELECT EXP(SUM(LN(id))) FROM products;