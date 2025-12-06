-- Trigger to prevent deleting menu items that are part of active orders
DROP TRIGGER IF EXISTS trg_prevent_menu_item_deletion;
DELIMITER $$
CREATE TRIGGER trg_prevent_menu_item_deletion
BEFORE DELETE ON menu
FOR EACH ROW
BEGIN
    DECLARE active_order_count INT;

    -- Check if the menu item is part of any active orders
    SELECT COUNT(*) INTO active_order_count
    FROM order_item oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE oi.menu_item_id = OLD.menu_item_id
      AND o.status IN ('PENDING', 'PREPARING', 'OUT_FOR_DELIVERY');

    IF active_order_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete menu item that is part of active orders.';
    END IF;
END$$
DELIMITER ;

-- Test the trigger
-- Attempt to delete a menu item that is part of an active order
-- Should not work and will cause an error
DELETE FROM menu 
WHERE name = 'Caesar Salad';