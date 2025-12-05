# Restricts the cashier to connect only from localhost, which would be the cash register machine
CREATE USER IF NOT EXISTS 'cashier_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'cashier_pass_123';

# Allows the cook to conect from a computer in the restautant's local network
CREATE USER IF NOT EXISTS 'cook_user'@'192.168.0.%' IDENTIFIED WITH sha256_password BY 'cook_pass_456';

# Allows the manager to connect from any location
CREATE USER IF NOT EXISTS 'manager_user'@'%' IDENTIFIED WITH caching_sha2_password BY 'manager_pass_789';

GRANT SELECT, INSERT ON restaurant_db.* TO 'cashier_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON restaurant_db.* TO 'cook_user'@'192.168.0.%';
GRANT ALL PRIVILEGES ON restaurant_db.* TO 'manager_user'@'%';

# Showing grants for verification
SHOW GRANTS FOR 'cashier_user'@'localhost';
SHOW GRANTS FOR 'cook_user'@'192.168.0.%';
SHOW GRANTS FOR 'manager_user'@'%';

# Drop them for testing purposes
DROP USER IF EXISTS 'cashier_user'@'localhost';
DROP USER IF EXISTS 'cook_user'@'192.168.0.%';
DROP USER IF EXISTS 'manager_user'@'%';