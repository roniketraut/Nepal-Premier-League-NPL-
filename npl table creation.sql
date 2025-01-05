CREATE TABLE teams (
	team_id INT PRIMARY KEY,
	team_name VARCHAR(100)
);

CREATE TABLE match_sum (
	match_number INT,
	match_id INT PRIMARY KEY,
	team1_name VARCHAR(100),
	team1_score TEXT,
	team1_id INT,
	FOREIGN KEY(team1_id) REFERENCES teams(team_id),
	team2_name TEXT,
	team2_score TEXT,
	team2_id INT,
	FOREIGN KEY(team2_id) REFERENCES teams(team_id),
	man_of_the_match TEXT,
	margin TEXT,
	ground TEXT,
	toss_winner INT,
	FOREIGN KEY(toss_winner) REFERENCES teams(team_id),
	toss_decision TEXT,
	datetime DATE,
	pitch_condition TEXT,
	match TEXT
);

CREATE TABLE players (
	player_id INT PRIMARY KEY,
	player_name TEXT,
	team TEXT,
	nationality TEXT,
	batting_style TEXT,
	bowling_style TEXT
);

CREATE TABLE batting (
	player_id INT, 
	FOREIGN KEY(player_id) REFERENCES players(player_id),
	batsman_name TEXT,
	runs INT,
	balls INT,
	fours INT,
	sixes INT,
	strike_rate FLOAT,
	batting_position INT,
	match_number INT,
	match_id INT,
	FOREIGN KEY (match_id) REFERENCES match_sum(match_id),
	team_innings TEXT,
	dismissal TEXT,
	match TEXT
	);

CREATE TABLE bowling (
	bowlerName TEXT,
	overs FLOAT,
	runs INT,
	wickets INT,
	economy FLOAT,
	maiden INT,
	match_id INT,
	FOREIGN KEY (match_id) REFERENCES match_sum(match_id),
	match_number INT,
	bowling_team_id INT,
	FOREIGN KEY (bowling_team_id) REFERENCES teams(team_id),
	match TEXT,
	player_id INT,
	FOREIGN KEY(player_id) REFERENCES players(player_id)
);
