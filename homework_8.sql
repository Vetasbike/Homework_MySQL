# Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”. Работаем с БД vk и данными, которые вы сгенерировали ранее:
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT u.firstname, u.lastname 
FROM users AS u
JOIN
messages AS m
WHERE m.from_user_id = u.id AND m.to_user_id = 1 
GROUP BY u.firstname, u.lastname
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT COUNT(*) 'likes count'
FROM posts_likes AS pl 
JOIN profiles AS p 
WHERE p.user_id = pl.user_id AND TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10
;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT CASE (gender)
        WHEN 'm' THEN 'мужчины'
        WHEN 'f' THEN 'женщины'
    	END AS 'Кого больше', COUNT(*) as 'лайков'
FROM profiles AS p 
JOIN posts_likes AS pl 
WHERE pl.user_id = p.user_id
GROUP BY gender 
LIMIT 1;