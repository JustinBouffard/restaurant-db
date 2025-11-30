# This file will be executed to set up the initial database schema and seed data.
CREATE DATABASE IF NOT EXISTS restaurant;

# Switch to the restaurant database to avoid prefixing table names.
USE restaurant;

# Create tables
CREATE TABLE IF NOT EXISTS role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NULL
);

CREATE TABLE IF NOT EXISTS employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(30) NULL,
    hire_date DATE NOT NULL,
    active BOOLEAN DEFAULT 1,
    FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(30) NULL,
    created_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    notes VARCHAR(100) NULL,
    is_default BOOLEAN DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

# Not using on delete cascade to preserve order history
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    cashier_id INT NOT NULL,
    delivery_address_id INT NOT NULL,
    order_datetime DATETIME NOT NULL,
    status ENUM('PENDING', 'PREPARING', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED') NOT NULL,
    payment_method ENUM('CASH', 'CARD', 'ONLINE') NOT NULL,
    payment_status ENUM('UNPAID', 'PAID', 'REFUNDED') NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (cashier_id) REFERENCES employee(employee_id),
    FOREIGN KEY (delivery_address_id) REFERENCES address(address_id)
);

CREATE TABLE IF NOT EXISTS delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    driver_id INT NOT NULL,
    assigned_time DATETIME NOT NULL,
    pickup_time DATETIME NULL,
    delivery_time DATETIME NULL,
    delivery_status ENUM('ASSIGNED', 'PICKED_UP', 'OUT_FOR_DELIVERY', 'DELIVERED', 'FAILED') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS order_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    old_status VARCHAR(20) NOT NULL,
    new_status VARCHAR(20) NOT NULL,
    changed_by_employee_id INT NOT NULL,
    changed_at DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by_employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NULL
);

CREATE TABLE IF NOT EXISTS menu (
    menu_item_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    price DECIMAL(8,2) NOT NULL,
    is_available BOOLEAN DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inventory (
    inventory_item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    unit VARCHAR(10) NOT NULL,
    current_quantity DECIMAL(10,2) NOT NULL,
    reorder_level DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_item (
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    line_total DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, menu_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu(menu_item_id)
);

CREATE TABLE IF NOT EXISTS menu_item_ingredient (
    menu_item_id INT NOT NULL,
    inventory_item_id INT NOT NULL,
    quantity_per_unit DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (menu_item_id, inventory_item_id),
    FOREIGN KEY (menu_item_id) REFERENCES menu(menu_item_id) ON DELETE CASCADE,
    FOREIGN KEY (inventory_item_id) REFERENCES inventory(inventory_item_id)
);