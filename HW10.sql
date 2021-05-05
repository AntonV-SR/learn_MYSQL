SELECT * FROM users;
SELECT * FROM friendship;
SELECT * FROM friendship_statuses;
SELECT * FROM media;
SELECT * FROM posts;

--          ИНДЕКСЫ

-- Найти медиа файл mpeg с названием песни

SELECT * FROM media WHERE filename LIKE '%mpeg' 
AND filename LIKE '%dolores%';

SELECT * FROM media ORDER BY filename;

CREATE INDEX media_filename_idx ON media(filename);

-- Индекс на поиск текста в постах
 
SELECT * FROM posts WHERE body LIKE '%commodi%';

CREATE INDEX posts_body_idx ON posts(body);

-- ОКОННЫЕ ФУНКЦИИ

SELECT DISTINCT communities.id, communities.name,
  (SELECT count(*) FROM communities) as averag_users,
  FIRST_VALUE(communities_users.user_id) OVER w1 as min_old,
  FIRST_VALUE(communities_users.user_id) OVER w2 as max_old,
  COUNT(communities_users.user_id) OVER w3 as in_communities,
  (SELECT count(*) FROM users) as users_total,  
  (COUNT(communities_users.user_id) OVER w3 / (SELECT count(*) FROM users)*100) as '%%'
FROM communities_users
	JOIN communities ON (communities.id = communities_users.community_id)
	JOIN users ON (users.id = communities_users.user_id)
	JOIN profiles ON (communities_users.user_id=profiles.user_id)
WINDOW w1 AS (PARTITION BY communities_users.community_id ORDER BY profiles.birthday DESC),
       w2 AS (PARTITION BY communities_users.community_id ORDER BY profiles.birthday),
       w3 AS (PARTITION BY communities_users.community_id)
ORDER by id
;



