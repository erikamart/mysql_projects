# Chapters 17 & 19: Database Administration
### **Objectives:**
- Identify the responsibilities of a database administrator.
- Monitor processes and system variables.
- Configure system variables.
- Manage server logs.
- Backup and restore a database.
- Import and export data from a database.
- Check and repair MySQL tables.

<br>

### **Read Chapters 17 and 19 in the book and do Exercise 12**

<br>
<br>
<hr>

# Chapter 17: An introduction to database administration
### **Objectives:**
- Learn the basic functions of a DBA (database administrator) 
- Distinguish the different types of database files.
- Locate and read log files.
- View and kill processes
- View status and system variables
- Set variables using the Workbench
- Set variables using the SET statement
- Enable, disable and configure logging
- View text based logs
- View binary logs
- Manage logs


A database administrator typically must monitor and configure the server installation.  

An administrator often is the primary person in an organization to maintain user accounts, secure the databases, devise the backup and replication strategies for a database, upgrade the server software, and maintain and migrate data to new hardware.  

Additionally a typical outcome of monitoring a DBMS is attempting to optimize performance for the users of a database.  

Three types of database files:  
- Configuration file. Stores configuration settings and is invoked when a MySQL server instance starts.
- Data file. Files that define the tables, indexes and other database objects.
- Log file. Files that contain information that's written by database server. Logging various server functions may be turned on or off as all logging will add to performance overhead. Types of log files:
  - General = text file that contains records of client (user) connections, statements executed, and
other information.
  - Error = text file that contains messages about startup and shutdown server procedures as well as
error messages.
  - Slow query = a text file contains SQL statements that take a long time to execute.
  - Binary = records changes made to databases. This type of logging may be used in an incremental
backup strategy.
  - Relay = only used in data replication, also referred to as data mirroring.

### **Monitoring a server.**
In mySQL workbench the process list will display the connections, the server usage the
mySQLserver instance and graphically display the resources being consumed by the processes.  

A process is a connection to the database.  
Root user typically displays at least two processes for the query editor, and two for the administrator connection.  

A process may be ended via this screen by selecting it and clicking the "Kill Connection" button. 

Viewing the status and system variables will display the current values of each of these settings.  

These options are searchable - meaning you may filter the list of variables to some you may searching for example you might search for "Insert" to determine the number of INSERT statements that have been executed during this server instance.  

Changing system variables. In the workbench the system variables may be changed using the options file settings in the **ADMIN** tab.

System variables may be altered by directly editing the my.ini (in a windows environment), or my.cnf (in a MAC OS X or Unix) environment using a text editor.  

Detailed descriptions of all system variables are documented in the MySQL Reference Manual.  

`USING SET` statements in a query allows the altering of system variables without starting and stopping the server. This allows for dynamically changing a server instance but does not permanently change the server settings.  

### **Logging.** 
Most logging settings are turned off when mySQL is installed. Logging increases security exposure and effects performance. There are times when it is necessary to increase the logging settings for an installation, but if there is no good reason to do so....don't.  

Logging may be configured (customized) for a MySQL installation. For example the definition of a "long query" for logging purposes may be set in the system variables.  

Text based logs may viewed in a text editor or within the workbench itself.  

A binary log is not readable if opened directly in a text editor. If binary logging is turned on in a server configuration, a binary log may be converted by running the mysqlbinlog program.  

Disable all logging if it is not needed. Error logging is typically enabled and for researching specific problems like slow performance at certain times of the day, other logging, may be turned on temporarily to assist in research.

<br>
<br>

# Chapter 19
### **Two types of backups** 
- A *full backup* includes the entire contents of the database as well as the structure and the data. 
  - This uses the `mysqldump` command and may be stored in one or more SQL script files.
- By enabling a binary log one may create *incremental backups*. Incremental backups contain changes made since the last full backup. 

Often a full backup is done weekly and an incremental backup is done nightly.  

<br>

### **Point–in-time-recovery** 
A concept that sets a relative time in a business cycle. Often batch or update processing is done at set intervals for an application. A full backup may be executed prior to mass updates, setting a point-in-time-recovery point immediately prior to this procedure.  

First run script file that contains the mysqldump results, then use the mysqlbinlog to execute each sql statement that has been run since the last full backup.  

For detailed instructions about backing up and restoring data from a command line refer to the first part of Chapter 19.
<br>
<br>

### **Steps to Backing Up And Restoring:**
<br>

**Backing Up:**
1. Use the server administration tab to backup data using the workbench.
2. Sign on as the root user.
3. Select the data export option.
4. Select the database(s) you wish to export. 
5. When the settings are adjusted to your linking. Click the Start Export button.
6. Upon completion, the content of the folder where the backup scripts were copied to is a series of script files, one for each table in the selected database.
<br>
<br>

**Restoring:**
1. To restore a specific table, simply execute the specific backup script. It will create the database unless it already exists, then it will delete the specific table and then recreate it, with all of the column attributes, and then insert the rows from the backup.
<br>
<br>

**Exporting:**  
To export a file in a format other than a .sql file, you may execute an export option using a result set. It defaults to a .csv (comma separated variable) file. On a windows pc this would open in MS-Excel.

The file will be delimited with column headings.  

This procedure may be used for any result set that any query generates.

While exporting data to a csv file is useful for delivering a result set in a more portable format, it cannot be used to restore the structure and data. In order to restore data, backup the objects in a sql script.
<br>
<br>
<hr>

# Additional Notes on Both Chapters  

### **Database Administrator Responsibilities**  
- Maintenance: configure and monitor the server, maintain log files
- Design: design, normalize and create database
- Security: Maintain user accounts, secure the server
- Backup: backup the server regularly, restore or migrate to another server as needed
- Miscellaneous: start, stop and optimize the server, update software, enable and manage replication.
  - Replication involves setting up 2 or more servers that are duplicates (master/slave) and synchronizing the data.Done to improve performance on large multi-user databases.

### **Database files**
- Configuration file: my.ini for Windows, my.cnf for Mac and Unix
- Data file: define tables, indexes and other database objects. Stores data for the database
  - InnoDB uses one file per table
  - MyISAM uses 3 files per table
- Log File: contain information logged by the server
  - General: client connections, SQL statement, etc.
  - Error: server startup and shutdown error messages
  - Slow query: SQL statements that take a long time to execute 
  - Binary: logs changes made to the database
  - Relay: relays messages from a slave to a master when replication is used.

### **Backup and restore a database**
- Backup strategy should include full backups made on a regular schedule using mysqldump and enabling the binary log for incremental backups between full backups.
- Restoration strategy reverses the process. Recreate the database from the last full backup and apply changes from the incremental backup log. Backup log may be manually updated to remove problematic updates.
- Backups should be stored on a different hard drive from the one where MySQL is running.

### **Importing and exporting data**  
Importing is the process of converting data to a MySQL database. Exporting is the process of converting the data in a MySQL database to a file format for use in another program.  

### **Importing Data into a Database**  
A DBMS should include some way to import data that originates from other sources. In MySQL you can import a text file. A text file contains unformatted data. A comma- delimited file uses a comma to separate data into fields; a tab-delimited file uses a tab character to separate data into fields. To import a text file into MySQL, the text file must be tab-delimited and the data should not be enclosed in quotation marks.  
|                                   |                                                                      |
| --------------------------------- | -------------------------------------------------------------------- |
| `LOAD DATA INFILE` 'filename.txt' | Required. Identifies the name of the file to be imported.            |
| `INTO` tableName                  | Required. Identifies the table that the data will be loaded into.    |
| `FIELDS TERMINATED BY` '\t'       | Required. Indicates that each field is separated by a tab.           |
| `LINES TERMINATED BY` '\r\n'      | Required. Indicates that each row ends with a hard return character. |
| `;`                               | Required. Indicates the end of the SQL statement.                    |

<br>

### **Exporting data from a table:**
A DBMS should provide some way to export data so it can be used by other programs. When you export data stored in a MySQL database, the rows in the table become rows in the text file and the columns are separated by tabs. To export a table, use the SELECT INTO OUTFILE command. The command includes the word SELECT followed by the name of the column to export, the words INTO OUTFILE, the name of the text file in single quotes, the word FROM and the table name. You can use an asterisk (*) to select all columns in a table.

|                                         |                                                                             |
| --------------------------------------- | --------------------------------------------------------------------------- |
| `SELECT` colname1, colname2 ...  or `*` | Required. Identifies the columns to be exported.                            |
| `INTO OUTFILE` 'filename.txt'           | Required. Identifies the name of the text file to be created with the data. |
| `FROM` tablename                        | Required. Identifies the name of the table to export from.                  |
| `;`                                     | Required. Indicates the end of the SQL statement.                           |


<br>
<br>
<hr>

# Exercise 12
### **Objective:**
- Identify queries that will be needed by your users.
- Create select, insert, update and delete queries for your tables.
- Backup your database.

### **Requirements:**
- For each category of users that you identified in Exercise 11, identify and write 5 queries that they would need to use on a regular basis. You should have 15 queries, including the following:  
  - At least 2 queries that join tables.
  - At least 1 insert query, 1 update query and 1 delete query.  
  - At least 1 query that uses a view.
  - At least 1 query that includes a calculation or an aggregate function.
- Save your queries in a .sql file.
- Perform a full backup of your database using the Export function in the workbench.
- The end result should be the .sql query file and the backup file.