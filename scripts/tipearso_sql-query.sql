
--1. How many rows are in the data_analyst_jobs table?
/*select count(*) from data_analyst_jobs;

--answer 1793

--2. Write a query to look at just the first 10 rows. 
--What company is associated with the job posting on the 10th row?

select company from data_analyst_jobs
limit 10;
answer:ExxonMobil


--3. How many postings are in Tennessee? 
--How many are there in either Tennessee or Kentucky?

select count(*) from data_analyst_jobs
where location = 'TN';
answer:21 

select count(*) from data_analyst_jobs
where location = 'TN'
	OR location = 'KY'

answer: 27


--4. How many postings in Tennessee have a star rating above 4?
	
select count(*) from data_analyst_jobs
WHERE location = 'TN'
	AND star_rating >4
answer: 3

--5. How many postings in the dataset have a review count between 500 and 1000? 

SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500
	AND 1000;
--answer: 151
*/

/*
--6 Show the average star rating for companies in each state. 
--The output should show the state as state and the average rating for the state as avg_rating. 
--Which state shows the highest average rating?

SELECT ROUND(AVG(star_rating),2) AS avg_rating, location AS state
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC ;

answer: Nebraska 4.2 average rating

--From Andrew Marsee to Everyone:  12:53 PM
--drills down a little more into 
SELECT location as state, ROUND(AVG(star_rating), 2) as avg_stars
FROM (SELECT DISTINCT company, location, star_rating
	FROM data_analyst_jobs
	WHERE location IS NOT NULL and star_rating IS NOT NULL) sub
GROUP BY location
ORDER BY avg_stars DESC;

--7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT (title))
FROM data_analyst_jobs;

ANSWER: 881

--8. How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT (title)), location
FROM data_analyst_jobs
WHERE location = 'CA'
GROUP BY location;

answer: 230

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. 
--How many companies are there with more that 5000 reviews across all locations?

--company name and AVG rating:

SELECT s.company, s.avg_rating
FROM
	(SELECT company, COUNT (DISTINCT(company)),
	 ROUND(AVG(star_rating),2) AS avg_rating, review_count 
	FROM data_analyst_jobs
	WHERE review_count IS NOT NULL
	GROUP BY company, review_count) AS S
WHERE s.review_count > 5000
GROUP BY s.company,s.avg_rating

--from Richie:
SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;

--answer :41 companies


--10 Add the code to order the query in #9 from highest to lowest average star rating. 
--Which company with more than 5000 reviews 
--cross all locations in the dataset has the highest star rating? What is that rating?

SELECT s.company, s.avg_rating
FROM
	(SELECT company, COUNT (DISTINCT(company)),
	 ROUND(AVG(star_rating),2) AS avg_rating, review_count 
	FROM data_analyst_jobs
	WHERE review_count IS NOT NULL
	GROUP BY company, review_count) AS S
WHERE s.review_count > 5000
GROUP BY s.company,s.avg_rating
ORDER BY s.avg_rating DESC

--ANSWER: AMERICAN EXPRESS, 4.20


--11. Find all the job titles that contain the word ‘Analyst’. 
--How many different job titles are there?
--titles of job titles:

SELECT  title, COUNT(*) OVER()
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'

--number OF job titles:

SELECT COUNT (Distinct title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
--answer 774


-- 12. How many different job titles do not contain either 
--the word ‘Analyst’ or the word ‘Analytics’? 
--What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%analytics%'

--answer: Tableau
*/

/*
--bonus
BONUS: You want to understand which jobs requiring SQL are hard to fill.
Find the number of jobs by industry (domain) that require SQL and have been posted 
longer than 3 weeks.

Disregard any postings where the domain is NULL.
Order your results so that the domain with the greatest number of hard to fill jobs is at 
the top.
Which three industries are in the top 4 on this list? 
How many jobs have been listed for more than 3 weeks for each of the top 4?
--NB  Including columns you don't need to see can mess up data(i.e. "Days_since_posting")
*/

SELECT DISTINCT domain AS industry, COUNT(title) AS hard_to_fill
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
AND domain NOT like 'NULL'
AND days_since_posting > 21
GROUP BY domain
ORDER BY hard_to_fill DESC





