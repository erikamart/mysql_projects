
# How to Use These Files
Steps:  
1. Exercise 10: Create MySQL database
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
2. View my files to see how I met the requirements of the exercise:  
   - `college_football_script.sql`: Creates a new MySQL database called 'college_football' and creates the table structures for each table. It also includes all primary and foreign key constraints. No database data is added yet.
   - `Database_Data`: folder that has the raw data files in .csv file format. 
   - `exercise10.sql`: holds the sql statements used to import the .csv file data from the Database_Data folder into the new college_football database to populate data in the tables.
   - `college_footballDB.sql`: Is the DUMP file created after college_football_script.sql and exercise10.sql were run respectively. Can be used to recreate the complete database with all data.