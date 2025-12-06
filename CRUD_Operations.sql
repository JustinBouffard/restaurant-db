-- Insert new menu items
INSERT INTO restaurant.menu (name, description, price, category_id, is_available) VALUES
('Caesar Salad', 'Crisp romaine lettuce with Caesar dressing, croutons, and parmesan cheese.', 9.99, 1, TRUE),
('Margherita Pizza', 'Classic pizza with fresh tomatoes, mozzarella cheese, basil, and olive oil.', 14.99, 2, TRUE),
('Shrimp Alfredo', 'Creamy pasta with shrimp in Alfredo sauce.', 12.99, 3, TRUE);

-- Update prices for 15% discounts on Main courses
UPDATE restaurant.menu
SET price = price * 0.85
WHERE category_id = 2;

-- Delete discontinued menu items
UPDATE restaurant.menu
SET is_available = FALSE
WHERE name IN ('Calamari Fritti', 'Panna Cotta');

-- Place a new order with multiple items
START TRANSACTION;

INSERT INTO restaurant.orders (order_datetime, total_amount, status, customer_id, cashier_id, delivery_address_id, payment_method, payment_status) VALUES
(NOW(), 0, 'PENDING', 1, 1, 1, 'CARD', 'UNPAID');

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO restaurant.order_item (order_id, menu_item_id, quantity, unit_price, line_total) VALUES
(
    @new_order_id,
    (SELECT menu_item_id FROM restaurant.menu WHERE name = 'Caesar Salad' LIMIT 1),
    1, 
    (SELECT price FROM restaurant.menu WHERE name = 'Caesar Salad' LIMIT 1),
    (SELECT price FROM restaurant.menu WHERE name = 'Caesar Salad' LIMIT 1)
),
(
    @new_order_id,
    (SELECT menu_item_id FROM restaurant.menu WHERE name = 'Margherita Pizza' LIMIT 1),
    1,
    (SELECT price FROM restaurant.menu WHERE name = 'Margherita Pizza' LIMIT 1),
    (SELECT price FROM restaurant.menu WHERE name = 'Margherita Pizza' LIMIT 1)
),
(
    @new_order_id,
    (SELECT menu_item_id FROM restaurant.menu WHERE name = 'Shrimp Alfredo' LIMIT 1),
    1,
    (SELECT price FROM restaurant.menu WHERE name = 'Shrimp Alfredo' LIMIT 1),
    (SELECT price FROM restaurant.menu WHERE name = 'Shrimp Alfredo' LIMIT 1)
);

UPDATE restaurant.orders
SET total_amount = (
    SELECT SUM(line_total) 
    FROM restaurant.order_item 
    WHERE order_id = @new_order_id)
WHERE order_id = @new_order_id;

COMMIT;

-- Assign a delivery driver
INSERT INTO restaurant.delivery (order_id, driver_id, assigned_time, delivery_status) VALUES
(@new_order_id, 3, NOW(), 'ASSIGNED');

-- Change order status
UPDATE restaurant.orders
SET status = 'PREPARING'
WHERE order_id = @new_order_id;

-- List sales per day or per category

-- Per day
SELECT 
    DATE(o.order_datetime) AS order_date,
    SUM(oi.line_total) AS total_sales
FROM restaurant.orders o
JOIN restaurant.order_item oi ON o.order_id = oi.order_id
GROUP BY order_date;

-- Per category
SELECT 
    c.name AS category_name,
    SUM(oi.line_total) AS total_sales
FROM restaurant.orders o
JOIN restaurant.order_item oi ON o.order_id = oi.order_id
JOIN restaurant.menu m ON oi.menu_item_id = m.menu_item_id
JOIN restaurant.category c ON m.category_id = c.category_id
GROUP BY category_name;

-- Cancel an order
UPDATE restaurant.orders
SET status = 'CANCELLED'
WHERE order_id = 5;