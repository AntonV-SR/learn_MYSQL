SELECT * FROM users WHERE birthday_at >= '1990-01-01' AND birthday_at < '2000-01-01';

-- Операторы и фильтрация
-- 1
DESC users;
SELECT * FROM users;

UPDATE users SET
  created_at = NOW(),
  updated_at = NOW();
 ---------------------------------------
 INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Василий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александра', '1985-05-20', NULL, NULL),
  ('Пётр', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
 
 -- 2
 
 Alter TABLE users MODIFY COLUMN created_at DATETIME;
 Alter TABLE users MODIFY COLUMN updated_at DATETIME;

---------------------------------

SELECT * FROM users_1;
CREATE TABLE users_1 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';


INSERT INTO
  users_1 (name, birthday_at, created_at, updated_at)
VALUES
  ('Василий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александрф', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Пётр', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
 UPDATE
  users_1
SET
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
 
ALTER TABLE
  users_1
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
  users_1
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
 
-- 3
SELECT * FROM storehouses_products;
UPDATE storehouses_products SET
  storehouse_id = FLOOR(1 + RAND() * 7),
  value = FLOOR(RAND() * 1000),
  product_id = FLOOR(1 + RAND() * 7);
 
SELECT value FROM storehouses_products ORDER BY value;
SELECT * FROM  storehouses_products ORDER BY IF (value > 0, 0, 1), value;


-- 4

SELECT name FROM users WHERE DATE_FORMAT (birthday_at, '%M') IN ('may', 'august');


-- Агрегация данных
-- 1
SELECT * FROM users;

SELECT
  `name`, 
  `birthday_at`,
  (YEAR(CURRENT_DATE)-YEAR(`birthday_at`))-(RIGHT(CURRENT_DATE,5)<RIGHT(`birthday_at`,5)
  ) AS `age`
 -- AVG(age) AS avg
FROM `users`
ORDER BY `name`;

SELECT AVG() as avg FROM users;

-- 2
SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;
 


 

 
 




