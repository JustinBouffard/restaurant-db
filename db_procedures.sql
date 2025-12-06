-- Validate if order can be cancelled stored function
DROP FUNCTION IF EXISTS sf_can_cancel_order;
DELIMITER $$
CREATE FUNCTION sf_can_cancel_order(p_order_id INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE order_status VARCHAR(20);
    
    -- Retrieve order status and order time
    SELECT status INTO order_status
    FROM orders
    WHERE order_id = p_order_id;
    
    -- Check if order is already delivered or cancelled
    IF order_status IN ('DELIVERED', 'CANCELLED', 'OUT_FOR_DELIVERY') THEN
        RETURN FALSE;
    END IF;
    
    RETURN TRUE;
END$$
DELIMITER ;

-- Test the function
SELECT sf_can_cancel_order(8) AS can_cancel_order_8; -- should be 1 (true)
SELECT sf_can_cancel_order(5) AS can_cancel_order_5; -- should be 0 (false)

-- Procedure to mark order as delivered and timestamp it
DROP PROCEDURE IF EXISTS sp_mark_order_delivered;
DELIMITER $$
CREATE PROCEDURE sp_mark_order_delivered(IN p_order_id INT)
BEGIN
    -- Update orders
    UPDATE orders
    SET status = 'DELIVERED'
    WHERE order_id = p_order_id;

    -- Update delivery
    UPDATE delivery
    SET delivery_status = 'DELIVERED',
        delivery_time = NOW()
    WHERE order_id = p_order_id;
END$$
DELIMITER ;

-- Test the procedure
CALL sp_mark_order_delivered(8);
SELECT status FROM orders WHERE order_id = 8; -- should be 'DELIVERED'
