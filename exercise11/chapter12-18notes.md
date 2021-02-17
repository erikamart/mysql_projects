# Chapters 12 & 18: Views and Security 

### **Objectives:**
- List the benefits of using views
- Create a view
- Alter or drop a view
- Select and update database information using a view 
- Understand user privileges in SQL
- Create, rename and drop users
- Grant view and revoke user privileges
- Change passwords
- Use the MySQL Workbench to administer users

<br>

### **Read Chapters 12 and 18 in the book and do Exercise 11**
<br>
<br>

# Chapter 11 Notes 
### **View**  
- a picture of a database for a specific application or user 
- derived from one or more base tables in a database 
- created using a defining query
- once created, can be used just like a table
- Benefits of using a view: 
  - simplifies query creation
  - can increase security by hiding sensitive information
  - provides customized information
  - provides data independence. If a base table is changed, the view can still be used ­possibly without changes.
  - Updateability ­ with certain restrictions views can be used to update data from a base table (see below)

<br>

|                           |                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------ |
| `CREATE VIEW viewName AS` | Required. Identifies the name of the view to be created.                                               |
| `SELECT ...`              | Required. Identifies the query that defines the view. Any valid SELECT statement can be used here.     |
| `WITH CHECK OPTION`       | Optional. For updatable views, will not allow the update if it will remove the data row from the view. |
| `;`                       | Required. Indicates the end of the SQL statement.                                                      |

<br>

### **Using a view to update data:**  
- Updating a database may or may not be possible through a view 
- Updatable views cannot include any of the following:
  - `DISTINCT` clause 
  - aggregate functions 
  - `GROUP BY` or `HAVING` 
  - `UNION`  

- To Insert data using a view, any columns not in the view must accept nulls.
- Updates and deletions can be made through a view if only one table is included in the view. 
- Updates to joined tables in a view can be made if both tables have the same primary key and are joined on that primary key.

<br>

### **Dropping a view when no longer needed:**

|                    |                                                   |
| ------------------ | ------------------------------------------------- |
| DROP VIEW viewName | Required. Identifies the view to be dropped.      |
| ;                  | Required. Indicates the end of the SQL statement. |

<br>
<br>

### **Database Security:**  
- Prevention of unauthorized access to a database.
- Database administrator determines types of access various users have to a database.
- Views provide some security by hiding sensitive information.
- Main mechanism for providing access to a database is the GRANT command.

<br>

### **Create, Rename, or Drop a User**
|                                                         |                                   |
| ------------------------------------------------------- | --------------------------------- |
| `CREATE USER` userName[@host] `IDENTIFIED BY` password; | Creates a user. If @host is used. |
| `RENAME USER` userName[@host] `TO` userName[@host] ;    | Renames the user to the new user. |
| `DROP USER` userName[@host];                            | Drops the specified user.         |

<br>
<br>

### **Grant Privileges**  
|                                 |                                                                                                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `GRANT` accessType              | Required. Identifies the type of access the users are given. accessType may be:  `SELECT`, `UPDATE`, `INSERT`, `DELETE`, `INDEX`, `ALTER`, and `ALL`. |
| (columnlist)                    | Optional. ­States the columns that the user may access. If omitted, user will have access to all columns in the table or view.                        |
| `ON` table_viewName             | Required. Indicates the table or view that the user will have access to.                                                                              |
| `TO` username1, username2 . . . | Required. Specifies the users who are granted access                                                                                                  |
| `WITH GRANT OPTION`             | Optional. Specifies that the user can grant access to other users.                                                                                    |
| `;`                             | Required. Indicates the end of the SQL statement.                                                                                                     |

<br>
<br>

### **Revoking Access to a Database:**
|                                 |                                                                                                                                                |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `REVOKE` accessType             | Required. Identifies the type of access being revoked. accessType may be: `SELECT`, `UPDATE`, `INSERT`, `DELETE`, `INDEX`, `ALTER`, and `ALL`. |
| (columnlist)                    | Optional. States the columns that the user may not access. If omitted, user will not have access to any columns in the table or view.          |
| `FROM` table_viewName           | Required. Indicates the table or view that the user will not have access to.                                                                   |
| `TO` username1, username2 . . . | Required. Specifies the users who are granted access                                                                                           |
| `;`                             | Required. Indicates the end of the SQL statement.                                                                                              |

<br>
<br>

### **View privileges:**  
- `SHOW GRANTS [FOR userName[@host] ];`  
- if `FOR` clause is omitted ­- shows for the current user.  

### **Change password:**
- `SET PASSWORD [FOR userName[@host] ]] = PASSWORD ('password');`  
- If `FOR` clause is omitted ­- changes the password for the current user.
- Password can also be changed with the grant statement:  
`GRANT USAGE ON *.* to username IDENTIFIED BY 'password';`

<br>

### **Open the file 'chapter12-sql-demo.sql' to see an example of working with views.**

<br>
<br>
<hr>

# Exercise 11: Users and Views
### **Objective:**
- Identify the primary users of your database
- Determine what access each user would need
- Create views to help your users access the information
- Create users and grant them access to the appropriate tables and views

### **Requirements:**
- Identify the types of users that would be using your database by job type. For example, you might have a sales clerk entering sales information and an hr rep entering personnel information. You should have at least 3 different categories of users for your system.
- For each user category determine which tables they would need access to and the type of access they would need (select, update, insert, delete, grant)
- Identify at least one view for each user category that would help them easily retrieve the data that they need access to. One of the views should be an updatable view.
- Create the views and save the commands in a script file.
- Create one user for each role and grant them the privileges they need to do their job.
- Describe to me the role of each user, the access needed, the views created and why. This may be in a text file or typed into the comments for the exercise.