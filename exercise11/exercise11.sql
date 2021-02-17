/* Before running this script, run the provided updated database file 'college_footballDB_update.sql' so that this file will work correctly.  I made too many changes to the original database (from exercise 10) while debugging errors and I couldn't keep track of them all, so the best solution to ensure functionality is to replace the database with that file. */

/* Exercise 11 is as follows */

/* Administrator has full access to select, update, insert, delete, grant for the database and work with all data.  They should be able to drop or create the views for the managers or analysts. */
DROP TABLE IF EXISTS `college_football`.`administrator`;
USE `college_football`;
CREATE VIEW `administrator` AS
SELECT Coach_ID, c.Team_ID AS coach_TeamID, c.First_Name AS coach_First_Name, c.Last_Name AS coach_Last_Name, Yrs_on_Team, Winning_Pct, Salary, Bowl_Wins, Coach, Team_Name, Stadium, Stadium_Size, Conference, Budget, Record_of_128, p.Team AS player_Team, p.First_Name AS player_First_Name, p.Last_Name AS player_Last_Name, Rush_Receive_Rk, Rushing_Avg, Rushing_TD, Receiving_Avg, Receiving_TD
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team; 

/* Manager has mid level privilege and should select, update, insert, and delete rows for the coaches and players tables on those columns that need to be updated when a coach or player has been replaced with someone else on a team.  Managers are responsible for ensuring coaches and player names are current (if a new row has been inserted while another one deleted to do an update, then all statistical data columns will default to 0 or NULL in other undisplayed columns for each table). */
DROP TABLE IF EXISTS `college_football`.`manager`;
USE `college_football`;
CREATE VIEW `manager` AS
SELECT c.First_Name AS coach_First_Name, c.Last_Name AS coach_Last_Name, c.Team_ID AS coach_Team, p.Team AS player_Team, p.First_Name AS player_First_Name, p.Last_Name AS player_Last_Name
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team; 


/* Analyst has the lowest level of privilege and should only select and update those columns in all 3 tables used to update the statistics for a coach, team, or player as they change yearly.  The Manager user is responsible for name changes related to statistical data.*/
DROP TABLE IF EXISTS `college_football`.`analyst`;
USE `college_football`;
CREATE VIEW `analyst` AS
SELECT c.First_Name AS coach_First_Name, c.Last_Name AS coach_Last_Name, c.Yrs_on_Team, c.Winning_Pct, c.Salary, c.Bowl_Wins, c.Bowl_Losses, t.Team_Name, t.Stadium, t.Stadium_Size, t.Budget, t.Record_of_128, p.Team AS player_Team, p.First_Name AS player_First_Name, p.Last_Name AS player_Last_Name, p.Rush_Receive_Rk, p.Rushing_Avg, p.Rushing_TD, p.Receiving_Avg, p.Receiving_TD 
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team;

CREATE USER 'administrator' IDENTIFIED BY 'admin123';
GRANT ALL ON `college_football`.* TO 'administrator';
GRANT ALL ON TABLE `college_football`.`administrator` TO 'administrator' WITH GRANT OPTION;

CREATE USER 'manager' IDENTIFIED BY 'manage1';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `college_football`.* TO 'manager';
GRANT UPDATE, SELECT, SHOW VIEW ON TABLE `college_football`.`analyst` TO 'manager';
GRANT DELETE, SELECT, INSERT, UPDATE, SHOW VIEW ON TABLE `college_football`.`manager` TO 'manager';

CREATE USER 'analyst' IDENTIFIED BY 'analyser1';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `college_football`.* TO 'analyst';
GRANT UPDATE, SELECT, SHOW VIEW ON TABLE `college_football`.`analyst` TO 'analyst';
GRANT DELETE, SELECT, INSERT, UPDATE, SHOW VIEW ON TABLE `college_football`.`manager` TO 'analyst';