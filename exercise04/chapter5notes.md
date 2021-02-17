# Lesson 4: Updating Data  

### **Objectives:**
- Create a new table from an existing table 
- Change data using the `UPDATE` command 
- Add new data using the `INSERT` command
- Delete data using the `DELETE` command 
- Use nulls in `UPDATE` commands
- Change the structure of an existing table
- Use the `COMMIT` and `ROLLBACK` commands to make permanent data updates or to reverse updates
- Understand transactions and the role of `COMMIT` and `ROLLBACK` in supporting transactions
- Drop a table

### **Read Chapter 5: Updating Data**

### **Creating a table from an existing table (copy a table):**  

Creates a table with the same structure as an existing table. The new table will have no data.  

| SQL Statement               | Description                                                                                                                                     |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| CREATE newTableName         | Required. Identifies the name of the new table to be created                                                                                    |
| AS existingTableName        | Required. Identifies the copied table’s name.                                                                                                   |
| SELECT * From source_table. | CREATE TABLE ORDER_COPY AS SELECT * FROM ORDERS would duplicate all of the table rows but not the Primary,Foreign key designations, or indexes. |
| SELECT/WHERE clauses        | These could limit the rows in the copied table.                                                                                                 |
| Limit rows                  | CREATE TABLE TAXABLE_ORDERS AS SELECT * FROM ORDERS WHERE tax_amount > 0                                                                        |
| SELECT/WHERE clauses        | If for some reason you only wanted only certain columns                                                                                         |
| Limit columns               | CREATE TABLE email_list AS SELECT email_address from CUSTOMERS                                                                                  |
  
### **Changing existing data in a table:**
| SQL Statement          | Description                                                                                                                                                          |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| UPDATE table_name      | Required. Identifies the table that contains the data to be updated.                                                                                                 |
| SET columnName = value | Required. Identifies the table the data will be retrieved from.                                                                                                      |
| WHERE condition        | Optional. Specifies which row(s) are to be updated. If WHERE condition left off, all rows in the table will be updated. Any simple or complex condition may be used. |

### **Use a subquery to update values in a table**
Suppose the sales tax rate changes for customers in a specific state.
```
UPDATE ORDERS SET tax_code = ‘2’ WHERE customer_id =
(SELECT customer_id FROM customers WHERE state = ‘TX’)
```
### **Add new row(s) to an existing table**
| SQL Statement                                             | Description                                                                                                                                                                                                      |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| INSERT INTO table_name                                    | Required. Identifies the table that the row will be inserted into                                                                                                                                                |
| VALUES (column1_value,column2_ value, column3_value, ...) | Required. Lists the values to be inserted in the table in sequential order starting with the first column. You must list values for all columns.                                                                 |
| DEFAULT keyword                                           | If a default value is defined for a column you may use the default keyword in the insert command to populate the inserted rows. Good for adding data that has only been partially captured, like a new customer. |
| NULL                                                      | If a column is “nullable” inserts an empty space into the column/row value.                                                                                                                                      |
| INSERT IGNORE                                             | Good for populating an existing table from another table that might have some of the same rows.                                                                                                                  |

### **Use a subquery to insert one or more rows:** 
Could be useful for archiving records for example.
First copy the tables structure:
```
CREATE TABLE order_archive LIKE orders;
INSERT * INTO order_archive SELECT * from orders WHERE order_date < ‘2012-04-01’;
```
### **Deleting existing rows from a table:**
| SQL Statement          | Description                                                                                                                                          |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| DELETE FROM table_name | Required. Identifies the table that contains the data to be deleted.                                                                                 |
| WHERE condition        | Optional. Specifies which row(s) are to be updated. If left off, all rows in the table will be deleted. Any simple or complex condition may be used. |
| ;                      | Required. Indicates the end of the SQL statement.                                                                                                    |

### **Changing a value in a column to `NULL`:**
| SQL Statement         | Description                                                                                                                                          |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| UPDATE table_name     | Required. Identifies the table that contains the data to be udpated.                                                                                 |
| SET columnName = NULL | Required. Identifies the table the data will be retrieved from.                                                                                      |
| WHERE condition       | Optional. Specifies which row(s) are to be updated. If left off, all rows in the table will be updated. Any simple or complex condition may be used. |
| ;                     | Required. Indicates the end of the SQL statement.                                                                                                    |

### **Changing a table's Structure:**
Add a column: The column will be added, but will not contain any data. You will need to run an `UPDATE` command to add values into the column.  
| SQL Statement                    | Description                                                                                    |
| -------------------------------- | ---------------------------------------------------------------------------------------------- |
| ALTER TABLE table_name           | Required. Identifies the table to be altered                                                   |
| ADD column_name dataType(length) | Required. Identifies the column to be added. It will be added at the end of the other columns. |
| ;                                | Required. Indicates the end of the SQL statement.                                              |

### **Modify a column:**
Used to change a characteristic of a data field such as the length or whether it allows NULL values. You generally cannot change the data type as it will result in invalid data values in the column. If you shorten a length, it will truncate the value in the column.
| SQL Statement                           | Description                                                                                                                 |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| ALTER TABLE table_name                  | Required. Identifies the table to be altered                                                                                |
| MODIFY column_name changeCharacteristic | Required. Identifies the column to be modified. changeCharacteristic is what you want to change such as length or NOT NULL. |
| ;                                       | Required. Indicates the end of the SQL statement.                                                                           |

### **Dropping an existing table:**
Deletes a table from a database.
| SQL Statement  | Description                                               |
| -------------- | --------------------------------------------------------- |
| DROP TableName | Required. Identifies the name of the table to be dropped. |
| ;              | Required. Indicates the end of the SQL statement.         |

### **COMMIT and ROLLBACK**
Ordinarily in MySQL, changes are automatically committed after each transaction. You can set a variable in MySQL so that changes that you make in MySQL are not saved until you exit the work session or tell it to save the changes. To turn off the automatic commit, enter:  
 `SET AUTOCOMMIT=0;`  
 at the beginning of your session. Then, to save any changes, enter `COMMIT;`. If you find that you made an error and want to undo the changes you made, you can enter `ROLLBACK;` which will reverse all changes made since the last `COMMIT;` or since the beginning of the works session if no `COMMIT;` command has been entered.  

 A transaction is a logical unit of work or a sequence of steps that accomplishes a single task. Such as adding multiple lines to an order or adding a student and then adding all their classes.  

 Use `COMMIT` and `ROLLBACK` to support transactions by:  

 Before beginning the updates for a transaction, enter the `COMMIT;`command.  

 Complete the updates for the transaction. If any update cannot be completed, execute the `ROLLBACK;` command.  

 If all updates complete successfully, enter the `COMMIT;` command.

 ### **ADDITIONAL NOTES**
Unless you tell it otherwise, commit happens automatically. This means that records are altered as soon as inserts, updates, or deletes are issued.  

You can turn this off automatically in the installation of MySQL, but if your queries are embedded in an application this probably isn’t practical.  

This is one way, but probably not the best way to back up data:
1. The copy of the table would exist on the same physical media.
2. Key designations and indexes are not created in the table that was created.
- `CREATE table invoices_copy AS SELECT * FROM invoices;`
- Create a table with only certain rows from an existing table.
- CREATE table west_coast_customer FROM customers  

WHERE state = “CA”
- CREATE table line_item_tots as SELECT invoice_id, SUM(line_item_amount) FROM invoice_line_items GROUP BY invoice_id.
- DROP table line_item_tots;  

    Insert command – used to add rows to a table. Enclose strings and dates in quotes.  
    Two methods:
  1. Use a list of values without a column list. Has to have the same number of values as exists in the table.
  2. Code the column list. This can be used when a “partial” row is created. If the column has a default value it will be inserted. If a column name is omitted in the list, the column in the table must be able to accept nulls or have a default value defined.  

### **Altering an existing row in a table.**
Syntax:  
`UPDATE invoice_line_items SET line_item_description = “Kinkos” where line_item_description = kinko’s;`  

More than one column may be updated at a time.  

WARNING - if you do not qualify the `UPDATE` command with a `WHERE` condition all rows of the table will be updated.  

`DELETE`: if you issue a `DELETE` command without a `WHERE` condition all rows are deleted. Subqueries may be used for any update, delete, or insert statement.  

To update from one table to another, usually when you are migrating doing a mass, non-application type update.  

`INSERT into invoice_archive SELECT * from invoices;`