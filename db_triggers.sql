-- Trigger to prevent deleting menu items that are part of active orders
DROP TRIGGER IF EXISTS prevent_menu_item_deletion;
DELIMITER $$
CREATE TRIGGER prevent_menu_item_deletion
BEFORE DELETE ON restaurant.menu
FOR EACH ROW
BEGIN
    DECLARE active_order_count INT;

    -- Check if the menu item is part of any active orders
    SELECT COUNT(*) INTO active_order_count
    FROM restaurant.order_item oi
    JOIN restaurant.orders o ON oi.order_id = o.order_id
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
DELETE FROM restaurant.menu 
WHERE name = 'Caesar Salad';

-- Automatically update inventory when an item is ordered
DROP TRIGGER IF EXISTS update_inventory_on_order;
DELIMITER $$
CREATE TRIGGER update_inventory_on_order
AFTER INSERT ON restaurant.order_item
FOR EACH ROW
BEGIN
    -- Update inventory for each ingredient in the ordered menu item
    UPDATE restaurant.inventory i
    JOIN restaurant.menu_item_ingredient mii ON i.inventory_item_id = mii.inventory_item_id
    SET i.current_quantity = i.current_quantity - (NEW.quantity * mii.quantity_per_unit)
    WHERE mii.menu_item_id = NEW.menu_item_id;
END$$
DELIMITER ;

-- Test the inventory update trigger
-- Check current inventory levels
SELECT inventory_item_id, name, current_quantity FROM restaurant.inventory LIMIT 5;

-- Check menu item ingredients
SELECT menu_item_id, inventory_item_id, quantity_per_unit FROM restaurant.menu_item_ingredient LIMIT 5;

-- Insert a test order item
INSERT INTO restaurant.order_item (order_id, menu_item_id, quantity, unit_price, line_total)
VALUES (1, 1, 2, 12.99, 25.98);

-- Check inventory again to see if it was decremented
SELECT inventory_item_id, name, current_quantity FROM restaurant.inventory LIMIT 5;



SELECT * FROM restaurant.orders;
