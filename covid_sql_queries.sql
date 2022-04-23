
#########################################confirmed #######################################
# Analyze Time Series COVID-19 Data with SQL Window Functions
select min(date) 
from confirmed_covid;

select country,
province_state,
date,
confirmed_day 
from confirmed_covid 
where country in ('China') 
order by country, province_state;

# Total number of confirmed cases on a country and province level
# usual group by - simple syntax to calculate total number of confirmed cases per country and province_state
select country,
province_state,
sum(confirmed_day) as total_confirmed 
from confirmed_covid 
group by country,province_state;

# Finding the Daily Number of Confirmed Cases
select *, 
sum(confirmed_day) OVER(PARTITION by country,province_state order by date) as running_total 
from confirmed_covid 
where country ='China';

# the total sum of confirmed cases on a country and province/state level
select country,
province_state,
sum(deaths_day) 
from deaths_covid 
group by country,province_state;

# Creating a country-level summary of confirmed cases with ROLLUP
# you can use rollup to see totals - for example this can help to see total number of confirmed cases in country China 
select country,
province_state,
sum(confirmed_day) 
from confirmed_covid 
group by country,province_state with ROLLUP;

# Calculating a running total with OVER and PARTITION BY
# cummulative sum per each country by using window function in mysql
select *, 
sum(confirmed_day) OVER(PARTITION by country,province_state order by date) as cumulative_total 
from confirmed_covid;


# Calculating the daily percent change in confirmed cases
#increase or decrease of confirmed case per day
#for this I need data from previous day - lets use WF lag function and store a result in a temporary table

# (confirmed_day - confirmed_previous_day)/ confirmed_previous_day * 100

# creating two temporary result sets named confirmed_lag (assigns the previous day's value to the current row) 
# confirmed_percent_change (uses the confirmed_lag result set and calculates the percent change for each day).

WITH confirmed_lag as 
(
select *, 
lag(confirmed_day) OVER(PARTITION by country,province_state order by date) 
as confirmed_previous_day 
from confirmed_covid
),
confirmed_percent_change as 
(
select *,
COALESCE(round((confirmed_day - confirmed_previous_day)/confirmed_previous_day *100),0) as percent_change 
from confirmed_lag 
)

select *, 
CASE WHEN percent_change>0 then 'increase'
	WHEN percent_change=0 then 'no change' 
    else 'decrease' end  as trend 
from confirmed_percent_change 
where country='China';



# Using RANK to find the highest number of confirmed cases

with highest_no_of_confirmed as 
(
select *, 
rank() OVER(PARTITION by date order by confirmed_day desc) 
as highest_no_confirmed 
from confirmed_covid
)

select * 
from highest_no_of_confirmed 
where highest_no_confirmed=1 and date between '2022-03-20' and '2022-04-20' ;









