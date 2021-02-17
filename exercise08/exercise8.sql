/* Compose and test 10 queries that answer the questions below. 
*/
-- Exercise 8

/* 1. Write a select statement that generates a random number, the square root, as well as the the floor and the ceiling values of for the discount amount from the row in the order items table that has an order_id of 1. For the floor and ceiling functions use the discount_amount column, for the rand function use the item_id, for the sqrt function use the product _id */
SELECT RAND(item_id), SQRT(product_id), FLOOR(discount_amount), CEILING(discount_amount)
FROM order_items
WHERE order_id = 1;

/* 2. Use now and curtime functions to display these values on your system */
SELECT NOW(), CURTIME();

/* 3. Use the dayofweek function to only return orders shipped on Thursdays or Fridays. Display the order_id, customer_id, ship_date, the day of the week, and customer last name from the  orders and customers table that meet the criteria */
SELECT order_id, o.customer_id, ship_date, DAYOFWEEK(ship_date) AS int_weekday, cu.last_name
FROM orders AS o
JOIN customers AS cu ON o.customer_id= cu.customer_id
WHERE DAYOFWEEK(ship_date) IN (5,6);

/* 4. Display all columns and rows from the products table where the product's date added is in the second quarter of 2012. Hint you will need to use two functions in the WHERE clause, YEAR and QUARTER*/
SELECT *
FROM products
WHERE YEAR(date_added)= 2012
AND QUARTER(date_added)= 2;

/* 5. Use the extract function to return all orders that were placed after twelve noon on any given day. */
SELECT *
FROM orders
WHERE EXTRACT(HOUR FROM order_date) >= '12:00:00';

/* 6. Display the order_id, customer_id, the order_date, ship_date, and the number of days between the order_date and ship_date for each order. If an order has no ship_date omit the order */
SELECT order_id, customer_id, order_date, ship_date, DATEDIFF(ship_date, order_date) AS ProcessDays
FROM orders
WHERE ship_date IS NOT NULL;

/* 7. Use a case function to display the following information from the products table. The product_id, the list_price, the product_code and the words "No discount", if the the discount_percent is zero, "Acceptable discount" if the discount_percent is 15.00, and "High discount" for all others. Name this column Discount_Rating */
SELECT product_id, list_price, product_code, discount_percent,
CASE 
	WHEN discount_percent = 0
		THEN 'No discount'
	WHEN discount_percent = 15
		THEN 'Acceptable discount'
	ELSE 'High discount'
END AS Discount_Rating
FROM products;

/* 8. Use the date format function to display the order_ids and order_dates for all orders. Display the order_date in this format 10/26/14 06:15:00 PM *, use a column alias of your choice for the formatted date*/
SELECT order_id, DATE_FORMAT(order_date,'%m/%d/%y %r') AS order_dates
FROM orders;

/* 9.  USE an IF statement to display the customer_id, the city, state, and the address_id as well as the words "pacific time" for the addresses in CA or OR*. Display all addresses in the table and the words "not pacific" if the state is any other than CA or OR */
SELECT customer_id, city, state, address_id, IF(state IN ('CA','OR'), 'pacific time', 'not pacific') AS time_zone
FROM addresses;

/* 10. Replace the null condition with the words "not shipped" in the orders table. List all orders and sort the list so that the "not shipped" orders are listed first */
SELECT IFNULL(ship_date, 'not shipped') AS ship_status
FROM orders
ORDER BY ship_date;