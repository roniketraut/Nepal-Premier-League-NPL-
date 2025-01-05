-- listing all the teams
SELECT *
FROM teams;

-- finding all the players from Pokhara Avengers
SELECT *
FROM players
WHERE team_id = 127228;

-- getting the total runs scored by Jimmy Neesham in all matches
SELECT b.player_id, p.player_name, SUM(runs) AS total_runs
FROM batting AS b
JOIN players AS p
USING (player_id)
GROUP BY b.player_id, p.player_name
HAVING p.player_name = 'Jimmy Neesham';

-- left handed batsman vs right handed batsman in the league
SELECT batting_style, COUNT(*) AS count
FROM players
GROUP BY batting_style;

-- total wickets picked by Sompal Kami in all the matches
SELECT b.player_id, p.player_name, SUM(wickets) AS total_wickets
FROM bowling AS b
INNER JOIN players AS p
ON b.player_id = p.player_id
GROUP BY b.player_id, p.player_name
HAVING p.player_name = 'Sompal Kami';

-- bowlers with an economy rate below 5.00 through out the tournament
SELECT p.player_id AS player_id, p.player_name AS player_name,
ROUND(SUM(runs:: NUMERIC)/SUM(overs :: NUMERIC), 2) as economy_rate,
SUM(overs) AS total_overs_bowled, p.bowling_style
FROM bowling AS b
INNER JOIN players AS p
USING (player_id)
GROUP BY p.player_id, p.player_name, p.bowling_style
HAVING ROUND(SUM(runs:: NUMERIC)/SUM(overs :: NUMERIC), 2)<5.00;

-- finding the number of matches where toss winner won the match
SELECT COUNT(*) AS num_of_matches_won, 
ROUND(COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM match_sum) * 100, 2) AS win_percentage
FROM match_sum
WHERE toss_winner = winner_team_id;

-- finding the highest individual score in a single match
SELECT p.player_id, p.player_name, b.runs, b.balls, b.fours, b.sixes, b.strike_rate, b.match_id
FROM batting AS b
INNER JOIN players AS p
USING (player_id)
ORDER BY runs DESC
LIMIT 1;

-- finding the top 5 batsman by runs scored
SELECT p.player_id, p.player_name, SUM(runs) AS total_runs_scored, COUNT(*) AS number_of_innings
FROM batting AS b
INNER JOIN players AS p
USING (player_id)
GROUP BY p.player_name, p.player_id
ORDER BY SUM(runs) DESC
LIMIT 5;

-- listing all the players who scored 50 runs in atleast one inning
SELECT p.player_name, p.player_id, runs
FROM batting AS 
WHERE runs>50;

-- building our very own points table in a view
CREATE OR REPLACE VIEW points_table AS
SELECT m.winner_team_id, t.team_name, COUNT(*)*2 AS total_points
FROM match_sum AS m
INNER JOIN teams AS t
ON m.winner_team_id  = t.team_id
WHERE match_number NOT IN 
(SELECT match_number
FROM match_sum
ORDER BY match_number DESC
LIMIT 4)
GROUP BY m.winner_team_id, t.team_name
ORDER BY COUNT(*)*2 DESC;

SELECT *
FROM points_table;

-- creating a view for top_performing bowlers, including total wickets and economy rate
CREATE OR REPLACE VIEW top_bowler AS 
SELECT b.player_id, p.player_name, SUM(wickets) AS total_wickets, 
ROUND(SUM(runs::NUMERIC)/SUM(overs:: NUMERIC), 2) AS economy_rate 
FROM bowling AS b
INNER JOIN players AS p
USING (player_id)
GROUP BY b.player_id, p.player_name
ORDER BY total_wickets DESC, economy_rate ASC
LIMIT 5;

SELECT *
FROM top_bowler;

-- calculating the rank of batsmen on total runs scored using a ranking window function 
SELECT p.player_id, p.player_name, SUM(runs), DENSE_RANK() OVER(ORDER BY SUM(runs) DESC) AS rank_as_per_runs 
FROM batting AS b
INNER JOIN players AS p
USING (player_id)
GROUP BY p.player_id, p.player_name
LIMIT 10;

-- find the top 2 scorers of each match
WITH CTE AS(
SELECT p.player_id, p.player_name, SUM (runs) AS total_runs, b.match_id,
DENSE_RANK() OVER(PARTITION BY b.match_id ORDER BY SUM(runs) DESC) AS player_rank
FROM batting AS b
INNER JOIN players AS p
USING (player_id)
GROUP BY p.player_id, p.player_name, b.match_id
ORDER BY b.match_id)

SELECT *
FROM CTE 
WHERE player_rank<=2;