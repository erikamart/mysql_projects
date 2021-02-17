/* When you are finished with this exercise, you might wish to delete the Guitars table from your installation. If you accidentally alter rows in the products table, restore the my_guitar_shop database from the create_my_guitar_shop.sql file. */ 
-- Exercise 4

/*1. Create a new table in my_guitar_shop called guitars with the same columns as the products table. 
Populate the table by selecting all of the guitars from the products table using the category_id of 1. */
CREATE TABLE guitars AS 
SELECT *
FROM products
WHERE category_id = 1;

SELECT *
FROM guitars;


/* After creating the table run the following statement to set the primary key and auto_increment the product_id. 
If you do not do this, you may have trouble with some of the later queries. */
ALTER TABLE guitars modify product_id INT primary key NOT NULL AUTO_INCREMENT;


/* 2.	Write an INSERT statement that adds this row to the Guitars table: category_id: 1, product_code: Gibson J45, 
product_name: Gibson J-45 Custom Acoustic/Electric Guitar, description: Number one selling acoustic guitar, list_price: 2799.00, 
discount_percent: 20.00, date-added: use today's date.
Hint: remember that the primary key is an auto _increment field in this table.  */
INSERT INTO guitars 
VALUES (default, 1, 'Gibson J45', 'Gibson J-45 Custom Acoustic/Electric Guitar', 'Number one selling acoustic guitar', 2799.00, 20.00, NOW());


/* 3.	Write an UPDATE statement that modifies the row you just added to the guitars table. This statement should change the 
list_price to 2999.99 using the product_code column to identify the row. */
UPDATE guitars
SET list_price = 2999.99
WHERE product_code = 'Gibson J45';

/* 4.	Write a DELETE statement that deletes product 6 from the Guitars table. */
DELETE from guitars
WHERE product_id = 6;

/* 5.	Write an INSERT statement that adds this row to the Guitars table: Column names are on left - values on right
product_id: 		The next automatically generated ID  
category_id: 		1 
product_code: 		dgx_640 
product_name: 		Yamaha DGX 640 Guitar 
list_price: 		799.99 
date_added: 		Today’s date/time. 

Use a named column list for this statement. Note that you will have to address the fact that the description column does not have 
a default value assigned to it. You may address this in several ways your choice of how you choose to, but the statement must run*/

INSERT INTO guitars (product_id, category_id, product_code, product_name, description, list_price, date_added)
VALUES (default, 1, 'dgx_640', 'Yamaha DGX 640 Guitar', '', 799.99, NOW());

/* 6.	Write an UPDATE statement that modifies the product you added in problem 5 . This statement should change the 
discount_percent column to 35% and the description to "Yamaha Lightweight Deluxe Electric Guitar ". */
UPDATE guitars
SET discount_percent = 35
WHERE product_id = 8;


/* 7.	Write a DELETE statement that deletes all the guitars from the Guitars table where the product_name includes the word 'Yamaha'  */
DELETE FROM guitars
WHERE product_name LIKE '%Yamaha%';


/* 8.	Write an UPDATE statement that modifies the Guitars table. Change the discount_percent to 10% for any 
row that has a discount_percent less than 10%  */
UPDATE guitars
SET discount_percent = 10
WHERE discount_percent < 10;


/* 9.	Write a statement that reduces the list_price by $100 for any guitar that has a match in the order_items table. Use a subquery 
like the example on page 157. */
CREATE TABLE tempG AS
SELECT DISTINCT g.product_id 
	FROM guitars AS g
	INNER JOIN order_items AS o ON g.product_id = o.product_id;

UPDATE guitars
SET list_price = list_price - 100
WHERE product_id IN 
	(SELECT * FROM tempG);

DROP TABLE tempG;

/* 10.	Change the category_id to 2 for any row in the guitars table that has a product_code of strat. */
UPDATE guitars
SET category_id = 2
WHERE product_code = 'strat';