Analyze time series COVID-19 data with SQL

1. confirmed_covid.csv file is created with the help of R code named transforming_and_loading_data.R
This csv is loaded into the mysql database - table confirmed_covid is created and used in an article

2. transforming_and_loading_data.R - this R scripts takes three csv files that are provided by John Hopkins and then they are transformed 
and loaded into the database. For the purpose of the article you don't need all three files from John H. github page
(you need just one named time_series_covid19_confirmed_global.csv). 

3. donwload csv from John H. :
wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv
And then run R code. Data are loaded into Mysql (keep in mind that you need to have Mysql locally installed on your computer)

4. File covid_sql_queries.sql contain sql queries 
