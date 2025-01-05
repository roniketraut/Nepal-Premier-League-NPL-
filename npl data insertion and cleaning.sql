COPY teams FROM 'C:/Program Files/PostgreSQL/17/data/teams_final.csv'
DELIMITER ',' 
CSV HEADER;

ALTER TABLE match_sum
ADD COLUMN winner_team TEXT;

COPY match_sum FROM 'C:/Program Files/PostgreSQL/17/data/match_sum_final.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE players
ADD COLUMN age INT;

SELECT *
FROM players;

COPY players FROM 'C:/Program Files/PostgreSQL/17/data/players_final.csv'
DELIMITER ','
CSV HEADER;

COPY batting FROM 'C:/Program Files/PostgreSQL/17/data/batting_final.csv'
DELIMITER ','
CSV HEADER;

COPY bowling FROM 'C:/Program Files/PostgreSQL/17/data/bowling_final.csv'
DELIMITER ','
CSV HEADER;

-- adding the column winner_team_id to match_sum 
ALTER TABLE match_sum
ADD COLUMN winner_team_id INT;

-- updating the winner_team_id based on winner_team and team_id from teams table
UPDATE match_sum
SET winner_team_id = teams.team_id
FROM teams
WHERE match_sum.winner_team = teams.team_name;

-- creating a foregin key constraint between winner_team_id and team_id
ALTER TABLE match_sum
ADD CONSTRAINT fk_winner_team
FOREIGN KEY (winner_team_id) REFERENCES teams(team_id);

-- adding the column batting_team_id in batsman table
ALTER TABLE batting
ADD COLUMN batting_team_id INT;

-- trimming the ' inning' from team_innings
UPDATE batting
SET team_innings = REPLACE(team_innings, ' Inning', '')
WHERE team_innings LIKE '% Inning';

-- updating the batting_team_id based on team_innings and team_id from teams table
UPDATE batting
SET batting_team_id = teams.team_id
FROM teams
WHERE batting.team_innings = teams.team_name; 

-- creating a foreign key constraint batting_team_id and team_id
ALTER TABLE batting
ADD CONSTRAINT batting_batting_team_id 
FOREIGN KEY (batting_team_id) REFERENCES teams(team_id) ON DELETE CASCADE;

-- adding the column team in players table
ALTER TABLE players
ADD COLUMN team_id INT

-- updating the team_id in players table through team in players table
UPDATE players
SET team_id = teams.team_id
FROM teams
WHERE players.team = teams.team_name;

-- adding the foreign key to the team_id in players table
ALTER TABLE players
ADD CONSTRAINT players_team_id_fkey
FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE;

ALTER TABLE match_sum
DROP COLUMN team1_name, 
DROP COLUMN team2_name,
DROP COLUMN winner_team;

ALTER TABLE match_sum
ADD COLUMN motm_id INT;

UPDATE match_sum
SET motm_id = player_id
FROM players AS p
WHERE man_of_the_match = p.player_name;

ALTER TABLE match_sum
DROP COLUMN man_of_the_match;

ALTER TABLE match_sum
ADD CONSTRAINT match_sum_motm_id_fkey
FOREIGN KEY (motm_id) REFERENCES players(player_id);

ALTER TABLE batting
DROP team_innings,
DROP batsman_name;

ALTER TABLE bowling
DROP bowlername;

ALTER TABLE batting
DROP COLUMN match;

ALTER TABLE bowling
DROP COLUMN match,
DROP match_number;

ALTER TABLE batting
DROP COLUMN match_number;

