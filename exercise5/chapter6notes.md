# Summary Queries.
### **Objectives:**
- Use aggregate functions to summarize data
- Use group by clauses to group data
- Use having clauses to limit rows with group by clauses
- Use compound conditions 
- Use the rollup operator  

### **Read Chapter 6: How to code summary queries**  

### **Aggregate Functions:** 
Returns a single row containing the result of mathematical computation.
| SQL Statement      | Description                           |
| ------------------ | ------------------------------------- |
| AVG(column-name)   | Averages the values in a column.      |
| COUNT(column-name) | Counts the values in a column.        |
| MAX(column-name)   | Finds the largest value in a column.  |
| MIN(column-name)   | Finds the smallest value in a column. |
| SUM(column-name)   | Totals the values in a column.        |


Examples:  

`SELECT AVG(GPA) FROM Students;`  
Returns the average of the GPA column from all students.  

`SELECT COUNT(*) FROM Students WHERE Major = 'CIT';`  
Counts the number of rows in the Students table with a Major of 'CIT'.  

`SELECT COUNT(DISTINCT) from Students where Major = ‘CIT’;`  
Counts the number of rows in the Students table with a Major of ‘CIT’ and excludes duplicates.

`SELECT MAX(age) as Oldest FROM Students;`  
Finds the largest value in age and stores it in the results table in a field called Oldest.  

`SELECT MIN(age), MAX(age), AVG(age) FROM Students;`  
Returns the minimum, maximum and average age of all students.  

### **Grouping:** 
Allows you to group rows with the same value in a specific field.  

`SELECT AVG(GPA) FROM Students GROUP BY Major ORDER BY Major;`  
Displays the average GPA of students within each Major.  

### **GROUP BY and HAVING clauses.**
Adds a conditions test to an aggregate function.  

`SELECT AVG(GPA) FROM Students GROUP BY Major HAVING COUNT(*) >= 20 ORDER BY Major;`  
Displays the average GPA of students within each Major for Majors with at least 20 students. Majors with fewer than 20 students are eliminated from the results.  

Can be used with a `WHERE` clause to limit the groups of rows analyzed:  
`SELECT AVG(GPA) FROM students WHERE Major IN (‘CIT’, ‘ MIS’, ‘CSI’) GROUP BY major HAVING COUNT(*)>=20 ORDER by major;`  

### **Differences between WHERE and HAVING clauses.**
`WHERE` clauses limit the rows analyzed in the aggregate or `GROUPING`function.  

For example, if you only want orders placed in 2012 that have not been shipped, and then group the orders by type (internet, walk in, telephone, catalog etc) you must first limit the rows selected to the proper date range and shipping information using a `WHERE` clause.  

A `WHERE` clause cannot contain an aggregate function. A `HAVING` clause can.  

A `WHERE` clause can refer to any column in the table. A `HAVING` clause can only refer to columns included in the select statement.
