# How to Use These Files
Steps:  
1. Exercise 11: Users and Views
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
2. View my files to see how I met the requirements of the exercise:  
   - `college_football.mwb`: is simply for informational purpose and is an updated MySQL Workbench graphical interface file. It has changes and is different than the file created during Exercise 9. 
   - `college_footballDB_update.sql`: should be used to update the existing database created in previous exercises. This will ensure the exercise 11 .sql file will work.
   - `exercise11.sql`: holds the sql statements used to complete the requirements of exercise 11. It will create 3 views in the database when executed.