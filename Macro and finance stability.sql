create database macro_and_finance_stability;
use macro_and_finance_stability;

select * from economics;
show tables from macro_and_finance_stability;
show columns from economics;
describe economics;

 --- duplicate check ---
select country_code,year,count(country_code),count(year) from economics group by country_code,year having count(country_code)>1 and count(year)>1;
 ----- null value check--------------
 select*from economics where `gdp_ growth_rate` is null;
SELECT *
FROM economics
WHERE `gdp_ growth_rate` IS NULL;
ALTER TABLE economics
CHANGE `gdp_ growth_rate` gdp_growth_rate DOUBLE;
select*from economics where country_name is null or country_code is null or region is null or income_group is null or
year is null or cpi is null or int_rate is null or gdp_growth_rate is null or gdp is null or exchange_rate is null or unemployment_rate is null ;  

 ------------- changing the data type----------------
alter table economics 
modify column country_name varchar(100),
modify column country_code varchar(20),
modify column region varchar(100),
modify column income_group varchar(100);

alter table economics
modify column year int,
modify column cpi decimal(10,2),
modify column int_rate decimal(10,2),
modify column gdp_growth_rate decimal(10,2),
modify column gdp decimal(20,2),
modify column exchange_rate decimal(20,2),
modify column unemployment_rate decimal(10,2);

select*from economics;
--------- 
select country_name,year,gdp from economics where country_name='India' and year=2020;
select country_name,gdp from economics where year=2023 order by gdp desc limit 10;
select country_name,unemployment_rate from economics where unemployment_rate>15 and year=2010;
select country_name,gdp_growth_rate from economics where gdp_growth_rate<0 and year=2009;
select year,cpi from economics where cpi>10 and country_name='India';
select country_name,exchange_rate from economics where exchange_rate>100;
select Region, count(distinct country_code)as total_countries from economics group by region order by total_countries desc;
select income_group,avg(gdp) as avg_gdp from economics where year = 2022 group by income_group  order by avg_gdp desc;
select year,cpi from economics where country_name = 'United Arab Emirates' order by year;
select country_name,unemployment_rate from economics where region = 'Sub-Saharan Africa' and unemployment_rate>20;
select year,country_name,gdp from economics where country_name in('United States','China') order by year,country_name;
Select country_name, year, cpi from economics order by cpi desc limit 1;

select country_name,max(gdp)-min(gdp) as gdp_change from economics group by country_name order by gdp_change;
select distinct a.country_name from economics a join economics b on a.country_name=b.country_name and a.year=b.year-1
join economics c on a.country_name=c.country_name and a.year=c.year-2 
where a.int_rate>b.int_rate and b.int_rate>c.int_rate;
SELECT region, year, gdp_growth_rate
FROM (
     SELECT region, year, gdp_growth_rate,
            ROW_NUMBER() OVER(PARTITION BY region ORDER BY gdp_growth_rate DESC) AS rn
     FROM economics
) x
WHERE rn = 1;
WITH ranked AS (
    SELECT year, country_name, gdp,
           DENSE_RANK() OVER(PARTITION BY year ORDER BY gdp DESC) AS gdp_rank
    FROM economics
)
SELECT *
FROM ranked
WHERE gdp_rank <= 3;

with move as (SELECT country_name, year,
       cpi, unemployment_rate,
       LEAD(cpi) OVER (PARTITION BY country_name ORDER BY year) AS next_cpi,
       LEAD(unemployment_rate) OVER (PARTITION BY country_name ORDER BY year) AS next_unemp
FROM economics) 
select *from move 
WHERE (next_cpi - cpi) * (next_unemp - unemployment_rate) > 0;

with gdp_level as 
(SELECT country_name, year, gdp, prev_gdp,
       ((gdp - prev_gdp) / prev_gdp) * 100 AS drop_percent
FROM (
    SELECT country_name, year, gdp,
           LAG(gdp) OVER (PARTITION BY country_name ORDER BY year) AS prev_gdp
    FROM economics
) as t )
select*from gdp_level
WHERE prev_gdp IS NOT NULL
  AND drop_percent <-20;
SELECT country_name, year,
       AVG(gdp) OVER (
           PARTITION BY country_name
           ORDER BY year
           ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
       ) AS moving_average_gdp
FROM economics;
SELECT region, AVG(cpi) AS avg_cpi
FROM economics
GROUP BY region
ORDER BY avg_cpi DESC
LIMIT 1;
select country_name,year,int_rate,cpi from economics where int_rate>cpi;
Select country_name,
       stddev(gdp) as gdp_volatility
from economics
group by country_name
order by gdp_volatility desc
limit 10;
SELECT income_group, country_name, gdp
FROM (
    SELECT income_group, country_name, gdp,
           ROW_NUMBER() OVER(PARTITION BY income_group ORDER BY gdp DESC) AS rn
    FROM economics
    WHERE year = 2024
) x
WHERE rn = 1;
SELECT 
    country_name,
    (
        (SUM(gdp * cpi) - (SUM(gdp) * SUM(cpi)) / COUNT(*))
        /
        SQRT(
            (SUM(gdp * gdp) - (SUM(gdp) * SUM(gdp)) / COUNT(*)) *
            (SUM(cpi * cpi) - (SUM(cpi) * SUM(cpi)) / COUNT(*))
        )
    ) AS gdp_cpi_corr
FROM economics
GROUP BY country_name
ORDER BY gdp_cpi_corr DESC;

SELECT DISTINCT a.country_name,a.gdp_growth_rate
FROM economics a
JOIN economics b  ON a.country_name = b.country_name  AND b.year  = a.year + 1
JOIN economics c  ON a.country_name = c.country_name  AND c.year  = a.year + 2
JOIN economics d  ON a.country_name = d.country_name  AND d.year  = a.year + 3
JOIN economics e  ON a.country_name = e.country_name  AND e.year  = a.year + 4
JOIN economics f  ON a.country_name = f.country_name  AND f.year  = a.year + 5
JOIN economics g  ON a.country_name = g.country_name  AND g.year  = a.year + 6
JOIN economics h  ON a.country_name = h.country_name  AND h.year  = a.year + 7
JOIN economics i  ON a.country_name = i.country_name  AND i.year  = a.year + 8
JOIN economics j  ON a.country_name = j.country_name  AND j.year  = a.year + 9
WHERE a.gdp_growth_rate > 0
  AND b.gdp_growth_rate > 0
  AND c.gdp_growth_rate > 0
  AND d.gdp_growth_rate > 0
  AND e.gdp_growth_rate > 0
  AND f.gdp_growth_rate > 0
  AND g.gdp_growth_rate > 0
  AND h.gdp_growth_rate > 0
  AND i.gdp_growth_rate > 0
  AND j.gdp_growth_rate > 0;



