# Create Databases, Tables and Indexes  

### **Objectives:**  
- Create and drop a database
- Create, alter and drop tables
- Code primary and foreign key constraints Create and drop indexes
- View and specify character sets and collations View and specify storage engines.

### **Read Chapter 11 in the book and Do Exercise 10** 
<br>
<br>

# Chapter 11 Notes  

### **Add a Database:**  
    CREATE DATABASE [if not exists] db_name;  

### **Delete a Database:**
    DROP DATABASE db_name;  

### **Point to or select or otherwise use a database**
    USE DATABASE db_name;  
<br>

### **Creating a Table Within a Database**  
- When creating a table you specify the table name, the column names for the table, the data_types for each column, and any attributes you might assign to a specific column. 
- Common column attributes:
  - `NOT NULL` – when inserting rows in the table the column must contain data.
  - `UNIQUE` – the value stored in the column must be different from any other rows’ corresponding value
  - `DEFAULT` – if no value is passed to the column, assign a value to it.
  -` AUTO_INCREMENT` – generate a unique number automatically. Only one column in a table may possess this attribute. Often used when a primary key is not readily apparent from the data.  
<br>

### **Table/Column Constraints**
A primary key may be assigned as a column constraint if only one column comprises the primary key.  

For example:  
```
CREATE TABLE students  
(student_id INT PRIMARY_KEY AUTO_INCREMENT = 1111111,  
student_name VARCHAR(75) NOT_NULL UNIQUE);  
```
In the above example, the table would not allow a duplicate of `student_id`, but it would also not allow for two students named “Maria Sanchez”. Additionally when a student entity is added to the table, it would not allow a manual assignment of a student_id number and the student_ids will start with a value of 1111111.  

### **Foreign Key Constraints**
- **Foreign Keys** – used to define the relationship between tables and to enforce referential integrity
- **Referential integrity:** 
  - a record may not be added to a table that contains a foreign key unless there is a corresponding record in the linked table.
  - a record cannot be deleted if any related entries exist with that foreign key.  

- In MySQL, is only enforced if using InnoDB storage engines for your tables. 
- An example of a foreign key, column level constraint:
    ```
    CREATE TABLE orders  
    (order_num INT PRIMARY KEY,  
    customer_id INT REFERENCES customers(customer_id)  
    amount DOUBLE NOT_NULL);  
    ```
  - This constraint would prevent deletion of a row in the customers table if there is an order ***related*** to that customer.
  - In most cases you want to enforce referential integrity in this type of situation, otherwise you encounter a situation involving orphaned records. In the example above, a row in the orders table would not contain information about the customer that placed the order.
- `ON DELETE/CASCADE` clauses in a foreign key constraint.
- In the rare instance when you would want the related rows in the foreign key table(s) to automatically delete when the row in the primary key table is deleted, use this syntax:  
    ```
    CREATE TABLE orders  
    (order_num INT PRIMARY KEY,  
    customer_id INT amount DOUBLE NOT_NULL  
    CONSTRAINT orders_fk_customers  
    FOREIGN KEY(customer_id ) REFERENCES customers(customer_id)  
    ON DELETE CASCADE);  
    ```
- This statement enforces referential integrity, which means that an order cannot be created for a non­existent customer BUT the above statement would delete any orders for a customer if the row in the customers table is deleted.

<br>  

### **ALTER The Structure Of A Table**  

- `ALTER` keyword can be used to add a column, remove a column, or change a column’s structure.
- Syntax:  
  - **To add**  
    ```
    ALTER TABLE orders
    ADD transaction_date DATE;
    ```
  - **To delete**  
    ```
    ALTER TABLE orders
    DROP COLUMN transaction_date;  
    ```
  - To modify  
    ```
    ALTER TABLE orders
    MODIFY transaction_date VARCHAR (10) NOT NULL UNIQUE;  
    ```
  - **To add a primary key** or in other ways change the table constraints.  
    ```
    ALTER TABLE orders
    ADD PRIMARY KEY(order_num);  
    ```
- `RENAME`  
    ```
    RENAME TABLE students TO student;  
    ```
- `TRUNCATE`: removes all rows but keeps the table structure.  
    ```
    TRUNCATE TABLE student;  
    ```
- `DROP`: removes all rows and the table itself.  
    ```
    DROP TABLE student;  
    ```
<br>

### **Indexes**
- Speeds up searches and joins.
- By default primary keys, foreign keys, and unique keys, create indexes.
- Additional indexes may be created for other columns that are used frequently in search conditions and joins.

<br>

### **Character Sets and Collations**
- **Character sets** determines which characters can be stored and how many bytes are used to store the characters.
  - Latin1 – default character set in a MySQL installation. One byte stores each character. This incorporates almost all characters used in Western European languages. Limitation is that other characters are not stored.  
  - UTF8 – incorporates all characters in the UNICODE character set. Most language’s characters are mapped to a numeric representation of that character. Downside is that it stores character data up to 3 bytes.
- **Collation** – refers to the way a character set is sorted. Default in MySQL is latin1_swedish_ci. '_ci' indicates that the character sorts are not case sensitive.
- `SHOW CHARSET;` – displays all available character sets on a server.
- `SHOW COLLATION;` – all available collations for a server.
- `SHOW VARIABLES LIKE ‘character_set_database’;` – default character set for a server.
- `SHOW VARIABLES LIKE ‘collation_database’;` – default collation for a server.
- ```
    SHOW table_name, table_collation  
    FROM information_schema.tables  
    WHERE table_schema = dbname;
    ```
    Shows the character set and collation for all the tables in a database.  

<br>

### **Storage Engines**
- **InnoDB** – the default storage engine for MySQL 5.5 and later.
- **MyISAM** – default storage engine for previous versions of MySQL.
- Primary difference is that **InnoDB** supports foreign key constraints and transactions. 
- To display or view all storage engines for a server:
    `SHOW ENGINES;`
- To view the storage engine for the tables within a specific database:
    ```
    SELECT table_name, engine
    FROM information_schema.tables
    WHERE table_schema = dbname;
    ```

<br>
<br>
<hr>  

# Exercise 10: Create MySQL database
### **Objective:**
- Create a new MySQL database using the normalized table structure from Exercise 9 EER diagram.
- Add data to the tables in the database

### **Requirements:**  
- Create a new MySQL database for your data
- Identify the data types and lengths for each field in your normalized table structure from Exercise 10 or you may forward engineer the *EER diagram* into a table structure.
- Create the table structures for each of your tables and save the commands in a .sql script or a text file.
- Be sure to include all primary and foreign key constraints.
- Identify at least one additional column to be indexed and add it to your database.
- Add data to each of your tables. You should have 10 rows in each table. You may load the data directly or import it from a file, review *pages 546­-547* of your book for how to import data from a standalone .csv or .txt file. If you use `INSERT` statements in the query editor to build your rows, save the script file.
- Create a query for each of your tables to select all columns and rows of the tables in your database. Save your results as a .sql script.
- You should have two text or script files (one with the structure ­and one with the data) in the end. Alternatively, if you choose to create a full backup of your database you may export this to a standalone file in place of the two script files.