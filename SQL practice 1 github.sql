select*
from dbo.retail

---total number of records
select 
count(*) as [total records]
from dbo.retail

--unique customers
select distinct
count(customer_id )as [unique customer id ]
from dbo.retail

--unique category(CTE)
with c as (
	select distinct *
	from dbo.retail)
select
count(category)
from c
-- find nulls
SELECT [transactions_id],
       [sale_date],
       [sale_time],
       [customer_id],
       [gender],
       [age],
       [category],
       [quantiy],
       [price_per_unit],
       [cogs],
       [total_sale]
FROM dbo.retail
WHERE [transactions_id] IS NULL
   OR [sale_date] IS NULL
   OR [sale_time] IS NULL
   OR [customer_id] IS NULL
   OR [gender] IS NULL
   OR [age] IS NULL
   OR [category] IS NULL
   OR [quantiy] IS NULL
   OR [price_per_unit] IS NULL
   OR [cogs] IS NULL
   OR [total_sale] IS NULL;
   -- delete nulls
   DELETE FROM dbo.retail
WHERE [transactions_id] IS NULL
   OR [sale_date] IS NULL
   OR [sale_time] IS NULL
   OR [customer_id] IS NULL
   OR [gender] IS NULL
   OR [age] IS NULL
   OR [category] IS NULL
   OR [quantiy] IS NULL
   OR [price_per_unit] IS NULL
   OR [cogs] IS NULL
   OR [total_sale] IS NULL;

   --11/5/2022
   select*
   from dbo.retail
   where sale_date = '11-5-2022'

   -- clothing/>4/nov.2022
   select*
   from dbo.retail
   where category = 'clothing' and  datepart(month,sale_date) = 11  and quantiy > 4

   --total sales per category
   select
   category,
   sum(total_sale)
   from dbo.retail
   group by category

   --avg sales / category beauty
   select
   category,
   avg(total_sale)
   from dbo.retail
   group by category
   having category='beauty'

   --total sales >1000
   select*
   from dbo.retail
   where total_sale > 1000

   select 
   category,
   gender,
   count(transactions_id)
   from dbo.retail
   group by category, gender

-- avg sales per year / month 
select*,
rank() over (partition by yeardate order by [avg_sales] desc) as ranking
from(
   select
   year(sale_date) as yeardate,
   month(sale_date) monthdate ,
   avg(total_sale) as [avg_sales]
   from dbo.retail
   group by year(sale_date),month(sale_date)
   )t
   order by yeardate ,ranking 

   -- top 5 customers
   select top(5) 
   customer_id,
   sum(total_sale) [total_sales]
   from dbo.retail
   group by customer_id
   order by sum(total_sale) desc

   --unique customers
select 
distinct(customer_id)
from dbo.retail
where category is not null
order by customer_id --order any category

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM dbo.retail
GROUP BY category --specefic 

--shifts / total orders
ALTER TABLE dbo.retail
ALTER COLUMN shifts VARCHAR(20);

UPDATE dbo.retail
SET shifts = 
    CASE 
        WHEN sale_time < '12:00:00' THEN 'morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'afternoon'
        WHEN sale_time > '17:00:00' THEN 'evening'
    END;

    select
    count(transactions_id) as [total orders],
    shifts
    from dbo.retail
    group by shifts

