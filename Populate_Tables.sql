-- Sample Data for Restaurant Database

-- Roles
INSERT INTO role (name, description) VALUES
('Manager', 'Restaurant manager'),
('Cashier', 'Cashier and order processing'),
('Chef', 'Kitchen staff'),
('Driver', 'Delivery driver'),
('Host', 'Front of house staff');

-- Employees
INSERT INTO employee (role_id, first_name, last_name, email, phone, hire_date, active) VALUES
(1, 'John', 'Smith', 'john.smith@restaurant.com', '555-0101', '2023-01-15', 1),
(2, 'Sarah', 'Johnson', 'sarah.johnson@restaurant.com', '555-0102', '2023-02-20', 1),
(3, 'Marco', 'Rossi', 'marco.rossi@restaurant.com', '555-0103', '2023-03-10', 1),
(4, 'Michael', 'Brown', 'michael.brown@restaurant.com', '555-0104', '2023-04-05', 1),
(5, 'Emily', 'Davis', 'emily.davis@restaurant.com', '555-0105', '2023-05-12', 1),
(2, 'David', 'Wilson', 'david.wilson@restaurant.com', '555-0106', '2023-06-18', 1),
(4, 'Jessica', 'Martinez', 'jessica.martinez@restaurant.com', '555-0107', '2023-07-22', 1);

-- Customers
INSERT INTO customer (first_name, last_name, email, phone, created_at) VALUES
('Alice', 'Anderson', 'alice.anderson@email.com', '555-1001', '2024-01-10 10:30:00'),
('Bob', 'Bennett', 'bob.bennett@email.com', '555-1002', '2024-01-15 14:20:00'),
('Carol', 'Carter', 'carol.carter@email.com', '555-1003', '2024-02-01 09:15:00'),
('David', 'Duncan', 'david.duncan@email.com', '555-1004', '2024-02-10 18:45:00'),
('Elena', 'Evans', 'elena.evans@email.com', '555-1005', '2024-03-05 12:00:00'),
('Frank', 'Foster', 'frank.foster@email.com', '555-1006', '2024-03-15 15:30:00');

-- Addresses
INSERT INTO address (customer_id, street, city, postal_code, notes, is_default) VALUES
(1, '123 Main St', 'Quebec City', 'G1R 1A1', 'Apartment 201', 1),
(1, '456 Oak Ave', 'Quebec City', 'G1R 2B2', 'House with gate', 0),
(2, '789 Elm St', 'Quebec City', 'G1S 3C3', NULL, 1),
(3, '321 Pine Rd', 'Beaumont', 'G0R 1A0', 'Downtown building', 1),
(4, '654 Maple Dr', 'Quebec City', 'G1R 4D4', 'Leave at front door', 0),
(5, '987 Cedar Lane', 'Laval', 'H7A 1E1', NULL, 1),
(6, '147 Birch Blvd', 'Quebec City', 'G1R 5E5', 'Call upon arrival', 1);

-- Categories
INSERT INTO category (name, description) VALUES
('Appetizers', 'Starters and small plates'),
('Main Courses', 'Entrees and primary dishes'),
('Pasta', 'Italian pasta dishes'),
('Desserts', 'Sweet treats and pastries'),
('Beverages', 'Drinks and beverages');

-- Menu Items
INSERT INTO menu (category_id, name, description, price, is_available) VALUES
(1, 'Bruschetta', 'Toasted bread with tomatoes and garlic', 7.99, 1),
(1, 'Calamari Fritti', 'Fried squid with marinara sauce', 9.99, 1),
(2, 'Grilled Salmon', 'Fresh salmon fillet with lemon butter', 24.99, 1),
(2, 'Ribeye Steak', '12oz premium cut with seasonal vegetables', 34.99, 1),
(2, 'Chicken Parmesan', 'Breaded chicken breast with mozzarella', 18.99, 1),
(3, 'Spaghetti Carbonara', 'Creamy egg sauce with pancetta', 16.99, 1),
(3, 'Fettuccine Alfredo', 'Fresh pasta with creamy Alfredo sauce', 15.99, 1),
(4, 'Tiramisu', 'Classic Italian layered dessert', 7.99, 1),
(4, 'Panna Cotta', 'Silky smooth Italian custard', 6.99, 1),
(5, 'House Wine', 'By the glass', 8.99, 1),
(5, 'Espresso', 'Single or double shot', 3.99, 1);

-- Inventory Items
INSERT INTO inventory (name, unit, current_quantity, reorder_level) VALUES
('Tomatoes', 'kg', 45.5, 20),
('Garlic', 'bulbs', 120, 50),
('Olive Oil', 'liters', 30, 10),
('Salmon Fillet', 'kg', 18.5, 10),
('Ribeye Beef', 'kg', 25, 15),
('Chicken Breast', 'kg', 40, 20),
('All Purpose Flour', 'kg', 50, 25),
('Eggs', 'dozen', 15, 8),
('Pasta (Spaghetti)', 'kg', 22, 10),
('Mascarpone Cheese', 'kg', 8.5, 5),
('Parmesan Cheese', 'kg', 12, 8),
('Heavy Cream', 'liters', 20, 10),
('Butter', 'kg', 15, 8),
('Pancetta', 'kg', 5.5, 3);

-- Menu Item Ingredients
INSERT INTO menu_item_ingredient (menu_item_id, inventory_item_id, quantity_per_unit) VALUES
(1, 1, 0.15),  -- Bruschetta uses tomatoes
(1, 2, 0.05),  -- Bruschetta uses garlic
(1, 3, 0.02),  -- Bruschetta uses olive oil
(3, 5, 0.25),  -- Grilled Salmon
(4, 6, 0.35),  -- Ribeye Steak
(5, 7, 0.15),  -- Chicken Parmesan uses flour
(5, 8, 0.1),   -- Chicken Parmesan uses eggs
(5, 11, 0.08), -- Chicken Parmesan uses parmesan
(6, 9, 0.2),   -- Spaghetti Carbonara uses pasta
(6, 13, 0.03), -- Spaghetti Carbonara uses butter
(6, 14, 0.08), -- Spaghetti Carbonara uses pancetta
(7, 9, 0.2),   -- Fettuccine Alfredo uses pasta
(7, 12, 0.15), -- Fettuccine Alfredo uses cream
(7, 13, 0.04), -- Fettuccine Alfredo uses butter
(8, 10, 0.15), -- Tiramisu uses mascarpone
(9, 12, 0.12); -- Panna Cotta uses cream

-- Orders
INSERT INTO orders (customer_id, cashier_id, delivery_address_id, order_datetime, status, payment_method, payment_status, total_amount) VALUES
(1, 2, 1, '2024-11-20 18:30:00', 'DELIVERED', 'CARD', 'PAID', 54.97),
(2, 2, 3, '2024-11-21 19:00:00', 'DELIVERED', 'CASH', 'PAID', 41.98),
(3, 6, 4, '2024-11-22 12:15:00', 'DELIVERED', 'ONLINE', 'PAID', 32.98),
(4, 2, 5, '2024-11-23 17:45:00', 'OUT_FOR_DELIVERY', 'CARD', 'PAID', 59.97),
(5, 6, 6, '2024-11-24 18:00:00', 'PREPARING', 'ONLINE', 'UNPAID', 33.98),
(1, 2, 1, '2024-11-25 19:30:00', 'PENDING', 'CARD', 'UNPAID', 47.97);

-- Order Items
INSERT INTO order_item (order_id, menu_item_id, quantity, unit_price, line_total) VALUES
(1, 3, 2, 24.99, 49.98),  -- 2x Grilled Salmon
(1, 11, 1, 3.99, 3.99),   -- 1x Espresso
(2, 6, 2, 16.99, 33.98),  -- 2x Spaghetti Carbonara
(2, 9, 1, 6.99, 6.99),    -- 1x Panna Cotta
(2, 10, 1, 8.99, 8.99),   -- 1x House Wine
(3, 2, 1, 9.99, 9.99),    -- 1x Calamari Fritti
(3, 5, 2, 18.99, 37.98),  -- 2x Chicken Parmesan (note: adjust order total if needed)
(4, 4, 1, 34.99, 34.99),  -- 1x Ribeye Steak
(4, 8, 2, 7.99, 15.98),   -- 2x Tiramisu
(4, 11, 1, 3.99, 3.99),   -- 1x Espresso
(5, 1, 1, 7.99, 7.99),    -- 1x Bruschetta
(5, 7, 2, 15.99, 31.98),  -- 2x Fettuccine Alfredo
(6, 3, 1, 24.99, 24.99),  -- 1x Grilled Salmon
(6, 1, 1, 7.99, 7.99);    -- 1x Bruschetta

-- Delivery Records
INSERT INTO delivery (order_id, driver_id, assigned_time, pickup_time, delivery_time, delivery_status) VALUES
(1, 4, '2024-11-20 18:35:00', '2024-11-20 18:50:00', '2024-11-20 19:15:00', 'DELIVERED'),
(2, 7, '2024-11-21 19:05:00', '2024-11-21 19:20:00', '2024-11-21 19:45:00', 'DELIVERED'),
(3, 4, '2024-11-22 12:20:00', '2024-11-22 12:35:00', '2024-11-22 13:00:00', 'DELIVERED'),
(4, 7, '2024-11-23 17:50:00', '2024-11-23 18:05:00', NULL, 'OUT_FOR_DELIVERY');

-- Order Status History
INSERT INTO order_status_history (order_id, old_status, new_status, changed_by_employee_id, changed_at) VALUES
(1, 'PENDING', 'PREPARING', 3, '2024-11-20 18:32:00'),
(1, 'PREPARING', 'OUT_FOR_DELIVERY', 3, '2024-11-20 18:50:00'),
(1, 'OUT_FOR_DELIVERY', 'DELIVERED', 1, '2024-11-20 19:15:00'),
(2, 'PENDING', 'PREPARING', 3, '2024-11-21 19:02:00'),
(2, 'PREPARING', 'OUT_FOR_DELIVERY', 3, '2024-11-21 19:20:00'),
(2, 'OUT_FOR_DELIVERY', 'DELIVERED', 1, '2024-11-21 19:45:00'),
(3, 'PENDING', 'PREPARING', 3, '2024-11-22 12:17:00'),
(3, 'PREPARING', 'OUT_FOR_DELIVERY', 3, '2024-11-22 12:35:00'),
(3, 'OUT_FOR_DELIVERY', 'DELIVERED', 1, '2024-11-22 13:00:00'),
(4, 'PENDING', 'PREPARING', 3, '2024-11-23 17:47:00'),
(4, 'PREPARING', 'OUT_FOR_DELIVERY', 3, '2024-11-23 18:05:00'),
(5, 'PENDING', 'PREPARING', 3, '2024-11-24 18:02:00'),
(6, 'PENDING', 'PENDING', 2, '2024-11-25 19:30:00');