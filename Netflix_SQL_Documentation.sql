create database netflix;
-- Revenue by Subscription Plan
-- Overall Churn Rate
-- Churn by Plan
-- Most Watched Genres
 -- Best Rated Genres
-- Device Performance
-- Time of Day Analysis
-- Recommendation Source Analysis
-- Top 10 Titles
-- Genre-wise Churn Analysis

-- =====================================================
-- NETFLIX USER ENGAGEMENT ANALYTICS PROJECT
-- Author: Amit Kumar
-- Tools: MySQL, Excel, Power BI
-- =====================================================

 -- QUERY 1:Revenue by Subscription Plan
 
use netflix;
SELECT
subscription_plan,
COUNT(distinct ï»¿Show_id) AS Users,
sum(case when churn_status = 'Active' then 1 else 0 end ) as Buyers ,
ROUND(SUM(case when churn_status = 'Active' then monthly_fee end),2) AS Revenue
FROM netflix_data
GROUP BY 1
ORDER BY 4 DESC;

--  Query 2 : Overall Churn Rate
SELECT
ROUND(
100.0 * SUM(CASE WHEN churn_status='Cancelled' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS churn_rate
FROM netflix_data;


 -- QUERY 3: Churn by Plan 
 
 SELECT
subscription_plan,
COUNT(distinct ï»¿Show_id)  AS Users,
SUM(CASE WHEN churn_status='Cancelled' THEN 1 ELSE 0 END) AS churned_users,
ROUND(
100.0 * SUM(CASE WHEN churn_status='Cancelled' THEN 1 ELSE 0 END)
/ COUNT(distinct ï»¿Show_id),2
) AS churn_rate
FROM netflix_data 
GROUP BY 1
order by 3 desc;




-- Query 4  : Most Watched Genre

select 
genre,
count(distinct ï»¿Show_id) as Watchers,
avg(watch_time_minutes) as Spend_time_watchers_per_min
from netflix_data
group by 1
order by 3;


-- Query 5  : Engagement by Subscription  Plan and Viwer Type
SELECT
subscription_plan,
Viwer_Type,
ROUND(AVG(watch_time_minutes),2) AS avg_watch_time,
ROUND(AVG(session_count),2) AS avg_sessions
FROM netflix_data
GROUP BY 1,2
order by 3 desc;


-- Query 6  :Genre-wise Churn Analysis

select 
genre,
count(distinct ï»¿Show_id) as Watchers,
ROUND(AVG(rating),2) AS avg_rating,
SUM(CASE WHEN churn_status='Cancelled' THEN 1 ELSE 0 END) AS churned_users,
avg(watch_time_minutes) as Spend_time_watchers_per_min,
avg(session_count) as avg_session_count,
ROUND(
100.0 * SUM(CASE WHEN churn_status='Cancelled' THEN 1 ELSE 0 END)
/ count(distinct ï»¿Show_id),2) as Genre_wise_Churn_Analysis
from netflix_data
group by 1
order by 7 desc;

-- Query 7 : Recommendation Source Analysis

SELECT
recommendation_source,
COUNT(distinct ï»¿Show_id) AS Users,
ROUND(AVG(rating),2) AS avg_rating,
ROUND(AVG(watch_time_minutes),2) AS avg_watch_time,
sum(case when churn_status = 'Active' then 1 else 0 end ) as Recommendation_by_Users_that_Active
FROM netflix_data
GROUP BY 1
ORDER BY 5 DESC;

-- Query 7 : Top 10 Titles
select
title,
count(distinct ï»¿Show_id) as Users,
ROUND(AVG(rating),2) AS avg_rating
from netflix_data
group by 1
order by 2 desc
limit 10;

-- Query 8 :Time of Day Analysis with device Type

SELECT
device_type,
time_of_day,
ROUND(AVG(watch_time_minutes),2) AS avg_watch_time
FROM netflix_data
GROUP BY 1,2
ORDER BY 3 DESC;

