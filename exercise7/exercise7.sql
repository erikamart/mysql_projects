/* Data Types.  
Use the my Guitar Shop database. */
-- Exercise 7

/* 1.Write a SELECT statement that returns these columns from the Order_items table.  order_id, item_price, discount_amount  
Use implicit conversion and the CONCAT function to insert a ‘$’ in the front of  the item_price and discount_amount values.  */
SELECT order_id, CONCAT('$', item_price) AS item_price, CONCAT('$', discount_amount) AS discount_amount
FROM order_items;


/* 2.Write a SELECT statement that returns these fields from the Order_items table.  
order_id, item_price, discount_amount.  
USE the CONVERT function to explicitly convert the item_price and  discount_amount to characters.  */
SELECT order_id, item_price, discount_amount, CONVERT(item_price, CHAR(7)) AS char_Iprice, CONVERT(discount_amount, CHAR(7)) AS char_Damount
FROM order_items;


/* 3.Write a SELECT statement that returns these columns from the Products table:  The list_price column and a column that uses the FORMAT function  to return the list_price column with 1 digit to the right of the decimal  point   */
SELECT list_price, FORMAT(list_price,1) AS formated_listPrice
FROM products;


/* 4.Write a SELECT statement that returns these columns from the Products table:  The list_price column and a column that uses the CAST function to  return the list_price column as an integer */
SELECT list_price, CAST(list_price AS SIGNED) AS int_listPrice
FROM products;


 /* 5.  Display all columns and rows from the products table. Use a string function to change the display of the product_code to all capital letters. 
*/
SELECT product_id, category_id, UPPER(product_code) AS product_code, product_name, description, list_price, discount_percent, date_added
FROM products;


/* 6  Return these columns from the orders table, customer_id, card_type and card_number. Use the substr and lpad functions to render the card number like this 
************9999
*/
SELECT customer_id, card_type, LPAD(SUBSTRING(card_number, 13, 16),16,'0') AS card_number
FROM orders;


/* 7. 
use the concat_ws function to render to display the customer last_name and first_name in this manner
Lackey, Toby
Also display the customer's email address.
only list the customers whose email addresses have more than 15 characters */
SELECT CONCAT_WS(', ', last_name, first_name) AS customer_name, email_address
FROM customers
WHERE LENGTH(email_address) > 15;


/* 8. 
Write a select statement that shows the product_id, product_code, the product_name, and the description for every product in the products table. Capitalize all of the text in the product_codes, and only show the first twenty characters of the product description */
SELECT product_id, UPPER(product_code) AS product_code, product_name, SUBSTRING(description, 1, 20) AS product_description
FROM products;


/* 9.
Display the customer_id and the phone_numbers of all addresses in the address table, format the phone numbers so that they look like this 123.456.7899
*/
SELECT customer_id, REPLACE(phone,'-', '.') AS phone_number
FROM addresses;


/* 10. 
For each product, display the list_price, list_price rounded to 1 decimal place, list_price truncated to 1 decimal place, smallest integer >= list_price, largest integer <= list_price, and a random number between 1 and 10 using the product id as a seed. 
 */
SELECT list_price, ROUND(list_price, 1), TRUNCATE(list_price,1), CEILING(list_price), FLOOR(list_price), FLOOR(RAND(product_id) * (10-1+1))+1 AS product_id
FROM products;