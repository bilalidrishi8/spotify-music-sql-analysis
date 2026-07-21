-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);



SELECT * FROM spotify
SELECT COUNT(*) FROM spotify

-- Retrieve the names of all tracks that have more than 1 billion streams.
SELECT * FROM spotify

  SELECT
    track,
    artist,
    stream
FROM spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- List all albums along with their respective artists.
SELECT * FROM spotify

SELECT DISTINCT
    album,
    artist
FROM spotify 
ORDER BY artist, album;

-- Get the total number of comments for tracks where licensed = TRUE.
SELECT * FROM spotify

SELECT
    SUM(comments) AS total_comments
FROM spotify
WHERE licensed = TRUE;

-- NEW method --

SELECT track,
SUM(comments) AS total_comments
FROM spotify
where licensed = 'true'
group by track, comments
order by total_comments desc



-- Find all tracks that belong to the album type single.
SELECT * FROM spotify

SELECT
    track,
    artist,
    album,
    album_type
FROM spotify
WHERE (album_type) = 'single'
ORDER BY artist, track;

-- Count the total number of tracks by each artist.
SELECT * FROM spotify

SELECT
    artist,
    COUNT(track) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;

-- Calculate the average danceability of tracks in each album.
SELECT * FROM spotify

SELECT
    album,
    ROUND(AVG(danceability), 2) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;

-- Find the top 5 tracks with the highest energy values.
SELECT * FROM spotify

SELECT track,
COUNT(energy) AS highest_energy
FROM spotify
GROUP BY track 
ORDER BY highest_energy DESC
LIMIT 5;

-- List all tracks along with their views and likes where official_video = TRUE.
SELECT * FROM spotify

SELECT
    track,
    artist,
    views,
    likes
FROM spotify
WHERE official_video = TRUE
ORDER BY views DESC;

-- For each album, calculate the total views of all associated tracks.
SELECT * FROM spotify

SELECT album,
COUNT(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;

-- Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * FROM spotify

SELECT
    track,
    artist,
    stream AS spotify_streams,
    views AS youtube_views
FROM spotify
WHERE stream > views
ORDER BY spotify_streams DESC;

-- Find the top 3 most-viewed tracks for each artist using window functions.
SELECT * FROM spotify

SELECT
    artist,
    track,
    views,
    ranking
FROM (
    SELECT
        artist,
        track,
        views,
        ROW_NUMBER() OVER (
            PARTITION BY artist
            ORDER BY views DESC
        ) AS ranking
    FROM spotify
) AS ranked_tracks
WHERE ranking <= 3
ORDER BY artist, ranking;


-- Write a query to find tracks where the liveness score is above the average.
SELECT * FROM spotify

SELECT
    track,
    artist,
    album,
    liveness
FROM spotify
WHERE liveness > (
    SELECT AVG(liveness)
    FROM spotify
)
ORDER BY liveness DESC;

--- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
SELECT * FROM spotify

WITH album_energy AS (
    SELECT
        album,
        MAX(energy) AS highest_energy,
        MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY album
)

SELECT
    album,
    highest_energy,
    lowest_energy,
    ROUND(highest_energy - lowest_energy, 2) AS energy_difference
FROM album_energy
ORDER BY energy_difference DESC;

-- Find the Artist with the Highest Total Streams
SELECT * FROM spotify
  
SELECT
    artist,
    SUM(stream) AS total_streams
FROM spotify
GROUP BY artist
ORDER BY total_streams DESC
LIMIT 1;

-- Find the Top 5 Albums with the Highest Average Views
SELECT * FROM spotify
  
SELECT
    album,
    ROUND(AVG(views), 2) AS average_views
FROM spotify
GROUP BY album
ORDER BY average_views DESC
LIMIT 5;

--END THE PROJECT--
