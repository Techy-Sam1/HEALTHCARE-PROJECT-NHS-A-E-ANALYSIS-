-- QUERY 1  Overall national performance by year

SELECT
    span,
    COUNT(provider_name) AS total_trusts,
    ROUND(AVG(pct_within_4hrs), 2) 
        AS avg_4hr_performance,
    SUM(total_attendances) AS total_attendances,
    SUM(over_4hrs) AS total_patients_over_4hrs
FROM nhs_dataset
GROUP BY span	
ORDER BY span;

-- QUERY 2 Trust rankings (worst to best)
-- WORSTS 10 

SELECT
span,
provider_name,
region,
total_attendances,
pct_within_4hrs AS performance_pct,
performance_gap AS gap_from_95_target,
over_4hrs AS patients_over_4hrs
FROM nhs_dataset
WHERE span = '2024_25'
ORDER BY pct_within_4hrs ASC
LIMIT 10;

-- BEST 10 
SELECT
    provider_name,
    region,
    total_attendances,
    pct_within_4hrs AS performance_pct,
    performance_gap AS gap_from_95_target,
    over_4hrs AS patients_over_4hrs
FROM nhs_dataset
WHERE span = '2024_25'
ORDER BY pct_within_4hrs DESC
LIMIT 10;

-- QUERY 3 - Year on year improvement vs decline
SELECT
    a.provider_name,
    a.region,
    a.pct_within_4hrs AS performance_2022_23,
    b.pct_within_4hrs AS performance_2024_25,
    ROUND(b.pct_within_4hrs - 
          a.pct_within_4hrs, 2) AS changes,
    CASE
        WHEN b.pct_within_4hrs > a.pct_within_4hrs
        THEN 'IMPROVED'
        WHEN b.pct_within_4hrs < a.pct_within_4hrs
        THEN 'DECLINED'
        ELSE 'NO CHANGE'
    END AS trend
FROM nhs_dataset a
JOIN nhs_dataset b
    ON a.provider_code = b.provider_code
WHERE a.span = '2022_23'
AND b.span = '2024_25'
ORDER BY changes DESC;



-- QUERY 4 Scale of the crisis [Total patients waiting over 4 hours across all Trusts and all 3 years combined]

SELECT span, 
sum(total_attendances) as total_attendances, 
sum(OVER_4HRS) as total_over_4hours,
round(sum(over_4hrs) * 100.0/sum(total_attendances),2) as pct_patient_failed
from nhs_dataset
group by span
order by span;



-- QUERY 5 — Performance gap analysis Average gap between actual performance and 95% target, by year


SELECT 
span,
count(provider_name) as total_trust,
sum(case when pct_within_4hrs >= 95 then 1 else 0 end) as trusts_hitting_95_target,
sum(case when pct_within_4hrs >= 78 then 1 else 0 end) as trusts_hitting_78_target,
sum(case when pct_within_4hrs < 78 then 1 else 0 end)  as trusts_below_78_target,
round(avg(performance_gap), 2) as Average_gap_from_95
from nhs_dataset
group by span
order by span;


-- QUERY 6 — Local Trust analysis How does South Tyneside and Sunderland NHS Foundation Trust compare to the national average across all 3 years?]

SELECT
    span,
    provider_name,
    region,
    total_attendances,
    pct_within_4hrs AS performance_pct,
    performance_gap,
    over_4hrs AS patients_over_4hrs
FROM nhs_dataset
WHERE provider_name LIKE '%SUNDERLAND%'
ORDER BY span;




-- Query 7 — Sunderland vs National Average Show Sunderland side by side with the national average each year. 

select a.span,
a.provider_name,
a.pct_within_4hrs AS sunderland_performance,
b.national_avg,
ROUND(a.pct_within_4hrs - b.national_avg, 2) as difference,
CASE 
WHEN a.pct_within_4hrs > b.national_avg
THEN 'ABOVE AVERAGE'
ELSE 'BELOW AVERAGE'
END AS vs_national
FROM nhs_dataset a
JOIN (SELECT 
span,
ROUND(AVG(pct_within_4hrs), 2)
AS national_avg
FROM nhs_dataset
GROUP BY span)
b ON a.span = b.span
WHERE a.provider_name LIKE '%SUNDERLAND%'
ORDER BY a.span; 



-- Query 8 — Performance by Region Which region performs best and worst? 
-- How does North East and Yorkshire compare to London and South East? 


SELECT 
span,
region,
Count(*) as total_trust,
round(avg(pct_within_4hrs), 2) as average_performance,
round(AVG(performance_gap), 2) as Average_performance_gap_from_95,
sum(total_attendances) as total_attendances,
sum(over_4hrs) as over_4hrs
from nhs_dataset
GROUP BY span, region
ORDER BY span, average_performance DESC;


-- Chronic Underperformers Which Trusts were below 70% in ALL 3 years? Never improved at all. 

select 
provider_name,
region,
MAX(CASE WHEN span  = '2022_23' THEN pct_within_4hrs END) as performance_2022_23,
MAX(CASE WHEN span = '2023_24' THEN pct_within_4hrs END) as performance_2023_24,
MAX(CASE WHEN span = '2024_25' THEN pct_within_4hrs END) as performance_2024_25
FROM  nhs_dataset
GROUP BY provider_name, region
HAVING MAX(CASE WHEN span = '2022_23' THEN pct_within_4hrs END) < 70
AND
MAX(CASE WHEN span = '2023_24' THEN pct_within_4hrs END) < 70
AND
MAX(CASE WHEN span = '2024_25' THEN pct_within_4hrs END) < 70

ORDER BY performance_2024_25 ASC;


-- Query 10 — Attendance Growth How much have attendances grown year on year? Is demand outpacing any improvement?

select
span,
count(*) as total_trusts,
sum(total_attendances) as total_attendances,
sum(over_4hrs) as total_patient_over_4hrs,
round(sum(over_4hrs) * 100 / sum(total_attendances), 2) as percentage_patient_failed
from nhs_dataset
group by span
order by span;

select * from nhs_dataset;

select sum(OVER_4HRS) from nhs_dataset;





SELECT COUNT(*) as A_LL,from nhs_dataset where PCT_WITHIN_4HRS> 78