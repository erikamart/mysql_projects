/* Exercise 12 */

-- ADMINISTRATOR JOB
-- ------------------------------------------------------
-- (Query 1) Add the Conference Column in the analyst view so analyst can verify Conference changes.
CREATE OR REPLACE VIEW analyst AS 
SELECT c.First_Name AS coach_First_Name, c.Last_Name AS coach_Last_Name, c.Yrs_on_Team, c.Winning_Pct, c.Salary, c.Bowl_Wins, c.Bowl_Losses, t.Team_Name, t.Stadium, t.Stadium_Size, t.Conference, t.Budget, t.Record_of_128, p.Team AS player_Team, p.First_Name AS player_First_Name, p.Last_Name AS player_Last_Name, p.Rush_Receive_Rk, p.Rushing_Avg, p.Rushing_TD, p.Receiving_Avg, p.Receiving_TD 
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team;

-- (Query 2) Add the coach and player ID's to the manager view so they can update names as needed.
CREATE OR REPLACE VIEW `manager` AS
SELECT Coach_ID, c.First_Name AS coach_First_Name, c.Last_Name AS coach_Last_Name, c.Team_ID AS coach_Team, Player_ID, p.Team AS player_Team, p.First_Name AS player_First_Name, p.Last_Name AS player_Last_Name
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team; 

-- (Query 3) Use view to see all data related to the Nebraska Team
SELECT * FROM administrator
WHERE Team_Name = 'Nebraska';

-- (Query 4) Administrator to Update Conference change for the Nebraska team from Big Ten to Big 12 using View
UPDATE administrator
SET Conference = 'Big 12'
WHERE Team_Name = 'Nebraska';

-- (Query 5) aggregate function for Administrator to ensure only 10 teams are analyzed at one time
SELECT COUNT(*) AS number_of_teams
FROM teams;


-- MANAGER JOB
-- ------------------------------------------------------
-- (Query 6) View database information
SELECT *
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team;

-- (Query 7) Ensure 20 players total and 10 coaches total
SELECT COUNT(DISTINCT Coach_ID) AS coach_count, COUNT(Player_ID) AS player_count
FROM manager;

-- (Query 8) LSU player named Leonard Fournette has been suspended and needs to be removed.  Determine the Player_ID
SELECT * FROM players
WHERE Last_Name = 'Fournette';

-- (Query 9) Delete player Leonard Fournette with ID #11 from LSU who has been suspended
DELETE FROM players
WHERE player_ID = 11;

-- (Query 10) Insert player Darrel Williams from LSU to replace previously suspended player
INSERT INTO players
VALUES (DEFAULT, LSU, Darrel, Williams, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);


-- ANALYST JOB
-- ------------------------------------------------------
-- (Query 11) View overall information ordered alphabetically by team name
SELECT *
FROM coaches AS c
LEFT JOIN teams AS t ON c.Coach_ID = t.Coach
LEFT JOIN players AS p ON t.Team_ID = p.Team
ORDER BY Team_Name;

-- (Query 12) Update statistics for a player (Darrel Williams)
UPDATE players 
SET Rush_Receive_Rk = 3,
	Rushing_Avg = 5, 
	Rushing_TD = 3, 
	Receiving_Avg = 7
WHERE Player_ID = 21;

-- (Query 13) Update statistics for the teams table (Kyle Field)
UPDATE teams 
SET Stadium_Size = 103000,
	Conference = 'Big Ten',
	Budget = 110000000,
	Record_of_128 = 32
WHERE Stadium = 'Kyle Field';

-- (Query 14) Update statistics for the coaches table (Clay Helton)
UPDATE coaches 
SET Yrs_on_Team = 3,
	Winning_Pct = 62,
	Salary = 2700000,
	Bowl_Wins = 1,
	Bowl_Losses = 1
WHERE Last_Name = 'Helton';

-- (Query 15) Get average of all coach salaries and round it to 2 decimal places
SELECT ROUND(AVG(Salary),2) AS avg_coach_salary
FROM coaches;