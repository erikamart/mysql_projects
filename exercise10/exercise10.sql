USE college_football;

LOAD DATA INFILE '~/mysql_projects/exercise10/Database_Data/FootballDB_coaches.csv'
INTO TABLE coaches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\';

LOAD DATA INFILE '~/mysql_projects/exercise10/Database_Data/FootballDB_teams.csv'
INTO TABLE teams
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\';

LOAD DATA INFILE '~/mysql_projects/exercise10/Database_Data/FootballDB_players.csv'
INTO TABLE players
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\';