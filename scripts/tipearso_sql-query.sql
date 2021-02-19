--1
--select count(*) from data_analyst_jobs;

--2
/*
select company from data_analyst_jobs
limit 10;
answer:ExxonMobil
*/

--3
/*
select count(*) from data_analyst_jobs
where location = 'TN';
answer:21 

select count(*) from data_analyst_jobs
where location = 'TN'
	OR location = 'KY'

answer: 27
*/

--4
/*
select count(*) from data_analyst_jobs
WHERE location = 'TN'
	AND star_rating >4
answer: 3
*/
--5
/*
SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500
	AND 1000;
--answer: 151
*/

--6

SELECT AVG(star_rating) AS avg_rating, company, location AS state FROM data_analyst_jobs
GROUP BY company, location
ORDER BY avg_rating DESC;
--what is the pseudocode for thisi one? 