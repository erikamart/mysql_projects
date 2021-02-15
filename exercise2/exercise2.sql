/* Open MySQL workbench, establish your local connection, and insert the queries that answer the following questions, my_guitar_shop
 should already be installed on your home mySQL server, if it is not your active database issue the following command

USE my_guitar_shop;

Test your queries! In a small database such as my_guitar_shop you can determine the expected result set by inspecting the data, 
ensure that your queries return the desired results.

Remember that each SQL statement must be terminated by a semi-colon (;). 
*/
-- Exercise 2

USE my_guitar_shop;

/* 1. Write a select statement that returns only the product_id, product_code, and product_name for 
each product in the products table. Sort this list by product_name in ascending order. */

SELECT product_id, product_code, product_name 
FROM products
ORDER by product_name;


/* 2. Write a select statement that returns only the product_name, product_code, and description for 
each product in the products table that has a category id of 2.  */

SELECT product_name, product_code, description
FROM products
WHERE category_id='2';


/* 3. For each order in the orders tables write a select statement that returns the order_id, customer_id 
and a calculated column named "total fees" that adds the ship_amount and tax_amount values. */

SELECT order_id, customer_id, ship_amount + tax_amount AS total_fees
FROM orders;


/* 4. Write a select statement that returns all of the columns from the order_items table plus an additional 
column called "Net Item Price". This column should subtract the discount_amount from the item_price and then
 multiply this subtraction by the quantity. */

SELECT *, (item_price - discount_amount) * quantity AS Net_Item_Price 
FROM order_items;


/* 5. Write a select statement that returns the customer_id, and one column from the customers table  
named full_name that combines the last name, and the first name of each customer

Format this column using a comma and space so that it looks like this:
Doe, John */

SELECT customer_id, concat(last_name, ", ", first_name) AS full_name
FROM customers;


/* 6. Write a select statement that lists every column from the customers table, but only include rows of 
customers whose last name contains an "n". */

SELECT *
FROM customers
WHERE last_name LIKE '%N%';


/* 7. Write a select statement that returns all columns from the customers table but only returns rows where 
the customer's last name starts with "G" */

SELECT *
FROM customers
WHERE last_name LIKE 'G%';


/* 8. Write a select statement that returns the product_name, list_price, and date_added from the Products table. 
Only return rows where the list price is greater than 500 and less than 2000. Remember there is a distinct difference 
in the these two sql operators 
1. BETWEEN
2. ><
*/

SELECT product_name, list_price, date_added
FROM products
WHERE list_price BETWEEN 500.01 AND 1999.99;
#WHERE list_price > 500 AND list_price < 2000;


/* 9. For each row in the orders table return the order_id, customer_id, and order_date. Format the order_date so 
that it displays like this '01/01/99'. Only include orders that don't have a ship_date. */

SELECT order_id, customer_id, DATE_FORMAT(order_date, '%m/%d/%y') AS order_date
FROM orders
WHERE ship_date IS NULL;


/* 10. Write a select statement that displays each credit card type in the orders table, only display the card type once */ 

SELECT DISTINCT card_type
FROM orders;


/* 11. Write a select statement that returns the customer_id, line1, line2, and phone_number columns from the addresses 
table for any customer located in the state of New Jersey or the city of New York. Rename the customer_id  column as "NY Area Call List".  */

SELECT customer_id AS 'NY Area Call List', line1, line2, phone
FROM addresses
WHERE state = 'NJ' OR city = 'New York';


/* 12. Write a select statement that returns the product_name and discount percent from the products table. Only return rows 
with a discount percent greater than or equal to 25 and less than or equal to 30. Don't use <> operators to do this. */ 

SELECT product_name, discount_percent
FROM products
WHERE discount_percent BETWEEN 25 and 30;


/* 13. Write a query that returns the 3 most expensive products in the products table as indicated by list price of the products. */

SELECT *
FROM products
ORDER BY list_price DESC LIMIT 3;


/* 14. Write a select statement that returns the product_id, the product_name, and the first 50 
characters of the description from the products table. */

SELECT product_id, product_name, LEFT(description, 50) AS description
FROM products;


/* 15. Write a select statement that returns the product_id, product_name, discount_percent, and list_price
 columns from the products table, round the discount_percent to one decimal place and the list_price to 0 decimal places */

SELECT product_id, product_name, ROUND(discount_percent,1) AS discount_percent, ROUND(list_price,0) AS list_price
FROM products;


/* 16. Write a select statement that returns all columns from the orders table, but only returns the five newest
 (most recent) orders in the orders table as shown by the order_date column */

SELECT *
FROM orders
ORDER by order_date DESC LIMIT 5;


/* 17. Write a select statement that returns all columns from the addresses table for customers NOT located in Colorado,
 California, or Oregon. Use the IN operator to accomplish this */

SELECT *
FROM addresses
WHERE state NOT IN ('CO','OR','CA');


/* 18. List all of the orders in the orders table. Only list orders that have a card type of Visa, a tax amount of 0, 
and a shipping amount of 5.00 or less */

SELECT *
FROM orders
WHERE card_type = 'Visa' and tax_amount = 0 and ship_amount <= 5;


/* 19. Use the REGEXP operator to return all columns and all rows from the addresses table where where the street 
address (line1) column ends in 'Rd.' */

SELECT *
FROM addresses
WHERE line1 LIKE '%Rd.';


/*20. List only the orders in the orders table that have not been shipped as indicated in the ship_date column */

SELECT *
FROM orders
WHERE ship_date IS NULL;