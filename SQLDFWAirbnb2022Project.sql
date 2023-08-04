/*
Airbnb Project
*/

--0. Notes and Declarations
-- list of columns:
-- id, name, host_id, host_name, neighbourhood, latitude, longitude, room_type, price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365, number_of_reviews_ltm

Use AirbnbProject;

-- If it doesn't work, try [database name].dbo.[table name]. Ex: SELECT * FROM [AirbnbProject].dbo.[listings#dallas#airbnb$]

--Creating "Combined Cities" Table, merging Dallas and Fort Worth tables together
CREATE TABLE combined_cities(
		id FLOAT, 
		name NVARCHAR(255), 
		host_id FLOAT, 
		host_name NVARCHAR(255), 
		neighbourhood NVARCHAR(255), 
		latitude FLOAT,
		longitude FLOAT, 
		room_type NVARCHAR(255),
		price FLOAT,
		minimum_nights FLOAT, 
		number_of_reviews FLOAT, 
		last_review NVARCHAR(255), 
		reviews_per_month FLOAT, 
		calculated_host_listings_count FLOAT, 
		availability_365 FLOAT, 
		number_of_reviews_ltm FLOAT
)
GO

INSERT combined_cities(id, name, host_id, host_name, neighbourhood, latitude, longitude, room_type, price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365, number_of_reviews_ltm)
	SELECT * FROM AirbnbProject.dbo.listings#dallas#airbnb$
	UNION ALL
	SELECT * FROM AirbnbProject.dbo.listings#fortworth#airbnb$;

-- Testing to see if tables work
SELECT * FROM AirbnbProject.dbo.listings#dallas#airbnb$;
SELECT * FROM AirbnbProject.dbo.listings#fortworth#airbnb$;
SELECT * FROM combined_cities;




-- 1. !Districts with the most Airbnb hostings

-- DALLAS TABLE
SELECT neighbourhood, COUNT(neighbourhood) AS "Count of ID"
FROM AirbnbProject.dbo.listings#dallas#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY COUNT(neighbourhood) DESC;

--SELECT DISTINCT(COUNT(neighbourhood)) AS "Count of ID"
--FROM AirbnbProject.dbo.listings#dallas#airbnb$
--GROUP BY neighbourhood;

-- FORT WORTH TABLE
SELECT neighbourhood, COUNT(neighbourhood) AS "Count of ID"
FROM AirbnbProject.dbo.listings#fortworth#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY COUNT(neighbourhood) DESC;

--SELECT DISTINCT(COUNT(neighbourhood)) AS "Count of ID"
--FROM AirbnbProject.dbo.listings#fortworth#airbnb$
--GROUP BY neighbourhood;

-- COMBINED CITIES TABLE
SELECT neighbourhood, COUNT(neighbourhood) AS "Count of ID"
FROM combined_cities
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY COUNT(neighbourhood) DESC;




-- 2. !Districts with the most reviews (reviews, per month, and long term)

-- DALLAS TABLE	
SELECT neighbourhood, SUM(number_of_reviews) AS "Number Of Reviews", SUM(reviews_per_month) AS "Reviews Per Month", SUM(number_of_reviews_ltm) AS "Long Term Reviews"
FROM AirbnbProject.dbo.listings#dallas#airbnb$
GROUP BY neighbourhood;

-- FORT WORTH TABLE
SELECT neighbourhood, SUM(number_of_reviews) AS "Number Of Reviews", SUM(reviews_per_month) AS "Reviews Per Month", SUM(number_of_reviews_ltm) AS "Long Term Reviews"
FROM AirbnbProject.dbo.listings#fortworth#airbnb$
GROUP BY neighbourhood;

-- COMBINED CITIES TABLE
SELECT neighbourhood, SUM(number_of_reviews) AS "Number Of Reviews", SUM(reviews_per_month) AS "Reviews Per Month", SUM(number_of_reviews_ltm) AS "Long Term Reviews"
FROM combined_cities
GROUP BY neighbourhood;




-- 3. and 4. !Average Airbnb price in a district

-- DALLAS TABLE, average price of each Dallas district
SELECT neighbourhood, AVG(price) AS "Average Price"
FROM AirbnbProject.dbo.listings#dallas#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY neighbourhood ASC;

-- FORT WORTH TABLE, average price of each Fort Worth district
SELECT neighbourhood, AVG(price) AS "Average Price"
FROM AirbnbProject.dbo.listings#fortworth#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY neighbourhood ASC;

-- COMBINED CITIES TABLE, average price of each district combined
SELECT neighbourhood, AVG(price) AS "Average Price"
FROM combined_cities
WHERE neighbourhood IS NOT NULL
GROUP BY neighbourhood
ORDER BY neighbourhood ASC;

-- DALLAS TABLE, by different room types
SELECT neighbourhood, room_type, AVG(price) AS "Average Price"
FROM AirbnbProject.dbo.listings#dallas#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY room_type, neighbourhood
ORDER BY room_type, neighbourhood ASC;

-- FORT WORTH TABLE, by different room types
SELECT neighbourhood, room_type, AVG(price) AS "Average Price"
FROM AirbnbProject.dbo.listings#fortworth#airbnb$
WHERE neighbourhood IS NOT NULL
GROUP BY room_type, neighbourhood
ORDER BY room_type, neighbourhood ASC;

-- COMBINED CITIES TABLE, by different room types
--(each district per entire home/apt, private room, and shared room)
SELECT neighbourhood, room_type, AVG(price) AS "Average Price"
FROM combined_cities
WHERE neighbourhood IS NOT NULL
GROUP BY room_type, neighbourhood
ORDER BY room_type, neighbourhood ASC;