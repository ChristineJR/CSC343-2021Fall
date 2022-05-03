-- Load data from csv files.
SET SEARCH_PATH TO projectschema;

-- Load data from openingName_clean.csv without loading its header
\COPY openingname from openingName_clean.csv with csv header;

-- Load data from openings_clean.csv without loading its header
\COPY opening from openings_clean.csv with csv header;

-- Load data from games_clean.csv without loading its header
\COPY game from games_clean.csv with csv header;

-- Load data from whiteplayer_clean.csv without loading its header
\COPY player from whiteplayer_clean.csv with csv header;

-- Load data from blackplayer_clean.csv without loading its header
\COPY player from blackplayer_clean.csv with csv header;
