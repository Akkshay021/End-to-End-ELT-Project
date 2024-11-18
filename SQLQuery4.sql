CREATE TABLE [dbo].[netflix_raw](
	[show_id] [varchar](10) NULL,
	[type] [varchar](10) NULL,
	[title] [nvarchar](200) NULL,
	[director] [varchar](300) NULL,
	[cast] [varchar](1000) NULL,
	[country] [varchar](150) NULL,
	[date_added] [varchar](25) NULL,
	[release_year] [int] NULL,
	[rating] [varchar](10) NULL,
	[duration] [varchar](15) NULL,
	[listed_in] [varchar](100) NULL,
	[description] [varchar](500) NULL)

SELECT * FROM netflix_raw;
ALTER TABLE netflix_raw
ALTER COLUMN show_id VARCHAR(10) NOT NULL;

ALTER TABLE netflix_raw
ADD CONSTRAINT PK_show_id PRIMARY KEY (show_id);

USE Netflix_Analysis

-- handling foreign characters

-- removing duplicates
WITH CTE1 AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY type,title ORDER BY show_id) as rn 
FROM netflix_raw)
SELECT * INTO Unique_Movies FROM CTE1 where rn = 1

-- new table for listed in, director, country, cast
SELECT show_id, TRIM(value) AS director
into netflix_director
FROM netflix_raw
cross apply string_split(director,',')

SELECT show_id, TRIM(value) AS cast
into netflix_cast
FROM netflix_raw
cross apply string_split(cast,',')

SELECT show_id, TRIM(value) AS listed_in
into netflix_listed_in
FROM netflix_raw
cross apply string_split(listed_in,',')

SELECT show_id, TRIM(value) AS country
into netflix_country
FROM netflix_raw
cross apply string_split(country,',')

-- datatype conversion for date added
WITH CTE1 AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY type,title ORDER BY show_id) as rn 
FROM netflix_raw)
SELECT show_id, type, title, 
cast(date_added as date) as date_added, release_year, rating, 
CASE WHEN duration is null THEN rating ELSE duration END AS duration, description
into netflix
FROM CTE1 where rn = 1

INSERT INTO netflix_country
SELECT show_id, m.country 
from netflix_raw nr
INNER JOIN (
SELECT director, country 
FROM netflix_country nc
INNER JOIN netflix_director nd ON nc.show_id = nd.show_id
GROUP BY director, country) m on nr.director = m.director
WHERE nr.country IS NULL

--------------
