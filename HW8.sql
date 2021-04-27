SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;
   
   
SELECT * FROM profiles;
SELECT * FROM likes;
-- Лайки М\Ж 
SELECT profiles.gender, 
COUNT(likes.id) AS total_likes
   FROM likes  
   JOIN  profiles 
   ON likes.user_id = profiles.user_id
   GROUP BY profiles.gender
   ORDER BY total_likes DESC
    LIMIT 1;
   
-- Общее количество лайков самых молодых
   
 SELECT COUNT(*) FROM likes 
  WHERE target_type_id = 2
    AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles );
   
-------

SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(target_types.id) AS got_likes 
      FROM likes
        INNER JOIN target_types
          ON likes.target_type_id = target_types.id
            AND target_types.name = 'users'
        RIGHT JOIN profiles
          ON likes.target_id = profiles.user_id
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;

-- 10 пользователей с наимельней активностью 

SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activity
  LIMIT 10;

