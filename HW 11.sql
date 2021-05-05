USE shop;
SELECT * FROM products;
-- Оптимизация запросов
-- 1

CREATE TABLE logs (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
row_name VARCHAR(50) NOT NULL,
table_name VARCHAR(255) NOT NULL,
row_id INT UNSIGNED NOT NULL,
update_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE = Archive;


-- users 
DROP TRIGGER IF EXISTS watchlog_users;
DELIMITER //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, row_id, row_name)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;


-- catalogs
DROP TRIGGER IF EXISTS watchlog_catalogs;
DELIMITER //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, row_id, row_name))
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;


-- products
DELIMITER //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, row_id, row_name)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;




