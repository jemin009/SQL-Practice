--1
select 
	c.customer_id,
	c.first_name || ' ' || c.last_name as Customer_name,
	i.billing_country,
	count(i.invoice_id) as total_invoices,
	sum(i.total) as total_spending,
	avg(i.total) as avg_invoice_value
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3

having sum(i.total) > 50;

--2
select 
	i.billing_country,
	count(distinct c.customer_id) as numebr_of_customers,
	count(distinct i.invoice_id) as number_of_invoices,
	sum(il.unit_price * il.quantity) as total_revenue,
	avg(il.unit_price * il.quantity) as avg_customer_spending
from customer c

join invoice i
on c.customer_id = i.customer_id

join invoice_line il
on i.invoice_id = il.invoice_id

group by 1

having count(distinct c.customer_id) > 5;

--3
select
	g.name,
	count(distinct t.track_id) as number_of_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
from genre g

join track t
on g.genre_id = t.genre_id 

join invoice_line il
on t.track_id = il.track_id

group by 1;

--4
select 	
	c.first_name || ' ' || c.last_name as customer_name,
	i.billing_country,
	sum(il.unit_price * il.quantity) as total_spending,
	RANK() OVER(PARTITION BY i.billing_country ORDER BY SUM(il.unit_price * il.quantity) DESC)
from customer c

join invoice i
on c.customer_id = i.customer_id

join invoice_line il
on i.invoice_id = il.invoice_id 

group by 1,2;

--5
with artist_revenue as (
	select 
		ar.name,
		sum(il.unit_price * il.quantity) as revenue,
		rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
	from artist ar

	join album al
	on ar.artist_id = al.artist_id 

	join track t
	on al.album_id = t.album_id 

	join invoice_line il
	on t.track_id = il.track_id 

	group by 1
)

select * from artist_revenue
where revenue > (select avg(revenue) from artist_revenue);

--6
WITH monthly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM i.invoice_date) AS year_,
        EXTRACT(MONTH FROM i.invoice_date) AS month_,
        SUM(i.total) AS total_revenue
    FROM invoice i
    GROUP BY 1, 2
)

SELECT
    year_,
    month_,
    total_revenue,
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank,
    total_revenue - AVG(total_revenue) OVER() AS difference_from_average
FROM monthly_revenue

ORDER BY 1,2;

--7
select 
	tr.name,
	ar.name,
	al.title,
	g.name,
	sum(il.quantity) as copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id

join track tr
on al.album_id = tr.album_id 

join invoice_line il
on tr.track_id = il.track_id

join genre g
on tr.genre_id = g.genre_id

group by 1,2,3,4

--8
select 
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct tr.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as percentages
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
from 
