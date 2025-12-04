-- Insert new menu items
INSERT INTO menu (name, description, price, category_id, is_available) VALUES
('Caesar Salad', 'Crisp romaine lettuce with Caesar dressing, croutons, and parmesan cheese.', 9.99, 1, TRUE),
('Margherita Pizza', 'Classic pizza with fresh tomatoes, mozzarella cheese, basil, and olive oil.', 14.99, 2, TRUE),
('Shrimp Alfredo', 'Creamy pasta with shrimp in Alfredo sauce.', 12.99, 3, TRUE);

-- Update prices for 15% discounts on Main courses
UPDATE menu
SET price = price * 0.85
WHERE category_id = 2;

-- Delete discontinued menu items
UPDATE menu
SET is_available = FALSE
WHERE name IN ('Calamari Fritti', 'Panna Cotta');

-- Place a new order with multiple items
START TRANSACTION;

INSERT INTO orders (order_datetime, total_amount, status, customer_id, cashier_id, delivery_address_id, payment_method, payment_status) VALUES
(NOW(), 0, 'PENDING', 1, 1, 1, 'CARD', 'UNPAID');

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO order_item (order_id, menu_item_id, quantity, unit_price, line_total) VALUES
(
    @new_order_id,
    (SELECT menu_item_id FROM menu WHERE name = 'Caesar Salad'),
    1, 
    (SELECT price FROM menu WHERE name = 'Caesar Salad'),
    (SELECT price FROM menu WHERE name = 'Caesar Salad')
),
(
    @new_order_id,
    (SELECT menu_item_id FROM menu WHERE name = 'Margherita Pizza'),
    1,
    (SELECT price FROM menu WHERE name = 'Margherita Pizza'),
    (SELECT price FROM menu WHERE name = 'Margherita Pizza')
),
(
    @new_order_id,
    (SELECT menu_item_id FROM menu WHERE name = 'Shrimp Alfredo'),
    1,
    (SELECT price FROM menu WHERE name = 'Shrimp Alfredo'),
    (SELECT price FROM menu WHERE name = 'Shrimp Alfredo')
);

UPDATE orders
SET total_amount = (
    SELECT SUM(line_total) 
    FROM order_item 
    WHERE order_id = @new_order_id)
WHERE order_id = @new_order_id;

COMMIT;

-- Assign a delivery driver
INSERT INTO delivery (order_id, driver_id, assigned_time, delivery_status) VALUES
(8, 3, NOW(), 'ASSIGNED');

-- Change order status
UPDATE orders
SET status = 'PREPARING'
WHERE order_id = 8;

-- List sales per day or per category

-- Per day
SELECT 
    DATE(o.order_datetime) AS order_date,
    SUM(oi.line_total) AS total_sales
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
GROUP BY order_date;

-- Per category
SELECT 
    c.name AS category_name,
    SUM(oi.line_total) AS total_sales
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
JOIN menu m ON oi.menu_item_id = m.menu_item_id
JOIN category c ON m.category_id = c.category_id
GROUP BY category_name;

-- Cancel an order
UPDATE orders
SET status = 'CANCELLED'
WHERE order_id = 5;