-- We deleted the attribue rating in table Opening, since we changed the
-- investigative question about it and it is not necessary now.
-- We also deleted the attribute turns in table Game, since we noticed that
-- it is not necessary for answering to our investigative questions either.
-- Project phase 3 schema
DROP SCHEMA IF EXISTS projectschema CASCADE;
CREATE SCHEMA projectschema;
SET SEARCH_PATH TO projectschema;


-- A tuple in this relation represents a standardised code's corresponding
-- name.
-- eco is the standardised code for any given opening, and name is the name
-- of the opening moves.
CREATE TABLE OpeningName (
	eco TEXT,
	name TEXT NOT NULL,
	PRIMARY KEY (eco)
);


-- A tuple in this relation represents the probabilities of game status
-- when an opening is applied to the game.
-- eco is the standardised code for any given opening, win is the probability
-- of winning, draw is the probability of draw,
-- and lose is the probability of losing.
CREATE TABLE Opening (
	eco TEXT,
	win FLOAT NOT NULL,
	CHECK (win >= 0.0 AND win <= 1.0),
	draw FLOAT NOT NULL,
	CHECK (draw >= 0.0 AND draw <= 1.0),
	lose FLOAT NOT NULL,
	CHECK (lose >= 0.0 AND lose <= 1.0),
	PRIMARY KEY (eco),
	FOREIGN KEY (eco) REFERENCES OpeningName(eco)
);

-- A tuple in this relation represents some basic information of a chess game.
-- gID is the chess game's ID, status is the final status of it, winner is the
-- colour of chess held by the winning player, eco is the standardised code
-- for any given opening, ply is the number of moves in the opening phase,
-- and increment is the time+increment for the chess game.
CREATE TABLE Game (
	gID TEXT,
	status TEXT NOT NULL,
	CHECK (status IN ('outoftime', 'resign', 'mate', 'draw')),
	winner TEXT NOT NULL,
	CHECK (winner IN ('black', 'white', 'draw')),
	eco TEXT NOT NULL,
	ply INT NOT NULL,
	increment TEXT NOT NULL,
	PRIMARY KEY (gID),
	FOREIGN KEY (eco) REFERENCES OpeningName(eco)
);

-- A tuple in this relation represents a player's situation in a chess game.
-- pID is the player's ID, gID is the chess game's ID, piece is the colour of
-- chess held by the player, and rating is the score representing how well
-- the player played in the chess game.
CREATE TABLE Player (
	pID TEXT,
	gID TEXT,
	piece TEXT NOT NULL,
	CHECK (piece IN ('black', 'white')),
	rating INT NOT NULL,
	PRIMARY KEY (pID, gID),
	FOREIGN KEY (gID) REFERENCES Game(gID)
);
