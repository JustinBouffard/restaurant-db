-- Validate if order can be cancelled
DROP FUNCTION IF EXISTS sf_can_cancel_order;
DELIMITER $$
CREATE FUNCTION sf_can_cancel_order(p_order_id INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE order_status VARCHAR(20);
    
    -- Retrieve order status and order time
    SELECT status INTO order_status
    FROM restaurant.orders
    WHERE order_id = p_order_id;
    
    -- Check if order is already delivered or cancelled
    IF order_status IN ('DELIVERED', 'CANCELLED', 'OUT_FOR_DELIVERY') THEN
        RETURN FALSE;
    END IF;
    
    RETURN TRUE;
END$$
DELIMITER ;

-- Test the function
SELECT sf_can_cancel_order(7) AS can_cancel_order_7; -- should be 1 (true)
SELECT sf_can_cancel_order(4) AS can_cancel_order_4; -- should be 0 (false)

-- Procedure to mark order as delivered and timestamp it
DROP PROCEDURE IF EXISTS sp_mark_order_delivered;
DELIMITER $$
CREATE PROCEDURE sp_mark_order_delivered(IN p_order_id INT)
BEGIN
    -- Update orders
    UPDATE restaurant.orders
    SET status = 'DELIVERED'
    WHERE order_id = p_order_id;

    -- Update delivery
    UPDATE restaurant.delivery
    SET delivery_status = 'DELIVERED',
        delivery_time = NOW()
    WHERE order_id = p_order_id;
END$$
DELIMITER ;

-- Test the procedure
CALL sp_mark_order_delivered(4);
SELECT o.status as order_status, d.delivery_status as delivery_status, d.delivery_time
FROM restaurant.orders o
JOIN restaurant.delivery d ON o.order_id = d.order_id
WHERE o.order_id = 4; -- should be 'DELIVERED', "DELIVERED" and have the delivery_time set

# Calculate total order price
DROP FUNCTION IF EXISTS sf_calculate_order_total;
DELIMITER $$
CREATE FUNCTION sf_calculate_order_total(p_order_id INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(line_total) INTO total
    FROM restaurant.order_item
    WHERE order_id = p_order_id;
    RETURN total;
END$$
DELIMITER ;

# Test the function
SELECT sf_calculate_order_total(1) AS order_1_total; -- should return total for order 1 (should be 53.97)
SELECT sf_calculate_order_total(4) AS order_4_total; -- should return total for order 4 (should be 54.96)