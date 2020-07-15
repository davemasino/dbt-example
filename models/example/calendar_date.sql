
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select dateadd(day, seq4(), '1987-01-01') as cal_date
    from table(generator(rowcount=>14000)) -- Number of days after reference date in previous line 

)
select 
    cal_date::date as cal_date
    ,year(cal_date)::int as year
    ,month(cal_date)::int as month
    ,monthname(cal_date)::string as month_name
    ,quarter(cal_date)::int as quarter
    ,('Q' || quarter(cal_date))::string as quarter_name
    ,('Q' || quarter(cal_date) || '-' || year(cal_date))::string as quarter_name_full
    ,day(cal_date)::int as day_of_mon
    ,dayofweek(cal_date)::string as day_of_week
    ,weekofyear(cal_date)::int as week_of_year
    ,dayofyear(cal_date)::int as day_of_year
    ,'dbt-test project'::string as create_process
    ,convert_timezone('UTC' , current_timestamp )::timestamp_ntz as create_ts
from source_data
