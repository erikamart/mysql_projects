-- Exercise 1 - Part 3
SELECT product_name, list_price, date_added
FROM products
ORDER BY product_name;

SELECT COUNT(*) AS number_of_products,
       MIN(list_price) AS least_expensive_product,
       MIN(date_added) AS oldest_product
FROM products;