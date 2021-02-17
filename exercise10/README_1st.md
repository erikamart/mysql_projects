
# How to Use These Files
Steps:  
1. Read the file 'chapter11notes.md'. It will instruct you to read Chapter 11 in the book and provide notes to follow along. At the end of the file are the instructions for Exercise 10.
2. View my files to see how I met the requirements of the exercise:  
   - `college_football_script.sql`: Creates a new MySQL database called 'college_football' and creates the table structures for each table. It also includes all primary and foreign key constraints. No database data is added yet.
   - `Database_Data`: folder that has the raw data files in .csv file format. 
   - `exercise10.sql`: holds the sql statements used to import the .csv file data from the Database_Data folder into the new college_football database to populate data in the tables.
   - `college_footballDB.sql`: Is the DUMP file created after college_football_script.sql and exercise10.sql were run respectively. Can be used to recreate the complete database with all data.