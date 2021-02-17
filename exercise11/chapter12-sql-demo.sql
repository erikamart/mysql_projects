-- Chapter 12 Notes
/* VIEW - a view is a select statement that extracts data from one or more base tables.
Data isn't stored in a view but the rows and columns remain in the base table(s).
*/ 
-- basic syntax of a create view command
CREATE VIEW premium_products AS SELECT * FROM products WHERE list_price > 500.00;
SELECT * FROM premium_products;
-- can be used anywhere you would normally use a table reference
-- within constraints data in base tables may be updated using views
UPDATE premium_products SET discount_percent = 25.00 WHERE product_id = 10;
-- you can limit the columns of a view as you would with a query by specifying only certain columns in the create view statement
-- it is also possible to limit the rows of a view by qualifying the FROM clause with WHERE conditions
CREATE VIEW non_active_products AS SELECT * FROM products WHERE product_id NOT IN
(SELECT DISTINCT product_id FROM order_items);
SELECT * FROM non_active_products;
SELECT * FROM products;
-- you may use joins to create views
CREATE VIEW billing_customers_contact AS
SELECT  customers.customer_id, last_name,  phone, email_address, line1, line2, city, state, zip_code FROM customers
JOIN addresses 
ON customers.billing_address_id = addresses.address_id;
SELECT * FROM billing_customers_contact;

-- a view may use the limit clause to only show the biggest or smallest values in a base table it may also include a calculated value
CREATE VIEW top_5 AS SELECT product_id, order_id, (item_price - discount_amount) * quantity AS line_item_gross FROM order_items
ORDER BY line_item_gross DESC
LIMIT 5;
SELECT * from top_5;
-- rules for creating an updatable view page 363
-- CHECK OPTION used to prevent an update to a base table row that would remove the row from the view
DROP VIEW premium_products;
CREATE VIEW premium_products AS SELECT * FROM products WHERE list_price > 500.00
WITH CHECK OPTION;
DELETE FROM products where product_id = 99;
select * from premium_products;
UPDATE premium_products SET list_price = 200.00 WHERE product_id = 2;

-- a view may be used to insert a row into the base table if the WHERE condition of the view is satisfied if CHECK OPTION is specified
INSERT INTO premium_products VALUES (99, 3, 'test', 'more info', 'needs more info', 600.00, 10.00, now());
SELECT * FROM products;
INSERT INTO premium_products VALUES (88, 3, 'test', 'more info', 'needs more info', 200.00, 10.00, now());

-- to alter a view its best to DROP it and recreate 
