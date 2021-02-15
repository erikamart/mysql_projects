# Multiple-Table Queries
### **Objectives:**
  - Use joins to retrieve data from more than one table
  - Use an alias
  - Join a table to itself
  - Perform UNION operations Use the ALL and ANY operators in a query Perform special operations (inner join, outer join, and product)
  - Implicit and explicit syntax  

### **Read Chapter 4: How to retrieve data from two or more tables.**  
  
### **Joining tables:**
A *`join`* combines columns from two or more tables into a single result set.
An *`inner join`* contains only those rows and the columns you specify that statisfy the *`join condition`*.
A join may use ***explicit syntax*** or the join may be executed ***implicitly*** in the `SELECT` clause of the `STATEMENT`.  
  
#### Explicit example:

```  
SELECT invoice_number, vendor_name
FROM vendors
INNER JOIN invoices ON vendors.vendor_id = invoices.vendor_id 
ORDER BY invoice_number
```


#### Implicit example:
```
SELECT invoice_number, vendor_name
FROM vendors, invoices
WHERE vendors.vendor_id = invoices.vendor_id 
ORDER BY invoice_number
```

Either method works the same. The explicit example is recommended by the book because it is easier to interpret by anyone. Lets break down the explicit example into its component parts to interpret it.  
  
- `SELECT invoice_number, vendor_name`  
- We have a column selection in a `SELECT` clause. The only issue in multiple table queries is if the fields have the same name in both tables.
- If you have the same name in 2 tables, ***qualify*** the field names with the table name followed by a period.  
- `SELECT invoices.invoice_id, vendors.vendor_name`
- You can qualify field names at any time in any query.  

`FROM vendors`  
  In this example the vendors table is specified. Either table could be specified.  

`INNER JOIN invoices ON vendors.vendor_id = invoices.vendor_id`
 
 An inspection of the data shows that `vendor_id` is the ***primary key*** of the **vendors** table, and `vendor_id` is the ***foreign key*** in the **invoices** table. In other words this set of values constitute the ***relationship*** between the two tables or what the two tables have in common. An `inner join` means that a row is generated only when the **ON** condition is met.  

There are 114 rows in the **invoice** table, so there will be 114 rows in the queries result set. The difference is that the `vendor_name` (useful) instead of the `vendor_id` (not so useful) is generated in the result set.  
  
### **Table Aliases**
For readability and ease of coding table ***aliases*** may be specified. This makes qualifying column names easier and often makes a query simpler to follow.  
```
SELECT * FROM invoices i 
  INNER JOIN vendors v ON v.vendor_id = i.vendor_id
```  
### **Joining Tables From Different Databases**
An accounts payable (vendor) dataset may exist in another database than a customer order (invoices) dataset. To join tables from separate databases, ***qualify*** the table names with the database name.  
```
SELECT * FROM om.invoices
```
Note that just as columns may always be *qualified*, although not always necessary, most often a query is working with tables within the same database and the table qualification is not necessary.  
  
### **Compound Join Conditions**
Seldom needed when joining only two tables with a direct one-to-many relationship. It can be accomplished using the syntax seen in the following example.
Example: An employee also has a customer account with her employer.
```
SELECT customer_first_name, customer_last_name 
FROM customers JOIN employees
  ON customers.customer_first_name = employees.first_name 
  AND customers.customer_last_name = employees.last_name
```
Note: this join is an `INNER` join (meaning all conditions must be true of both tables) by default, therefore the `INNER` keyword is omitted. For clarity, the columns are qualified in the compound condition, but it is not necessary because the column names in the two tables are different.  

### **Joining A Table To Itself**

Useful for analysis like:
- How many of our customers are located in the same zip code? - Which employees report to this supervisor?
- Do I have duplicate records in this table?  
 
A `self-join` joins a table to itself. Self-joins are useful for tables with a self-referencing relationship, or when one wants to determine data inconsistencies. Aliases can be used to treat the table as two separate tables, that is, giving the same table two different aliases.  

**Using a Self-Join on a Primary Key**  
A self-join can involve the *primary key* of a table. This occurs when a *foreign key* in the table is the same as the *primary key* of the table. For example, in an Employee table, `EMPLOYEE_NUM` may be the *primary key* and `MGR_EMPLOYEE_NUM` could be another column, which represents the employee number of the employee’s manager. Because the
 manager is also an employee, `MGR_EMPLOYEE_NUM` is a *foreign key* whose value will match the value of the *primary key* of the same table.  

Use `DISTINCT` keywords and `<>` operators to avoid repetitive rows in the result set.  

Use two separate table aliases and *qualify* the column names with the aliases.  
```
SELECT DISTINCT v1.vendor_name, v1.vendor_city, v1.vendor_state
FROM vendors v1 JOIN vendors v2
  On v1.vendor_city = v2.vendor_city 
    AND
      v1.vendor_state = v2.vendor_state 
    AND
      v1.vendor_name <> v2.vendor_name 
ORDER BY v1.vendor_state, v1.vendor_city
```
Removing the `DISTINCT` keyword from this query results in thousands of rows.
Removing the `<>` operator clause results in 122 rows which is the entire number of rows in the vendor table!  

### **Joining More Than Two Tables**
Joining multiple tables in a relational database requires separate test conditions for each table. Join one table that has a direct one-to-many relationship with the next table, join the second table to third, and the third to fourth. It’s common in a database to join many tables in a query.  

Joining 4 tables to produce a result set would require at least three join conditions.  
    Table 1  --->  Table 2  --->  Table 3  --->  Table 4  

The best way to approach a complex multiple table join is to familiarize yourself with the tables in a relational database and structure the query’s join conditions based on the primary and foreign keys of each table. In other words, ask yourself what does table one have in common with table two? Table two to table three? Table three to table four?  

Suppose the need is to generate a report that states the ***vendor’s name***, any current ***invoice numbers*** (ones that have an outstanding balancing), the ***date*** of the invoice, the line ***item amount*** of the invoice, and ***GL account description*** that the invoice pertains to.  

By inspecting the data we can determine the following:
  1. The ***GL account description*** is located in the `general_ledger_accounts` table but the *primary key* of this table is `general_ledger_id`.
  2. The general ledger id is a *foreign key* in the `invoice_line_items` table. No information is required from this table for the result table but this table is the linking table between the general ledger description and the invoice amounts. The `invoice_line_items` table has a compound *primary key*. The `invoice_id` and the sequence. Why? How often do you purchase only one item in a transaction? Think of your last trip to the grocery. This table however stores the transaction GL ids that we need to extract the result set.
  3. The invoices table relates to the invoice_line_item by invoice_id. And stores the transaction date as well as the invoice number and the invoice total amount.
  4. Finally the vendors table stores the vendor’s name has a primary key of vendor_id, which is stored as a foreign key in the invoices table.

Two approaches to the syntax.  
```
SELECT vendor_name, invoice_number, invoice_date, line_item_amount, account_description
FROM vendors
  JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
  JOIN invoice_line_items
    ON invoice_line_items.invoice_id = invoices.invoice_id
  JOIN general_ledger_accounts
ON line_items_invoice.account_number = general_ledger_accounts.account_number 
WHERE invoice_total – payment_total – credit_total > 0
ORDER BY vendor_name, line_item_amount DESC
```
1. Determine columns and if the names are repeated in different tables qualify them.
2. Join table 1 (vendors) to table 2 (invoices) based on the tables’ relationship.
3. Join table 2 (invoices) to table 3 (invoices_line_items) based on the tables’
relationship.
4. Join table 3 (invoices_line_items) to table 4 (general_ledger_accounts) based
on the tables’ relationship.
5. Qualify which records you want (in this example only invoice items that have a
balance)
6. Sort the result set.
 
Another syntax for a four table join inner join.  
```
SELECT vendor_name, invoice_number, invoice_date, line_item_amount, account_description
FROM vendors, invoices, line_items_invoice, vendors, general_ledger_accounts 
WHERE
  line_items_account.account_number = general_ledger_accounts.account_number 
AND
  vendors.vendor_id = invoices.vendor_id 
AND
  line_items_invoice.invoice_id = invoices.invoice_id 
WHERE invoice_total – payment_total – credit_total > 0 
ORDER by vendor_name, line_item_amount DESC
```
### **Outer Joins**
`OUTER JOIN`: lists all the rows from one table whether or not it matches the second table based on the condition of the `WHERE` clause.
Three types:
- L`EFT JOIN`: includes all rows from the table on the left (i.e. first table listed), but only rows from the table on the right (second table listed) that match the first table.
- `RIGHT JOIN`: includes all rows from the table on the right (i.e. second table listed), but only rows from the table on the left (first table listed) that match the second table.
- `FULL OUTER JOIN` or `PRODUCT`: includes all rows from both tables whether or not they match based on the condition in the `WHERE` clause. It is rarely used.  

An example of an `outer join` would be if you required a list of all customers and if the customers have an open order list too.  

To specify an `outer join` requires a combination of two key words. `LEFT` or `RIGHT`and `JOIN`.  
```
SELECT vendor_name, invoice_number, invoice_total 
FROM vendors LEFT JOIN invoices
  ON vendors.vendor_id = invoices.vendor_id
```
The above results in a list of all vendors and if the vendors have an invoice associated with them, that is listed as well.  

### **The `USING` Keyword**
Short hand keyword that may be used when two column names from different tables have the same name.  
```
SELECT invoice_number, vendor_name 
FROM vendors
  JOIN invoices USING (vendor_id)
```
This only works when explicit `JOIN` syntax us used.  

### **The `NATURAL` keyword**
When only one column in each of two tables has the same name the `NATURAL` keyword can shorten the statement length. Not easy to implement in complex queries, and will yield unexpected results if the tables have more than one column name in common.  
```
SELECT invoice_number, vendor_name 
FROM vendors
  NATURAL JOIN invoices
```
`CROSS JOINS` resulting in a Cartesian product result set.
Usually done by accident. Rarely, if ever, used for application purposes.  

To explicitly execute this type of join use the `CROSS JOIN` clause instead of the `JOIN ON` clause.  

This type of join is typically done by mistake, by not relating two tables together using `JOIN` or `WHERE` syntax.  
```
SELECT orders.invoice_id, invoice_date, amount, order_detail.product_id 
FROM orders, order_detail
```
Without a `WHERE` clause specifying a comparison value between the two tables, the result set renders a Cartesian product. The number of all the rows in `orders` times the number of all the rows in `order_detail`.  

The result set is meaningless (and very large) because each order is not uniquely associated with each product associated with that order.  

### **UNION statements**
- Similar to a join but works with two result sets generated by two or more SELECT statements.
- The number of columns selected from each table must be the same.
- The data types (numeric, character, date) must be compatible in the columns.
- Optionally use the `AS` keyword to define an additional column to reference which table a row is selected from.
- Differs from an `outer join` in that an `outer join` combines all records of one table and some records whereas a `UNION` can limit the result sets of both `SELECT` statements.
- Column selection order must be the same left to right although column name need not be. For example don’t `SELECT DATE, AMOUNT` in one select statement and `BALANCE, DATE`. In the second `SELECT` statement
- To sort the combined result set you must use the column name(s) from the first `SELECT` statement.  
```
SELECT ‘Active’ AS source, invoice_number, invoice_date, invoice_total 
  FROM active_invoices
  WHERE invoice_date >= ‘2011-06-01’ 
UNION
SELECT ‘Paid’ AS source, invoice_number, invoice_date, invoice_total 
  FROM paid_invoices
  WHERE invoice_date >= ‘2011-06-01’
```
### **Troubleshooting Multiple Table Queries**
Often `joins` will execute without errors but the result set is wrong.  

Some tips to assist with ensuring your queries display the data requested accurately.  

- If using calculations on a table value use a calculator to test your result set on one or more records.
- Know the row counts of the tables being read, usually a row count of a result set that is equal to the row count of one of the tables means something is wrong.
- If possible, test your result sets against a small data set before executing over a large amount of data.
- Always remember this general rule: Number of tables – 1 = number of comparison operators **required**.
- Review your result set! In the workbench, you may sort the columns of a result set simply by clicking on the column. If your query is 'West Coast Customers' and you’re result set contains rows with a state value of TX, something is wrong.  
