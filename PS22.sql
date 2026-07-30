--1. 
"""
Classify every customer as: 
 Platinum → Total spent > 50  
 Gold → Total spent between 30 and 50  
 Silver → Otherwise  

Display: 
 Customer Name  
 Total Spent  
 Customer Type 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(i.total) as total_spnt,
	case 
		when sum(i.total) > 50 then 'Platinum' 
		when sum(i.total) between 30 and 50 then 'Gold'
		else 'Silver'
	end as Classify
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1;

--2
"""
For every artist display: 
 Artist Name  
 Total Revenue  
 Revenue Percentage compared to all artists  
"""
select 
	ar.artist_id,
	ar.name,
	sum(il.unit_price * il.quantity) as total_revenue,
	  ROUND((SUM(il.unit_price * il.quantity) * 100.0/SUM(SUM(il.unit_price * il.quantity)) OVER ())::numeric,2) AS revenue_per
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t 
on al.album_id = t.album_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2

--3
"""
For every genre display: 
 Total Tracks  
 Sold Tracks  
 Unsold Tracks  
"""
SELECT
    t.track_id,
    t.name AS track_name,
	
    CASE
        WHEN il.track_id IS NULL THEN 'Unsold'
        ELSE 'Sold'
    END AS track_status

FROM track t

LEFT JOIN invoice_line il
ON t.track_id = il.track_id
	
ORDER BY t.track_id;
	
--4
"""
Find the top 5 customers based on total spending using RANK(). 

Display: 
 Customer Name  
 Total Spent  
 Rank  
"""
select 
	c.first_name,
	c.last_name,
	sum(i.total) as total_spent,
	rank() over(order by sum(i.total) desc) as rank_cus
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1,2
order by 3 desc
limit 5

--5
"""
For every employee display: 
 Customers Assigned  
 Total Revenue Generated  
 Revenue Rank  
"""
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,

    COUNT(DISTINCT c.customer_id) AS customers_assigned,

    SUM(i.total) AS total_revenue,

    RANK() OVER (
        ORDER BY SUM(i.total) DESC
    ) AS revenue_rank

FROM employee e

JOIN customer c
ON e.employee_id = c.support_rep_id::integer

JOIN invoice i
ON c.customer_id = i.customer_id

GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name

ORDER BY
    total_revenue DESC;
	
 