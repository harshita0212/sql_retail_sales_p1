-- sql retail sales analysis -p1
create database sql_project_p2;

create table retail_sales
(
	transactions_id	 int primary key,
	sale_date date,
	sale_time time,
	customer_id	int,
	gender varchar(15),
	age	int,
	category varchar(15),	
	quantiy	int,
	price_per_unit float,	
	cogs float,
	total_sale float
)
select * from retail_sales;

select count(*) from retail_sales


-- null values
select * from retail_sales
where transactions_id  is null

select * from retail_sales
where sale_date  is null

select * from retail_sales
where sale_time  is null

select * from retail_sales
where transactions_id is null
or sale_date  is null or sale_time  is null or 
gender  is null or 
customer_id is null or age is null or category is null 
or quantiy is null or price_per_unit is null or cogs is null
or total_sale is null

delete from retail_sales
where transactions_id is null
or sale_date  is null or sale_time  is null or 
gender  is null or 
customer_id is null or age is null or category is null 
or quantiy is null or price_per_unit is null or cogs is null
or total_sale is null


-- data exploration

-- how many sales we have
select count(*) as total_sale from retail_sales


select count(distinct customer_id) as total_customers from retail_sales
select distinct category from retail_sales

-- data analysis
1.
select * from retail_sales
where sale_date = '2022-11-05' 

2.
select  *
from retail_sales
where category = 'Clothing' 
and to_char(sale_date, 'YYYY-MM') = '2022-11'
and quantiy >=4 

3.
select 
category, 
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1 

4.
select round(avg(age),2) as avg_age
from retail_sales
where category ='Beauty'

5.
select * 
from retail_sales 
where total_sale >= 1000

6.
select 
category,
gender,
count(*) as total_trans
from retail_sales
group by 1, 2


7.
select 
year, month, avg_sale
from(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank () over(partition by extract(year from sale_date) order by avg(total_sale)desc) as rank
from retail_sales
group by 1,2
) as t1
where rank = 1


8. 
select
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5


9.

select category, 
count(distinct(customer_id)) as unique_customers
from retail_sales
group by category


10. 
with hourly_sale
as(
select *,
case
when extract(hour from sale_time)<12  then 'Morning' 
when extract(hour from sale_time)between 12 and 17  then 'Afternon'
else 'Evening'
end as shift
from retail_sales
)
select shift, count(*) as total_orders
from hourly_sale
group by shift









