

--How many rows are in the data_analyst_jobs table?
	--1793

SELECT COUNT(*)
FROM data_analyst_jobs;

--Write a query to look at just the first 10 rows. What company is associated 
	--with the job posting on the 10th row?
	-- Exxon Mobil
SELECT *
FROM data_analyst_jobs
lIMIT 10


--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
		-- top query lists the states individually and the second query just gives the same thing.
		-- if you left out location from your select statment and the group by clause you 
		-- would just get the number 27.
		
;SELECT COUNT(*), location
FROM data_analyst_jobs
WHERE location IN ('TN','KY')
GROUP BY location;

--OR

;SELECT COUNT(*), location
FROM data_analyst_jobs
WHERE location = 'TN'
	OR location = 'KY'
GROUP BY location

--or 
;SELECT COUNT(*)
FROM data_ANALYST_JOBS
WHERE location = 'TN'
	OR LOCATION = 'KY'
	
--How many postings in Tennessee have a star rating above 4?
	-- below query gets some more useful information than just the count. 
	--not part of the question but I didt it for fun.
	--answer is 3
;SELECT company, skill, star_rating, COUNT(*)
FROM data_analyst_jobs
WHERE star_rating > 4
	AND location = 'TN'
GROUP BY company, skill, star_rating;

--How many postings in the dataset have a review count between 500 and 1000?
	--151
SELECT COUNT (*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--Show the average star rating for companies in each state. 
	--the output should show the state as state and the average 
	--rating for the state as avg_rating. Which state shows the 
	--highest average rating?
	-- Nebraska with 4.2
	
SELECT location AS state, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY state
	--note how you can use an alias in a GROUP BY or ORDER BY
	--I'm sure I did that at some point but didn't make a note of it.
ORDER BY avg_rating DESC;
-- Here's a query from ANDREW that drills a little deeper:
SELECT location as state, ROUND(AVG(star_rating),2) avg_stars
FROM (SELECT DISTINCT company, location, star_rating
	FROM data_analyst_jobs
	WHERE location IS NOT NULL and star_rating IS NOT NULL) sub
GROUP BY location
ORDER BY avg_stars DESC;


--Select unique job titles from the data_analyst_jobs table. 
	--How many are there?
	--881
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--How many unique job titles are there for California companies?
	--230
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--Find the name of each company and its average star rating 
--for all companies that have more than 5000 reviews across all locations. 
--How many companies are there with more that 5000 reviews across all locations?
	-- for some reason when I first did this one I made a subquery 
	--with a bunch of aliases...
	--this time when I sat down to do it I came up with the below query and then added
	--ORDER BY and alias for AVG when I looked at my notes and saw that was what Richie did...
	--feels good to come up with a more concise query on my own(!!)

SELECT company, ROUND(AVG(star_rating),2)as avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;

--Add the code to order the query in #9 from highest to lowest average star rating. 
	--Which company with more than 5000 reviews across all locations in the dataset 
	--has the highest star rating? What is that rating?
	--Unilever(?) When I increase the number for 
	--the round function all I get is more zero...Unilever is correct. the unrounded
	--number is 4.199999something...
		--see above


--Find all the job titles that contain the word ‘Analyst’.
	-- How many different job titles are there?
	--774
SELECT DISTINCT COUNT(title), title
FROM data_analyst_jobs
WHERE title iLike '%Analyst%'
GROUP BY title;

--How many different job titles do not contain either the word ‘Analyst’ 
	--or the word ‘Analytics’? 
	--What word do these positions have in common?
	-- There are four and they all contain the word "Tableau"
	
SELECT DISTINCT COUNT(title), title
FROM data_analyst_jobs
WHERE title NOT iLike '%Analy%' 
GROUP BY title;


--BONUS: 
--You want to understand which jobs requiring SQL are hard to fill
--Disregard any postings where the domain is NULL.
--Order your results so that the domain with the 
	--greatest number of hard to fill jobs is at the top.
--Which three industries are in the top 4 on this list? 
--How many jobs have been listed for more than 3 weeks for each of the top 4?
	
	--Not sure what you are looking for here. 
	--My Query has Real Estate at the top but there are 10 different postings 
	--that have the same number in the "days_since_posting" column.


SELECT DISTINCT COUNT(domain), title, domain, days_since_posting
FROM data_analyst_jobs
WHERE domain IS NOT NULL AND 
	skill LIKE 'SQL'
GROUP BY domain, title, days_since_posting
ORDER BY days_since_posting DESC;

SELECT *
FROM data_analyst_jobs


