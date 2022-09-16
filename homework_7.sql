# Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
-- заполняю таблицы

USE shop;

INSERT INTO orders (id,user_id,created_at,updated_at)
VALUES (1,1,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(2,2,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(3,1,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(4,3,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(5,1,'2022-09-08 16:14:22','2022-09-08 16:14:22');

INSERT INTO orders_products (id,order_id,product_id,total,created_at,updated_at)
VALUES (1,1,2,2,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(2,2,1,3,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(3,3,4,1,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(4,4,3,3,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(5,5,4,4,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(6,6,1,1,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(7,7,5,3,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(8,8,6,2,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(9,9,7,1,'2022-09-08 16:14:22','2022-09-08 16:14:22'),
	(10,11,2,4,'2022-09-08 16:14:22','2022-09-08 16:14:22');
	
-- 1 вариант
SELECT name FROM users WHERE id IN (SELECT DISTINCT user_id FROM orders);

-- 2 вариант через join
SELECT DISTINCT name FROM users JOIN orders WHERE users.id = orders.user_id;

# Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT products.name AS 'Список товаров', catalogs.name AS 'Разделы' 
	FROM products JOIN catalogs ON products.catalog_id = catalogs.id;

# (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` varchar(100),
	`to` varchar(100)
);

INSERT INTO flights (id, `from`, `to`) VALUES 
	(1,'moscow','omsk'),
	(2,'novgorod','kazan'),
	(3,'irkutsk','moscow'),
	(4,'omsk','irkutsk'),
	(5,'moscow','kazan');

CREATE TABLE cities (
	label varchar(100) NULL,
	name varchar(100) NULL
);

INSERT INTO cities (label, name) VALUES 
	('moscow','Москва'),
	('irkutsk','Иркутск'),
	('novgorod','Новгород'),
	('kazan','Казань'),
	('omsk','Омск');
	
-- 1 вариант
SELECT id,
	(SELECT name FROM cities WHERE label = flights.`from`) AS 'from',
	(SELECT name FROM cities WHERE label = flights.`to`) AS 'to'
	FROM flights;

-- 2 вариант
SELECT f.id, c1.name AS `from`, c2.name AS `to`
	FROM flights AS f 
	JOIN cities AS c1
	ON f.`from` = c1.label 
	JOIN cities AS c2 ON f.`to` = c2.label 
	ORDER BY f.id;